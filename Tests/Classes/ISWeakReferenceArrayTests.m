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

#import <XCTest/XCTest.h>
#import <ISUtilities/ISUtilities.h>

@interface ISWeakReferenceArrayTests : XCTestCase

@property (nonatomic, strong) ISWeakReferenceArray *array;

@end

@implementation ISWeakReferenceArrayTests


- (void)setUp
{
  [super setUp];
  self.array = [[ISWeakReferenceArray alloc] init];
}


- (void)tearDown
{
  self.array = nil;
  [super tearDown];
}


- (void)testReferenceEquals
{
  NSNumber *item = @1;
  ISWeakReference *reference1 = [[ISWeakReference alloc] initWithObject:item];
  ISWeakReference *reference2 = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertTrue([reference1 isEqual:reference2], @"Check that two references containing the same object are equal.");
}


- (void)testReferenceHash
{
  NSNumber *item = @1;
  ISWeakReference *reference1 = [[ISWeakReference alloc] initWithObject:item];
  ISWeakReference *reference2 = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqual([reference1 hash], [reference2 hash], @"Check that two references containing the same object have matching hashes.");
}


- (void)testReferenceEqualsObject
{
  NSNumber *item = @1;
  ISWeakReference *reference = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqualObjects(reference, item, @"Checking that an object and its corresponding weak reference are equal.");
}


- (void)testReferenceHashMatchesObjectHash
{
  NSNumber *item = @1;
  ISWeakReference *reference = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqual([reference hash], [item hash], @"Checking that an object and its corresponding weak reference have matching hashes.");
}


- (void)testReferenceDoesNotRetain
{
  ISWeakReference *reference;
  @autoreleasepool {
    __attribute__((objc_precise_lifetime)) NSObject *item = [NSObject new];
    reference = [[ISWeakReference alloc] initWithObject:item];
  }
  XCTAssertNil(reference.object, @"Checking that a weak reference does not retain its object and nils its reference.");
}


- (void)testInit
{
  ISWeakReferenceArray *array = [[ISWeakReferenceArray alloc] init];
  NSNumber *item = @1;
  [array addObject:item];
  XCTAssertTrue([array count] == 1, @"Construct an array using alloc init and add an item.");
}


- (void)testInitWithCapacity
{
  ISWeakReferenceArray *array = [[ISWeakReferenceArray alloc] initWithCapacity:3];
  NSNumber *item = @1;
  [array addObject:item];
  XCTAssertTrue([array count] == 1, @"Construct an array with an initial capacity and add an item.");
}


- (void)testDeallocation
{
  @autoreleasepool {
    __attribute__((objc_precise_lifetime)) NSObject *item = [NSObject new];
    [self.array addObject:item];
  }
  XCTAssertTrue([self.array count] == 0, @"Check that an item is removed when it it is released.");
}


- (void)testFastEnumeration
{
  ISWeakReferenceArray *array = [[ISWeakReferenceArray alloc] initWithCapacity:3];
  NSMutableArray *items = [NSMutableArray new];
  @autoreleasepool {
    for (int i=0; i<3; i++) {
      __attribute__((objc_precise_lifetime)) NSObject *item = [NSObject new];
      [items addObject:item];
      [array addObject:item];
    }
  }
  dispatch_semaphore_t begin = dispatch_semaphore_create(0);
  dispatch_semaphore_t end = dispatch_semaphore_create(0);
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    dispatch_semaphore_wait(begin, DISPATCH_TIME_FOREVER);
    [items removeAllObjects];
    dispatch_semaphore_signal(end);
  });
    
  NSUInteger count = 0;
  for (NSObject *item in array) {
    NSLog(@"ref count: %lx", CFGetRetainCount((__bridge CFTypeRef)(item)));
    NSLog(@"Item %lu: %@", (unsigned long)count, item);
    if (count == 0) {
      dispatch_semaphore_signal(begin);
      dispatch_semaphore_wait(end, DISPATCH_TIME_FOREVER);
    }
    count++;
  }
}


@end
