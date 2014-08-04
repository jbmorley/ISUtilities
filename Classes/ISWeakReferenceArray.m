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


+ (id)arrayWithCapacity:(NSUInteger)numItems
{
  return [[self alloc] initWithCapacity:numItems];
}


- (id)init
{
  self = [super init];
  if (self) {
    _items = [[NSMutableArray alloc] init];
  }
  return self;
}


- (id)initWithCapacity:(NSUInteger)numItems
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
