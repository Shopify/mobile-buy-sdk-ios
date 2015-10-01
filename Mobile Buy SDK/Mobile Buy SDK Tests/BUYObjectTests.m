//
//  BUYObjectTests.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

@import UIKit;
@import XCTest;

#import <Buy/Buy.h>

@interface BUYDirtyTracked : BUYObject

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

@interface BUYObjectSubclass : BUYObject
@end

@interface BUYObjectTests : XCTestCase
@end

@implementation BUYObjectTests

- (void)testInitWithDictionaryParsesIdentifier
{
	BUYObject *object = [[BUYObject alloc] initWithDictionary:@{ @"id" : @5 }];
	XCTAssert([object isDirty] == NO);
	XCTAssertEqual(@5, [object identifier]);
}

- (void)testInitWithDictionaryWithoutIdentifier
{
	BUYObject *object = [[BUYObject alloc] initWithDictionary:@{}];
	XCTAssertNil([object identifier]);
}

- (void)testConvertObject
{
	BUYObject *object = [BUYObject convertObject:@{ @"id" : @10 }];
	XCTAssertNotNil(object);
	XCTAssertEqual(@10, [object identifier]);
}

- (void)testConvertObjectWorksWithSubclasses
{
	BUYObject *object = [BUYObjectSubclass convertObject:@{ @"id" : @10 }];
	XCTAssertNotNil(object);
	XCTAssertTrue([object isKindOfClass:[BUYObjectSubclass class]]);
	XCTAssertEqual(@10, [object identifier]);
}

- (void)testConvertJSONArrayWithEmptyArray
{
	NSArray *json = @[];
	XCTAssertEqual(0, [[BUYObject convertJSONArray:json] count]);
}

- (void)testConvertJSONArrayCreatesObjectOfClass
{
	NSArray *json = @[@{ @"id" : @5 }, @{ @"id" : @7 }];
	NSArray *convertedArray = [BUYObject convertJSONArray:json];
	XCTAssertEqual(2, [convertedArray count]);
	XCTAssertTrue([convertedArray[0] isKindOfClass:[BUYObject class]]);
	XCTAssertTrue([convertedArray[1] isKindOfClass:[BUYObject class]]);
	XCTAssertEqualObjects(@5, [convertedArray[0] identifier]);
	XCTAssertEqualObjects(@7, [convertedArray[1] identifier]);
}

- (void)testConvertJSONArrayWithCreatedBlock
{
	NSArray *json = @[@{ @"id" : @5 }, @{ @"id" : @6 }, @{ @"id" : @7 }];
	__block NSUInteger numberOfInvokes = 0;
	NSArray *convertedArray = [BUYObject convertJSONArray:json block:^(id obj) {
		XCTAssertTrue([obj isKindOfClass:[BUYObject class]]);
		++numberOfInvokes;
	}];
	XCTAssertNotNil(convertedArray);
	XCTAssertEqual([json count], [convertedArray count]);
	XCTAssertEqual([json count], numberOfInvokes);
}

- (void)testDirtyTracking
{
	BUYDirtyTracked *object = [[BUYDirtyTracked alloc] init];
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
	BUYDirtyTracked *object = [[BUYDirtyTracked alloc] init];
	XCTAssert([object isDirty] == NO);
	object.dirtyObjectValue = @"Banana";
	[object markAsClean];
	XCTAssert([object isDirty] == NO);
}

- (void)testIsDirtyReturnsTrueWhenDirty
{
	BUYDirtyTracked *object = [[BUYDirtyTracked alloc] init];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object isDirty]);
}

- (void)testMarkAsClean
{
	BUYDirtyTracked *object = [[BUYDirtyTracked alloc] init];
	object.dirtyObjectValue = @"Banana";
	XCTAssert([object dirtyProperties]);
}

@end

#pragma mark - Helper Impls

@implementation BUYDirtyTracked

+ (void)initialize
{
	if (self == [BUYDirtyTracked class]) {
		[self trackDirtyProperties];
	}
}

@end

@implementation BUYObjectSubclass
@end
