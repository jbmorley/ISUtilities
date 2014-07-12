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
  {
    NSNumber *item = @1;
    [self.array addObject:item];
  }
  XCTAssertTrue([self.array count] == 0, @"Check that an item is removed when it it is released.");
}


@end
