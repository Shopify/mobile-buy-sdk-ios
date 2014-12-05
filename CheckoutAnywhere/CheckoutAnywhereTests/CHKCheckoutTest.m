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
#import "MERProductVariant.h"

@interface CHKCheckoutTest : XCTestCase
@end

@implementation CHKCheckoutTest {
	CHKCheckout *_checkout;
	CHKCart *_cart;
	MERProductVariant *_product;
}

- (void)setUp
{
	[super setUp];
	_checkout = [[CHKCheckout alloc] init];
	_cart = [[CHKCart alloc] init];
	_product = [[MERProductVariant alloc] initWithDictionary:@{ @"id" : @1 }];
}

- (void)testInitWithCartAddsLineItems
{
	[_cart addVariant:_product];
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

@end
