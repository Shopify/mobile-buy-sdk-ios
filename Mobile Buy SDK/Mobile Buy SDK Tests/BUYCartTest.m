//
//  BUYCartTest.m
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

- (void)testSetVariantWithQuantity
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	BUYProductVariant *variantTwo = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @2 }];
	
	[_cart setVariant:variant withTotalQuantity:2];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"2"]);
	
	[_cart setVariant:variantTwo withTotalQuantity:4];
	XCTAssertEqual([[_cart lineItems] count], 2);
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"2"]);
	XCTAssertEqualObjects([[_cart lineItems][1] quantity], [NSDecimalNumber decimalNumberWithString:@"4"]);
	
	[_cart setVariant:variantTwo withTotalQuantity:0];
	XCTAssertEqual([[_cart lineItems] count], 1);
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"2"]);
	
	[_cart setVariant:variant withTotalQuantity:5];
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"5"]);
	
	[_cart addVariant:variant];
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"6"]);
	
	[_cart removeVariant:variant];
	XCTAssertEqualObjects([[_cart lineItems][0] quantity], [NSDecimalNumber decimalNumberWithString:@"5"]);
	
	[_cart setVariant:variant withTotalQuantity:0];
	XCTAssertEqual([[_cart lineItems] count], 0);
}

@end
