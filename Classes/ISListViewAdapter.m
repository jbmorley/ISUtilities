//
// Copyright (c) 2013 InSeven Limited.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// 

#import "ISListViewAdapter.h"
#import "ISNotifier.h"
#import "ISListViewAdapterItem.h"
#import "ISListViewAdapterItemBlock.h"

typedef enum {
  ISDBViewStateInvalid,
  ISDBViewStateCount,
  ISDBViewStateValid
} ISDBViewState;


@interface ISListViewAdapter ()

@property (nonatomic) ISDBViewState state;
@property (strong, nonatomic) id<ISListViewAdapterDataSource> dataSource;
@property (strong, nonatomic) NSArray *entries;
@property (strong, nonatomic) NSMutableDictionary *entriesByIdentifier;
@property (strong, nonatomic) ISNotifier *notifier;
@property (nonatomic) dispatch_queue_t dispatchQueue;
@property (nonatomic) dispatch_queue_t comparisonQueue;

@end

NSInteger ISDBViewIndexUndefined = -1;

@implementation ISListViewAdapter


- (id)initWithDataSource:(id<ISListViewAdapterDataSource>)dataSource
{
  return [self initWithDispatchQueue:dispatch_get_main_queue()
                          dataSource:dataSource];
}


- (id)initWithDispatchQueue:(dispatch_queue_t)dispatchQueue
                 dataSource:(id<ISListViewAdapterDataSource>)dataSource
{
  self = [super init];
  if (self) {
    self.dispatchQueue = dispatchQueue;
    self.dataSource = dataSource;
    self.state = ISDBViewStateInvalid;
    self.notifier = [ISNotifier new];
    
    if ([self.dataSource respondsToSelector:@selector(initialize:)]) {
      [self.dataSource initialize:[[ISDBViewReloader alloc] initWithView:self]];
    }
    
    NSString *queueIdentifier = [NSString stringWithFormat:@"%@%p",
                                 @"uk.co.inseven.view.",
                                 self];
    self.comparisonQueue
    = dispatch_queue_create([queueIdentifier UTF8String], NULL);
    
    dispatch_async(self.dispatchQueue, ^{
      [self loadEntries];
    });
    
  }
  return self;
}


- (void)invalidate:(BOOL)reload
{
  @synchronized (self) {
    self.state = ISDBViewStateInvalid;

    // Only attempt to reload if we have no observers.
    if (self.notifier.count > 0) {
      dispatch_async(self.dispatchQueue, ^{
        [self updateEntries];
      });
    }
  }
}


- (void)loadEntries
{
  @synchronized (self) {
    // TODO Ensure this is called on the worker queue.
    // TODO Remember assert might not get called?
    assert(self.entries == nil);
    assert(self.state == ISDBViewStateInvalid);
    self.entries =
    [self.dataSource entriesForOffset:0
                                limit:-1];
    self.state = ISDBViewStateValid;
  }
}


- (void)updateEntries
{
  // TODO Ensure this is called on the worker queue.
  // TODO Remember assert might not get called?
  assert(self.entries != nil);
  
  // Only run if we're not currently updating the entries.
  @synchronized (self) {
    if (self.state == ISDBViewStateValid) {
      return;
    } else {
      self.state = ISDBViewStateValid;
    }
  }
  
  // Fetch the updated entries.
  NSArray *updatedEntries =
  [self.dataSource entriesForOffset:0
                              limit:-1];
  
  // Cross-post the comparison onto a separate serial dispatch queue.
  // This ensures all updates are ordered.
  dispatch_async(self.comparisonQueue, ^{

    // Perform the comparison on a different thread to ensure we do
    // not block the UI thread.  Since we are always dispatching updates
    // onto a common queue we can guarantee that updates are performed in
    // order (though they may be delayed).
    // Updates are cross-posted back to the main thread.
    // We are using an ordered dispatch queue here, so it is guaranteed
    // that the current entries will not be being edited a this point.
    // As we are only performing a read, we can safely do so without
    // entering a synchronized block.
    NSMutableArray *actions = [NSMutableArray arrayWithCapacity:3];
    NSMutableArray *updates = [NSMutableArray arrayWithCapacity:3];
    NSInteger countBefore = self.entries.count;
    NSInteger countAfter = updatedEntries.count;
    
    // Removes and moves.
    for (NSInteger i = self.entries.count-1; i >= 0; i--) {
      ISDBEntryDescription *entry = [self.entries objectAtIndex:i];
      NSUInteger newIndex = [updatedEntries indexOfObject:entry];
      if (newIndex == NSNotFound) {
        // Remove.
        ISListViewAdapterOperation *operation
        = [ISListViewAdapterOperation operationWithType:ISListViewAdapterOperationTypeDelete
                                       payload:[NSNumber numberWithInteger:i]];
        [actions addObject:operation];
        countBefore--;
      } else {
        if (i != newIndex) {
          // Move.
          ISListViewAdapterOperation *operation
          = [ISListViewAdapterOperation operationWithType:ISListViewAdapterOperationTypeMove
                                         payload:@[[NSNumber numberWithInteger:i],
             [NSNumber numberWithInteger:newIndex]]];
          [actions addObject:operation];
        }
      }
    }
    
    // Additions and updates.
    for (NSUInteger i = 0; i < updatedEntries.count; i++) {
      ISDBEntryDescription *entry = [updatedEntries objectAtIndex:i];
      NSUInteger oldIndex = [self.entries indexOfObject:entry];
      if (oldIndex == NSNotFound) {
        // Add.
        ISListViewAdapterOperation *operation
        = [ISListViewAdapterOperation operationWithType:ISListViewAdapterOperationTypeInsert
                                       payload:[NSNumber numberWithInteger:i]];
        [actions addObject:operation];
        countBefore++;
      } else {
        ISDBEntryDescription *oldEntry = [self.entries objectAtIndex:oldIndex];
        if (![oldEntry isSummaryEqual:entry]) {
          [updates addObject:[NSNumber numberWithInteger:i]];
        }
      }
    }
    
    assert(countBefore == countAfter);
    
    // Notify our observers.
    dispatch_sync(dispatch_get_main_queue(), ^{
      @synchronized (self) {
        
        [self.notifier notify:@selector(beginUpdates:)
                   withObject:self];
        
        for (ISListViewAdapterOperation *operation in actions) {
          if (operation.type == ISListViewAdapterOperationTypeDelete) {
            [self.notifier notify:@selector(view:entryDeleted:)
                       withObject:self
                       withObject:operation.payload];
          } else if (operation.type == ISListViewAdapterOperationTypeMove) {
            [self.notifier notify:@selector(view:entryMoved:)
                       withObject:self
                       withObject:operation.payload];
          } else if (operation.type == ISListViewAdapterOperationTypeInsert) {
            [self.notifier notify:@selector(view:entryInserted:)
                       withObject:self
                       withObject:operation.payload];
          }
          
        }
        self.entries = updatedEntries;
        [self.notifier notify:@selector(endUpdates:)
                   withObject:self];
        
        // Perform batch updates at the end when the array
        // is in the new state.
        [self.notifier notify:@selector(performBatchUpdates:)
                   withObject:actions];

        
        // We perform updates in a separate beginUpdates block to avoid
        // performing multiple operations when used as a data source for
        // UITableView.
        // TODO Is it better to coalesce these?
        [self.notifier notify:@selector(beginUpdates:)
                   withObject:self];
        for (NSNumber *index in updates) {
          [self.notifier notify:@selector(view:entryUpdated:)
                     withObject:self
                     withObject:index];
        }
        [self.notifier notify:@selector(endUpdates:)
                   withObject:self];

        // There is no need to change the internal state for
        // updates so we simply notify.
        [self.notifier notify:@selector(performBatchUpdates:)
                   withObject:updates];

      }
    });
    
  });

}


- (NSUInteger)count
{
  @synchronized (self) {
    // We may return an out-of-date result for the count, but we fire an
    // asynchronous update which will ensure we return the latest version
    // as-and-when it is available.
    dispatch_async(self.dispatchQueue, ^{
      [self updateEntries];
    });
    return self.entries.count;
  }
}


- (ISListViewAdapterItem *)entryForIdentifier:(id)identifier
{
  // TODO Introducing an additional synchronized block may introduce some
  // performance issues.
  @synchronized (self) {
    // Create a description to allow us to find the entry.
    ISDBEntryDescription *description
    = [ISDBEntryDescription descriptionWithIdentifier:identifier
                                              summary:nil];
    NSUInteger index = [self.entries indexOfObject:description];
    ISListViewAdapterItem *entry = [ISListViewAdapterItem entryWithAdapter:self
                                          index:index
                                     identifier:identifier];
    return entry;
  }
}


- (ISListViewAdapterItem *)entryForIndex:(NSInteger)index
{
  ISListViewAdapterItem *entry = [ISListViewAdapterItem entryWithAdapter:self
                                        index:index];
  return entry;
}


#pragma mark - Observers


- (void) addObserver:(id<ISListViewAdapterObserver>)observer
{
  @synchronized (self) {
    [self.notifier addObserver:observer];
  }
}


- (void) removeObserver:(id<ISListViewAdapterObserver>)observer
{
  @synchronized (self) {
    [self.notifier removeObserver:observer];
  }
}


@end
