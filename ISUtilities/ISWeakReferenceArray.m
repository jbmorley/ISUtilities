//
// Copyright (c) 2013-2014 InSeven Limited.
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

#import "ISWeakReferenceArray.h"
#import "ISWeakReference.h"

@interface ISWeakReferenceArray ()

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation ISWeakReferenceArray


+ (instancetype)arrayWithCapacity:(NSUInteger)numItems
{
  return [[self alloc] initWithCapacity:numItems];
}


- (instancetype)init
{
  self = [super init];
  if (self) {
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}


- (instancetype)initWithCapacity:(NSUInteger)numItems
{
  self = [super init];
  if (self) {
    _items = [NSMutableArray arrayWithCapacity:numItems];
  }
  return self;
}


- (BOOL)containsObject:(id)anObject
{
  return [self.items containsObject:[ISWeakReference referenceWithObject:anObject]];
}


- (void)addObject:(id)anObject
{
  [self.items addObject:[ISWeakReference referenceWithObject:anObject]];
  [self removeMissingObjects];
}


- (void)removeObject:(id)anObject
{
  NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
  for (NSUInteger i = 0; i < self.items.count; i++) {
    ISWeakReference *reference = self.items[i];
    if (reference.object == anObject) {
      [indexes addIndex:i];
    }
  }
  [self.items removeObjectsAtIndexes:indexes];
  [self removeMissingObjects];
}


- (NSUInteger)count
{
  [self removeMissingObjects];
  return self.items.count;
}


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
  // Initialization.
  if (state->state == 0) {
    // Ignoring mutations.
    state->mutationsPtr = &state->extra[0];
    // Only remove nil objects in the initialization state to avoid the
    // risk of mutations from releases on other threads.
    [self removeMissingObjects];
  }
  
  // Uncapture the previously buffered item.
  if (state->state > 0) {
    ISWeakReference *item = [self.items objectAtIndex:(state->state - 1)];
    [item uncapture];
  }
  
  // Provide items in bocks matching buffer size (len).
  if (state->state < self.items.count) {
    
    // Use the provided buffer.
    state->itemsPtr = buffer;
    
    // Find the next strong reference.
    __strong NSObject *object = nil;
    ISWeakReference *item;
    do {
      item = [self.items objectAtIndex:(state->state)];
      object = item.object;
      buffer[0] = item.object;
      state->state++;
    } while (object == nil &&
             state->state < self.items.count);
    
    // Check if we've reached the end of the list and if not,
    // and we have a valid item, then capture the item and return
    // it to the enumeration.
    if (object &&
        state->state <= self.items.count) {
      [item capture];
      return 1;
    } else {
      return 0;
    }
    
  } else {
    
    // Indicate that we're done.
    return 0;
    
  }
}


- (void)removeMissingObjects
{
  NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
  for (NSUInteger i = 0; i < self.items.count; i++) {
    ISWeakReference *reference = self.items[i];
    if (reference.object == nil) {
      [indexes addIndex:i];
    }
  }
  [self.items removeObjectsAtIndexes:indexes];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
{
  NSUInteger idx = 0;
  BOOL stop = NO;
  for (ISWeakReference *reference in self.items) {
    id object = reference.object;
    if (object == nil) {
      continue;
    }
    block(object, idx, &stop);
    if (stop) {
      break;
    }
    idx++;
  }
}

@end
