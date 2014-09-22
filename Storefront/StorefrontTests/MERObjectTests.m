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

@interface MERDirtyTracked : MERObject

@property (nonatomic, copy) NSString *banana;

@end

@interface MERObjectSubclass : MERObject
@end

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

- (void)testConvertObject
{
	MERObject *object = [MERObject convertObject:@{ @"id" : @10 }];
	XCTAssertNotNil(object);
	XCTAssertEqual(@10, [object identifier]);
}

- (void)testConvertObjectWorksWithSubclasses
{
	MERObject *object = [MERObjectSubclass convertObject:@{ @"id" : @10 }];
	XCTAssertNotNil(object);
	XCTAssertTrue([object isKindOfClass:[MERObjectSubclass class]]);
	XCTAssertEqual(@10, [object identifier]);
}

- (void)testConvertJSONArrayWithEmptyArray
{
	NSArray *json = @[];
	XCTAssertEqual(0, [[MERObject convertJSONArray:json] count]);
}

- (void)testConvertJSONArrayCreatesObjectOfClass
{
	NSArray *json = @[@{ @"id" : @5 }, @{ @"id" : @7 }];
	NSArray *convertedArray = [MERObject convertJSONArray:json];
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
	NSArray *convertedArray = [MERObject convertJSONArray:json block:^(id obj) {
		XCTAssertTrue([obj isKindOfClass:[MERObject class]]);
		++numberOfInvokes;
	}];
	XCTAssertNotNil(convertedArray);
	XCTAssertEqual([json count], [convertedArray count]);
	XCTAssertEqual([json count], numberOfInvokes);
}

- (void)testDirtyTracking
{
	MERDirtyTracked *object = [[MERDirtyTracked alloc] init];
	object.banana = @"asdf";
}

@end

#pragma mark - Helper Impls

@implementation MERDirtyTracked

+ (void)initialize
{
	if (self == [MERDirtyTracked class]) {
		[self trackDirtyProperties];
	}
}

@end

@implementation MERObjectSubclass
@end
