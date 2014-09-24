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

@property (nonatomic, copy) NSString *dirtyObjectValue;
@property (nonatomic, copy) NSString *s;
@property (nonatomic, assign) BOOL dirtyBooleanValue;
@property (nonatomic, assign) char dirtyCharacterValue;
@property (nonatomic, assign) unsigned char dirtyUnsignedCharValue;
@property (nonatomic, assign) int dirtyIntegerValue;
@property (nonatomic, assign) unsigned int dirtyUnsignedIntegerValue;
@property (nonatomic, assign) short dirtyShortValue;
@property (nonatomic, assign) unsigned short dirtyUnsignedShortValue;
@property (nonatomic, assign) long dirtyLongValue;
@property (nonatomic, assign) unsigned long dirtyUnsignedLongValue;
@property (nonatomic, assign) long long dirtyLongLongValue;
@property (nonatomic, assign) unsigned long long dirtyUnsignedLongLongValue;
@property (nonatomic, assign) float dirtyFloatValue;
@property (nonatomic, assign) double dirtyDoubleValue;

@property (nonatomic, readonly) NSArray *array;
@property (nonatomic, readonly) NSMutableArray *mutableArray;

@end

@interface MERObjectSubclass : MERObject
@end

@interface MERObjectTests : XCTestCase
@end

@implementation MERObjectTests

- (void)testInitWithDictionaryParsesIdentifier
{
	MERObject *object = [[MERObject alloc] initWithDictionary:@{ @"id" : @5 }];
	XCTAssert([object isDirty] == NO);
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
	object.s = @"short property name test";
	object.dirtyObjectValue = @"Banana";
	object.dirtyBooleanValue = true;
	object.dirtyCharacterValue = 'c';
	object.dirtyUnsignedCharValue = 'c';
	object.dirtyIntegerValue = 1234;
	object.dirtyUnsignedIntegerValue = 123;
	object.dirtyShortValue = 1;
	object.dirtyUnsignedShortValue = 2;
	object.dirtyLongValue = -4;
	object.dirtyUnsignedLongValue = 4;
	object.dirtyLongLongValue = 1234123412341234;
	object.dirtyUnsignedLongLongValue = 1234123412341234;
	object.dirtyFloatValue = 0.5f;
	object.dirtyDoubleValue = 0.5;
	NSSet *expected = [NSSet setWithArray:@[@"s", @"dirtyObjectValue", @"dirtyBooleanValue", @"dirtyCharacterValue",
						 @"dirtyUnsignedCharValue", @"dirtyIntegerValue", @"dirtyUnsignedIntegerValue",
						 @"dirtyShortValue", @"dirtyUnsignedShortValue", @"dirtyLongValue",
						 @"dirtyUnsignedLongValue", @"dirtyLongLongValue", @"dirtyUnsignedLongLongValue",
						 @"dirtyFloatValue", @"dirtyDoubleValue"]];
	NSSet *actual = [object dirtyProperties];
	XCTAssert([expected isEqual:actual]);
	XCTAssertEqual([actual count], [expected count]);
}

- (void)testIsDirtyReturnsFalseWhenClean
{
	MERDirtyTracked *object = [[MERDirtyTracked alloc] init];
	XCTAssert([object isDirty] == NO);
	object.dirtyObjectValue = @"Banana";
	[object markAsClean];
	XCTAssert([object isDirty] == NO);
}

- (void)testIsDirtyReturnsTrueWhenDirty
{
	MERDirtyTracked *object = [[MERDirtyTracked alloc] init];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object isDirty]);
}

- (void)testMarkAsClean
{
	MERDirtyTracked *object = [[MERDirtyTracked alloc] init];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object dirtyProperties]);
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
