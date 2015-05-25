//
//  BUYLineItemTest.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;
#import <Buy/Buy.h>

@interface BUYLineItemTest : XCTestCase
@end

@implementation BUYLineItemTest {
	BUYLineItem *_lineItem;
}

- (void)setUp
{
	[super setUp];
	_lineItem = [[BUYLineItem alloc] init];
}

- (void)testInitRespectsVariantShippingFlag
{
	XCTAssertFalse([[_lineItem requiresShipping] boolValue]);
	
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @1, @"requires_shipping" : @YES }];
	_lineItem.variant = variant;
	XCTAssertTrue([[_lineItem requiresShipping] boolValue]);
	
	BUYLineItem *newLineItem = [[BUYLineItem alloc] initWithVariant:variant];
	XCTAssertTrue([[newLineItem requiresShipping] boolValue]);
}

#pragma mark - Serialization Tests

- (void)testJsonDictionaryShouldHaveSaneDefaults
{
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqualObjects([NSDecimalNumber zero], json[@"price"]);
	XCTAssertEqualObjects([NSDecimalNumber zero], json[@"quantity"]);
}

- (void)testJsonDictionaryDoesntIncludeVariantsWithoutIds
{
	_lineItem.variant = [[BUYProductVariant alloc] init];
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertNil(json[@"variant_id"]);
}

- (void)testJsonDictionaryShouldShowAllProperties
{
	_lineItem.variant = [[BUYProductVariant alloc] initWithDictionary:@{ @"id" : @5 }];
	_lineItem.quantity = [NSDecimalNumber decimalNumberWithString:@"3"];
	_lineItem.price = [NSDecimalNumber decimalNumberWithString:@"5.55"];
	_lineItem.title = @"banana";
	
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertEqualObjects(@5, json[@"variant_id"]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"3"], json[@"quantity"]);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5.55"], json[@"price"]);
	XCTAssertEqualObjects(@"banana", json[@"title"]);
}

- (void)testUpdatingFromJsonShouldUpdateAllValues
{
	XCTAssertFalse([[_lineItem requiresShipping] boolValue]);
	
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithDictionary:@{ @"id" : @5, @"price" : @"5.99", @"quantity" : @5, @"requires_shipping" : @YES, @"title" : @"banana" }];
	XCTAssertEqualObjects(@5, lineItem.identifier);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5.99"], lineItem.price);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5"], lineItem.quantity);
	XCTAssertEqualObjects(@"banana", lineItem.title);
	XCTAssertTrue([[lineItem requiresShipping] boolValue]);
}

@end
