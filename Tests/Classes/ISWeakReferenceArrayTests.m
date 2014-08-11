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


- (void)testInit
{
  ISWeakReferenceArray *array = [[ISWeakReferenceArray alloc] init];
  NSNumber *item = @1;
  [array addObject:item];
  XCTAssertTrue([array count] == 1,
                @"Construct an array using alloc init and add an item.");
}


- (void)testInitWithCapacity
{
  ISWeakReferenceArray *array = [[ISWeakReferenceArray alloc] initWithCapacity:3];
  NSNumber *item = @1;
  [array addObject:item];
  XCTAssertTrue([array count] == 1,
                @"Construct an array with an initial capacity and add an item.");
}


- (void)testDeallocation
{
  @autoreleasepool {
    __attribute__((objc_precise_lifetime)) NSObject *item = [NSObject new];
    [self.array addObject:item];
  }
  XCTAssertTrue([self.array count] == 0,
                @"Check that an item is removed when it it is released.");
}


/*
 * This test serves a number of purposes: It checks that each object returned during the fast enumeration
 * has a retain count of at least 1 so it is not unexpected released during the enumeration. The access
 * to the object (CFGetRetainCount) also forces a dereference of each item returned during the enumeration
 * which catches any hanging pointers which may be created by failing to retain the objects in the
 * fast enumeration implementation prior to returning a plain C-pointer. Finally, we check that we do not
 * retain the objects in the for loop any longer than necessary: the iteration will not continue once the
 * weak objects have been released.
 *
 * N.B. The Objective-C runtime has different characteristics on the 32-bit iOS Simulator so is not a
 * sufficient to for this test case.
 */
- (void)testFastEnumerationRetains
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
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
    long rc = CFGetRetainCount((__bridge CFTypeRef)(item));
    XCTAssert(rc > 0,
              @"Check weak items have a retain count greater than zero when accessed during fast enumeration.");
    NSLog(@"Item %lu: %@", (unsigned long)count, item);
    if (count == 0) {
      dispatch_semaphore_signal(begin);
      dispatch_semaphore_wait(end, DISPATCH_TIME_FOREVER);
    }
    count++;
  }
  
  XCTAssert(count == 1, @"Check that the fast enumeration correctly terminates once the weak objects have been released.");
}


/*
 * As above but for block-based enumeration.
 */
- (void)testBlockBasedEnumerationRetains
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
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

  __block NSUInteger count = 0;
  [array enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
    long rc = CFGetRetainCount((__bridge CFTypeRef)(item));
    XCTAssert(rc > 0,
              @"Check weak items have a retain count greater than zero when accessed during block-based enumeration.");
    if (idx == 0) {
      dispatch_semaphore_signal(begin);
      dispatch_semaphore_wait(end, DISPATCH_TIME_FOREVER);
    }
    count++;
  }];
  
  XCTAssert(count == 1, @"Check that the block-based enumeration correctly terminates once the weak objects have been released.");
}


/*
 * Test that temporary retain used during fast enumeration is correctly released.
 */

- (void)testFastEnumerationReleases
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
  __attribute__((objc_precise_lifetime)) NSObject *item1 = [NSObject new]; [array addObject:item1];
  __attribute__((objc_precise_lifetime)) NSObject *item2 = [NSObject new]; [array addObject:item2];
  __attribute__((objc_precise_lifetime)) NSObject *item3 = [NSObject new]; [array addObject:item3];
  
  long retainCount1 = CFGetRetainCount((__bridge CFTypeRef)(item1));
  long retainCount2 = CFGetRetainCount((__bridge CFTypeRef)(item2));
  long retainCount3 = CFGetRetainCount((__bridge CFTypeRef)(item3));
  
  NSUInteger count = 0;
  for (NSObject *item in array) {
    long rc = CFGetRetainCount((__bridge CFTypeRef)(item));
    XCTAssert(rc > 0,
              @"Check weak items have a retain count greater than zero when accessed during block-based enumeration.");
    count++;
  }
  
  XCTAssertEqual(count, 3,
                 @"Check that the array enumeration returns the correct count.");
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item1)), retainCount1,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item2)), retainCount2,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item3)), retainCount3,
                 @"Check that the retain count of items is unchanged following fast enumeration.");

}


/*
 * As above but for block-based enumeration.
 */
- (void)testBlockBasedEnumerationReleases
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
  __attribute__((objc_precise_lifetime)) NSObject *item1 = [NSObject new]; [array addObject:item1];
  __attribute__((objc_precise_lifetime)) NSObject *item2 = [NSObject new]; [array addObject:item2];
  __attribute__((objc_precise_lifetime)) NSObject *item3 = [NSObject new]; [array addObject:item3];
  
  long retainCount1 = CFGetRetainCount((__bridge CFTypeRef)(item1));
  long retainCount2 = CFGetRetainCount((__bridge CFTypeRef)(item2));
  long retainCount3 = CFGetRetainCount((__bridge CFTypeRef)(item3));
  
  [array enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
    long rc = CFGetRetainCount((__bridge CFTypeRef)(item));
    XCTAssert(rc > 0,
              @"Check weak items have a retain count greater than zero when accessed during block-based enumeration.");
  }];

  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item1)), retainCount1,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item2)), retainCount2,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item3)), retainCount3,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
}


- (void)testFastEnumerationBreak
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
  __attribute__((objc_precise_lifetime)) NSObject *item1 = [NSObject new]; [array addObject:item1];
  __attribute__((objc_precise_lifetime)) NSObject *item2 = [NSObject new]; [array addObject:item2];
  __attribute__((objc_precise_lifetime)) NSObject *item3 = [NSObject new]; [array addObject:item3];
  
  long retainCount1 = CFGetRetainCount((__bridge CFTypeRef)(item1));
  long retainCount2 = CFGetRetainCount((__bridge CFTypeRef)(item2));
  long retainCount3 = CFGetRetainCount((__bridge CFTypeRef)(item3));
  
  NSInteger count = 0;
  for (NSObject *object in array) {
    if (count == 0) {
      break;
    }
    count++;
  }
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item1)), retainCount1,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item2)), retainCount2,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item3)), retainCount3,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
}


- (void)testBlockBasedEnumerationBreak
{
  ISWeakReferenceArray *array = [ISWeakReferenceArray new];
  __attribute__((objc_precise_lifetime)) NSObject *item1 = [NSObject new]; [array addObject:item1];
  __attribute__((objc_precise_lifetime)) NSObject *item2 = [NSObject new]; [array addObject:item2];
  __attribute__((objc_precise_lifetime)) NSObject *item3 = [NSObject new]; [array addObject:item3];
  
  long retainCount1 = CFGetRetainCount((__bridge CFTypeRef)(item1));
  long retainCount2 = CFGetRetainCount((__bridge CFTypeRef)(item2));
  long retainCount3 = CFGetRetainCount((__bridge CFTypeRef)(item3));
  
  [array enumerateObjectsUsingBlock:^(id item, NSUInteger idx, BOOL *stop) {
    if (idx == 1) {
      *stop = YES;
    }
  }];
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item1)), retainCount1,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item2)), retainCount2,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(item3)), retainCount3,
                 @"Check that the retain count of items is unchanged following fast enumeration.");
}


@end
