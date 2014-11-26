//
//  NSDictionary+JSONTests.m
//  ISUtilitiesTests
//
//  Created by Jason Barrie Morley on 26/11/2014.
//
//

#import <XCTest/XCTest.h>

#import <ISUtilities/ISUtilities.h>

@interface NSDictionary_JSONTests : XCTestCase

@end

@implementation NSDictionary_JSONTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSerialization
{
    NSDictionary *dict = @{@"title": @"cheese"};
    NSString *json = [dict JSON];
    
    XCTAssertEqualObjects(json, @"{\"title\":\"cheese\"}", @"Failed to correctly encode simple JSON dictionary.");
}

- (void)testDeserialization
{
    NSString *json = @"{\"title\": \"cheese\"}";
    
    NSError *error = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithJSON:json error:&error];
    
    XCTAssertNotNil(dict, @"Failed to decode simple JSON.");
    
    XCTAssertEqualObjects(dict, @{@"title": @"cheese"}, @"Failed to correctly decode simple JSON.");
}

- (void)testDeserializationIncorrectClass
{
    NSString *json = @"[\"title\", \"cheese\"]";
    
    NSError *error = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithJSON:json error:&error];
    
    XCTAssertNil(dict, @"Unexpectedly decoded JSON of incorrect class.");
    
    XCTAssertEqualObjects(error.domain, ISUtilitiesErrorDomain, @"Incorrect domain for error.");
    
    XCTAssertEqual(error.code, ISUtilitiesErrorInvalidClass, @"Incorrect code for error.");
}

- (void)testDeserializationInvalidJSON
{
    NSString *json = @"GARBAGE";
    
    NSError *error = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithJSON:json error:&error];
    
    XCTAssertNil(dict, @"Unexpectedly decoded invalid JSON.");
    
    XCTAssertNotNil(error, @"Failed to receive error for invalid JSON.");
}

@end
