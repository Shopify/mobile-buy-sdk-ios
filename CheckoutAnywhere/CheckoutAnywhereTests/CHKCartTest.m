//
//  CHKCartTest.m
//  Checkout
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

//Models
#import "CHKCart.h"
#import "CHKLineItem.h"
#import "CHKProductVariant.h"

@interface CHKCartTest : XCTestCase
@end

@implementation CHKCartTest {
	CHKCart *_cart;
}

- (void)setUp
{
	[super setUp];
	
	_cart = [[CHKCart alloc] init];
}

#pragma mark - Serialization Tests

- (void)testJsonDictionaryShouldBeEmptyWhenNothingIsSet
{
	NSDictionary *json = [_cart jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqual(0, [json count]);
}

- (void)testJsonDictionaryContainsLineItems
{
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	
	NSDictionary *json = [_cart jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqual(1, [json count]);

	XCTAssertNotNil(json[@"line_items"]);
	XCTAssert([json[@"line_items"] isKindOfClass:[NSArray class]]);
	XCTAssertEqual(3, [json[@"line_items"] count]);
}

- (void)testAddLineItemsObject
{
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	XCTAssertEqual([[_cart lineItems] count], 1);
	
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	XCTAssertEqual([[_cart lineItems] count], 2);
}

- (void)testRemoveLineItemsObject
{
	CHKLineItem *lineItem = [[CHKLineItem alloc] init];
	[_cart addLineItemsObject:lineItem];
	XCTAssertEqual([[_cart lineItems] count], 1);
	[_cart removeLineItemsObject:lineItem];
	XCTAssertEqual([[_cart lineItems] count], 0);
}

- (void)testCartShouldBeInvalidWhenEmpty
{
	CHKCart *cart = [[CHKCart alloc] init];
	XCTAssertFalse([cart isValid]);
}

- (void)testCartShouldBeValidWhenItHasLineItems
{
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	XCTAssertTrue([_cart isValid]);
}

- (void)testAddVariantWillAddALineItem
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] variant], variant);
}

- (void)testAddingTwoDifferentVariantsWillAddDifferentLineItems
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	
	CHKProductVariant *variant2 = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @2 }];
	[_cart addVariant:variant2];
	
	XCTAssertEqual([[_cart lineItems] count], 2);
}

- (void)testAddingAVariantOfTheSameTypeWillNotAddAnotherLineItem
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart addVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] variant], variant);
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"2"]);
}

- (void)testRemovingAVariantDecrementsQuantity
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart addVariant:variant];
	[_cart removeVariant:variant];
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"1"]);
}

- (void)testRemovingAllVariantsOfASingleTypeRemovesItsLineItem
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	[_cart addVariant:variant];
	[_cart removeVariant:variant];
	XCTAssertEqual([[_cart lineItems] count], 0);
}

@end
