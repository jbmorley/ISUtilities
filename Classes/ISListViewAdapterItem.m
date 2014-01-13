//
//  ISDBEntry.m
//  Popcorn
//
//  Created by Jason Barrie Morley on 03/05/2013.
//
//

#import "ISListViewAdapterItem.h"
#import "ISListViewAdapter_Private.h"

@interface ISListViewAdapterItem ()

@property (strong, nonatomic) ISListViewAdapter *view;
@property (nonatomic) NSUInteger index;
@property (strong, nonatomic) id identifier;

@end

@implementation ISListViewAdapterItem


+ (id)entryWithAdapter:(ISListViewAdapter *)adapter
              index:(NSUInteger)index
{
  return [[self alloc] initWithAdapter:adapter
                              index:index
                         identifier:nil];
}


+ (id)entryWithAdapter:(ISListViewAdapter *)adapter
              index:(NSUInteger)index
         identifier:(id)identifier
{
  return [[self alloc] initWithAdapter:adapter
                              index:index
                         identifier:identifier];
}


- (id)initWithAdapter:(ISListViewAdapter *)view
             index:(NSUInteger)index
        identifier:(id)identifier
{
  self = [super init];
  if (self) {
    self.view = view;
    self.index = index;
    if (identifier == nil) {
      self.identifier = [self.view identifierForIndex:self.index];
    } else {
      self.identifier = identifier;
    }
    [self.view addObserver:self];
  }
  return self;
}


- (void)dealloc
{
  [self.view removeObserver:self];
}


- (void)fetch:(ISListViewAdapterItemBlock)completionBlock
{
  [self.view entryForIdentifier:self.identifier
                     completion:completionBlock];
}


#pragma mark - ISDBViewObserver


//- (void) beginUpdates:(ISListViewAdapter *)view {}
//
//
//- (void) endUpdates:(ISListViewAdapter *)view {}
//
//
//- (void) view:(ISListViewAdapter *)view
// entryUpdated:(NSNumber *)index
//{
//  if (self.index == [index integerValue]) {
//    self.index = [index integerValue];
//    NSLog(@"Entry Changed");
//  }
//}
//
//
//- (void) view:(ISListViewAdapter *)view
//   entryMoved:(NSArray *)indexes {}
//
//
//- (void) view:(ISListViewAdapter *)view
//entryInserted:(NSNumber *)index {}
//
//
//- (void) view:(ISListViewAdapter *)view
// entryDeleted:(NSNumber *)index
//{
//  if (self.index == [index integerValue]) {
//    NSLog(@"Entry Deleted");
//  }
//}


@end
