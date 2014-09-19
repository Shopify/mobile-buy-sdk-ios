//
//  MERObjectTests.m
//  Storefront
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "MERObject.h"

@interface MERObjectTests : XCTestCase
@end

@implementation MERObjectTests

- (void)testInitWithDictionaryParsesIdentifier
{
	MERObject *object = [[MERObject alloc] initWithDictionary:@{ @"id" : @5 }];
	XCTAssertEqual(@5, [object identifier]);
}

- (void)testInitWithDictionaryWithoutIdentifier
{
	MERObject *object = [[MERObject alloc] initWithDictionary:@{}];
	XCTAssertNil([object identifier]);
}

- (void)testConvertJSONArrayWithEmptyArray
{
	NSArray *json = @[];
	XCTAssertEqual(0, [[MERObject convertJSONArray:json toArrayOfClass:[MERObject class]] count]);
}

- (void)testConvertJSONArrayCreatesObjectOfClass
{
	NSArray *json = @[@{ @"id" : @5 }, @{ @"id" : @7 }];
	NSArray *convertedArray = [MERObject convertJSONArray:json toArrayOfClass:[MERObject class]];
	XCTAssertEqual(2, [convertedArray count]);
	XCTAssertTrue([convertedArray[0] isKindOfClass:[MERObject class]]);
	XCTAssertTrue([convertedArray[1] isKindOfClass:[MERObject class]]);
	XCTAssertEqualObjects(@5, [convertedArray[0] identifier]);
	XCTAssertEqualObjects(@7, [convertedArray[1] identifier]);
}

- (void)testConvertJSONArrayWithCreatedBlock
{
	NSArray *json = @[@{ @"id" : @5 }, @{ @"id" : @6 }, @{ @"id" : @7 }];
	__block NSUInteger numberOfInvokes = 0;
	NSArray *convertedArray = [MERObject convertJSONArray:json toArrayOfClass:[MERObject class] block:^(id obj) {
		XCTAssertTrue([obj isKindOfClass:[MERObject class]]);
		++numberOfInvokes;
	}];
	XCTAssertNotNil(convertedArray);
	XCTAssertEqual([json count], [convertedArray count]);
	XCTAssertEqual([json count], numberOfInvokes);
}

@end
