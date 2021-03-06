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

@interface ISWeakReferenceTests : XCTestCase

@end

@implementation ISWeakReferenceTests


- (void)setUp
{
  [super setUp];
}


- (void)tearDown
{
  [super tearDown];
}


- (void)testReferenceEquals
{
  NSNumber *item = @1;
  ISWeakReference *reference1 = [[ISWeakReference alloc] initWithObject:item];
  ISWeakReference *reference2 = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertTrue([reference1 isEqual:reference2],
                @"Check that two references containing the same object are equal.");
}


- (void)testReferenceHash
{
  NSNumber *item = @1;
  ISWeakReference *reference1 = [[ISWeakReference alloc] initWithObject:item];
  ISWeakReference *reference2 = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqual([reference1 hash], [reference2 hash],
                 @"Check that two references containing the same object have matching hashes.");
}


- (void)testReferenceEqualsObject
{
  NSNumber *item = @1;
  ISWeakReference *reference = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqualObjects(reference, item,
                        @"Checking that an object and its corresponding weak reference are equal.");
}


- (void)testReferenceHashMatchesObjectHash
{
  NSNumber *item = @1;
  ISWeakReference *reference = [[ISWeakReference alloc] initWithObject:item];
  XCTAssertEqual([reference hash], [item hash],
                 @"Checking that an object and its corresponding weak reference have matching hashes.");
}


- (void)testReferenceDoesNotRetain
{
  ISWeakReference *reference;
  @autoreleasepool {
    __attribute__((objc_precise_lifetime)) NSObject *item = [NSObject new];
    reference = [[ISWeakReference alloc] initWithObject:item];
  }
  XCTAssertNil(reference.object,
               @"Checking that a weak reference does not retain its object and nils its reference.");
}


- (void)testReferenceCapture
{
  __attribute__((objc_precise_lifetime)) NSObject *object = [NSObject new];
  ISWeakReference *reference = [ISWeakReference referenceWithObject:object];
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(object)), 1,
                 @"Checking that a weak reference has the expected retain count after capture.");
  
  [reference capture];
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(object)), 2,
                 @"Checking that a weak reference has the expected retain count when captured.");

  [reference uncapture];
  
  XCTAssertEqual(CFGetRetainCount((__bridge CFTypeRef)(object)), 1,
                 @"Checking that a weak reference has the expected retain count after uncapture.");
}


@end
