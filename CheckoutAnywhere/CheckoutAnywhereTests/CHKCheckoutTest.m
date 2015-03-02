//
//  CHKCheckoutTest.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

//Models
#import "CHKCheckout.h"
#import "CHKCart.h"
#import "CHKProductVariant.h"

@interface CHKCheckoutTest : XCTestCase
@end

@implementation CHKCheckoutTest {
	CHKCheckout *_checkout;
	CHKCart *_cart;
	CHKProductVariant *_variant;
	NSDictionary *_discountDictionary;
}

- (void)setUp
{
	[super setUp];
	_checkout = [[CHKCheckout alloc] init];
	_cart = [[CHKCart alloc] init];
	_variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
	_discountDictionary = @{ @"code" : @"abcd1234", @"amount" : @"5.00", @"applicable" : @true };
}

- (void)testOrderStatusDeserializationWithInvalidURL
{
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithDictionary:@{ @"order_status_url" : @"NOT REAL" }];
	XCTAssertNil([checkout orderStatusURL]);
}

- (void)testOrderStatusDeserializationWithValidURL
{
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithDictionary:@{ @"order_status_url" : @"http://www.shopify.com/" }];
	XCTAssertNotNil([checkout orderStatusURL]);
}

- (void)testOrderStatusDeserializationWithNoURL
{
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithDictionary:@{}];
	XCTAssertNil([checkout orderStatusURL]);
}

- (void)testInitWithCartAddsLineItems
{
	[_cart addVariant:_variant];
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:_cart];
	XCTAssertEqual([[checkout lineItems] count], [[_cart lineItems] count]);
	XCTAssertTrue([checkout isDirty]);
}

- (void)testPartialAddressFlagIsAlwaysSetInJson
{
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:_cart];
	NSDictionary *dirtyJSON = [checkout jsonDictionaryForCheckout];
	XCTAssertNotNil(dirtyJSON[@"checkout"][@"partial_addresses"]);
	XCTAssertTrue([dirtyJSON[@"checkout"][@"partial_addresses"] boolValue]);
	[checkout markAsClean];
	
	NSDictionary *cleanJSON = [checkout jsonDictionaryForCheckout];
	XCTAssertNotNil(cleanJSON[@"checkout"][@"partial_addresses"]);
	XCTAssertTrue([cleanJSON[@"checkout"][@"partial_addresses"] boolValue]);
}

- (void)testSettingAShippingRateMarksShippingRateIdAsDirty
{
	CHKShippingRate *shippingRate = [[CHKShippingRate alloc] init];
	shippingRate.shippingRateIdentifier = @"banana";
	XCTAssertNil(_checkout.shippingRate);
	XCTAssertNil(_checkout.shippingRateId);
	_checkout.shippingRate = shippingRate;
	XCTAssertEqualObjects(@"banana", _checkout.shippingRateId);
	
	XCTAssertTrue([[_checkout dirtyProperties] containsObject:@"shippingRateId"]);
}

- (void)testDirtyPropertiesAreReturnedInJSON
{
	CHKShippingRate *shippingRate = [[CHKShippingRate alloc] init];
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

- (void)testDiscountDeserialization
{
	CHKDiscount *discount = [[CHKDiscount alloc] initWithDictionary: _discountDictionary];
	XCTAssertEqualObjects(@"abcd1234", discount.code);
	XCTAssertEqualObjects(@5.00, discount.amount);
	XCTAssertEqual(true, discount.applicable);
}

- (void)testDiscountSerialization
{
	NSDictionary *jsonDict = @{ @"code": @"abcd1234" };
	CHKDiscount *discount = [[CHKDiscount alloc] initWithDictionary:_discountDictionary];
	XCTAssertEqualObjects(jsonDict, [discount jsonDictionaryForCheckout]);
}

- (void)testHasToken
{
	CHKCheckout *checkout = [[CHKCheckout alloc] init];
	checkout.token = nil;
	XCTAssertFalse([checkout hasToken]);
	checkout.token = @"";
	XCTAssertFalse([checkout hasToken]);
	checkout.token = @"banana";
	XCTAssertTrue([checkout hasToken]);
}

- (void)testEmptyCheckoutsDoNotRequireShipping
{
	XCTAssertFalse([_checkout requiresShipping]);
}

- (void)testCheckoutsWithoutItemsThatRequireShipping
{
	[_cart addVariant:_variant];
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:_cart];
	XCTAssertFalse([checkout requiresShipping]);
}

- (void)testCheckoutsRequireShipping
{
	CHKProductVariant *variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @2, @"requires_shipping" : @YES }];
	[_cart addVariant:variant];
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:_cart];
	XCTAssertTrue([checkout requiresShipping]);
}

@end
