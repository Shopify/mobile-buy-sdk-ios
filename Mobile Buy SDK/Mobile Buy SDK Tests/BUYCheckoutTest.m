//
//  BUYCheckoutTest.m
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
#import "BUYCheckout_Private.h"
@interface BUYCheckoutTest : XCTestCase
@end

@implementation BUYCheckoutTest {
	BUYCheckout *_checkout;
	BUYCart *_cart;
	BUYProductVariant *_variant;
	NSDictionary *_discountDictionary;
}

- (void)setUp
{
	[super setUp];
	_cart = [[BUYCart alloc] init];
	_checkout = [[BUYCheckout alloc] initWithCart:_cart];
	_variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	_discountDictionary = @{ @"code" : @"abcd1234", @"amount" : @"5.00", @"applicable" : @true };
}

- (void)testOrderStatusDeserializationWithInvalidURL
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{ @"order" : @{ @"status_url" : @"NOT REAL" } }];
	XCTAssertNil(checkout.order.statusURL);
}

- (void)testOrderStatusDeserializationWithValidURL
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{ @"order" : @{ @"status_url" : @"http://www.shopify.com/" } }];
	XCTAssertNotNil(checkout.order.statusURL);
}

- (void)testOrderStatusDeserializationWithNoURL
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{}];
	XCTAssertNil(checkout.order.statusURL);
}

- (void)testInitWithCartAddsLineItems
{
	[_cart addVariant:_variant];
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:_cart];
	XCTAssertEqual([[checkout lineItems] count], [[_cart lineItems] count]);
	XCTAssertTrue([checkout isDirty]);
}

- (void)testSettingAShippingRateMarksShippingRateIdAsDirty
{
	BUYShippingRate *shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"id" : @"banana" }];
	XCTAssertNil(_checkout.shippingRate);
	XCTAssertNil(_checkout.shippingRateId);
	_checkout.shippingRate = shippingRate;
	XCTAssertEqualObjects(@"banana", _checkout.shippingRateId);
	
	XCTAssertTrue([[_checkout dirtyProperties] containsObject:@"shippingRateId"]);
}

- (void)testDirtyPropertiesAreReturnedInJSON
{
	BUYShippingRate *shippingRate = [[BUYShippingRate alloc] initWithDictionary:@{ @"id" : @"banana" }];
	[_checkout markAsClean];
	
	_checkout.shippingRate = shippingRate;
	_checkout.currency = @"BANANA";
	NSSet *dirtyProperties = [_checkout dirtyProperties];
	XCTAssertTrue([dirtyProperties containsObject:@"currency"]);
	XCTAssertTrue([dirtyProperties containsObject:@"shippingRateId"]);
	XCTAssertTrue([dirtyProperties containsObject:@"shippingRate"]);
	
	NSDictionary *json = [_checkout jsonDictionaryForCheckout];
	XCTAssertEqualObjects(json[@"checkout"][@"currency"], @"BANANA");
	XCTAssertEqualObjects(json[@"checkout"][@"shipping_rate_id"], @"banana");
}

- (void)testRequiresShippingAndIncludesTaxesSerialization
{
	_checkout.requiresShipping = YES;
	_checkout.taxesIncluded = YES;
	NSDictionary *jsonDictionary = [_checkout jsonDictionaryForCheckout][@"checkout"];
	XCTAssertEqualObjects(@YES, jsonDictionary[@"requires_shipping"]);
	XCTAssertEqualObjects(@YES, jsonDictionary[@"taxes_included"]);
}

- (void)testDiscountDeserialization
{
	BUYDiscount *discount = [[BUYDiscount alloc] initWithDictionary: _discountDictionary];
	XCTAssertEqualObjects(@"abcd1234", discount.code);
	XCTAssertEqualObjects(@5.00, discount.amount);
	XCTAssertEqual(true, discount.applicable);
}

- (void)testDiscountSerialization
{
	NSDictionary *jsonDict = @{ @"code": @"abcd1234" };
	BUYDiscount *discount = [[BUYDiscount alloc] initWithDictionary:_discountDictionary];
	XCTAssertEqualObjects(jsonDict, [discount jsonDictionaryForCheckout]);
}

- (void)testHasToken
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:_cart];
	checkout.token = nil;
	XCTAssertFalse([checkout hasToken]);
	checkout.token = @"";
	XCTAssertFalse([checkout hasToken]);
	checkout.token = @"banana";
	XCTAssertTrue([checkout hasToken]);
}

- (void)testEmptyCheckoutsDoNotRequireShipping
{
	_checkout = [[BUYCheckout alloc] initWithDictionary:@{}];
	XCTAssertFalse([_checkout requiresShipping]);
}

- (void)testCheckoutsWithoutItemsThatRequireShipping
{
	_checkout = [[BUYCheckout alloc] initWithDictionary:@{ @"requires_shipping" : @1 }];
	XCTAssertTrue([_checkout requiresShipping]);
}

- (void)testTaxLineDeserialization
{
	BUYTaxLine *taxLine = [[BUYTaxLine alloc] initWithDictionary:@{@"price": @"0.29",
																   @"rate": @"0.13",
																   @"title": @"HST"}];
	XCTAssertEqualObjects(@0.29, taxLine.price);
	XCTAssertEqualObjects(@0.13, taxLine.rate);
	XCTAssertEqualObjects(@"HST", taxLine.title);
	
}

@end
