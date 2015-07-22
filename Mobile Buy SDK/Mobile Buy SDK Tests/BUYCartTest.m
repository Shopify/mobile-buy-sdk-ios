//
//  BUYCartTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;
#import <Buy/Buy.h>

@interface BUYCartTest : XCTestCase
@end

@implementation BUYCartTest {
	BUYCart *_cart;
}

- (void)setUp
{
	[super setUp];
	
	_cart = [[BUYCart alloc] init];
}

#pragma mark - Serialization Tests

- (void)testJsonDictionaryShouldBeEmptyWhenNothingIsSet
{
	NSDictionary *json = [_cart jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqual(0, [json count]);
}

- (void)testCartShouldBeInvalidWhenEmpty
{
	BUYCart *cart = [[BUYCart alloc] init];
	XCTAssertFalse([cart isValid]);
}

- (void)testAddVariantWillAddALineItem
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] variantId], variant.identifier);
}

- (void)testAddingTwoDifferentVariantsWillAddDifferentLineItems
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	
	BUYProductVariant *variant2 = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @2 }];
	[_cart addVariant:variant2];
	
	XCTAssertEqual([[_cart lineItems] count], 2);
}

- (void)testAddingAVariantOfTheSameTypeWillNotAddAnotherLineItem
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart addVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] variantId], variant.identifier);
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"2"]);
}

- (void)testRemovingAVariantDecrementsQuantity
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart addVariant:variant];
	[_cart removeVariant:variant];
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"1"]);
}

- (void)testRemovingAllVariantsOfASingleTypeRemovesItsLineItem
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart removeVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 0);
}

@end
