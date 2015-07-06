//
//  BUYCheckoutTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;
#import <Buy/Buy.h>

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
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{ @"order_status_url" : @"NOT REAL" }];
	XCTAssertNil([checkout orderStatusURL]);
}

- (void)testOrderStatusDeserializationWithValidURL
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{ @"order_status_url" : @"http://www.shopify.com/" }];
	XCTAssertNotNil([checkout orderStatusURL]);
}

- (void)testOrderStatusDeserializationWithNoURL
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithDictionary:@{}];
	XCTAssertNil([checkout orderStatusURL]);
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
	BUYShippingRate *shippingRate = [[BUYShippingRate alloc] init];
	shippingRate.shippingRateIdentifier = @"banana";
	XCTAssertNil(_checkout.shippingRate);
	XCTAssertNil(_checkout.shippingRateId);
	_checkout.shippingRate = shippingRate;
	XCTAssertEqualObjects(@"banana", _checkout.shippingRateId);
	
	XCTAssertTrue([[_checkout dirtyProperties] containsObject:@"shippingRateId"]);
}

- (void)testDirtyPropertiesAreReturnedInJSON
{
	BUYShippingRate *shippingRate = [[BUYShippingRate alloc] init];
	shippingRate.shippingRateIdentifier = @"banana";
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
