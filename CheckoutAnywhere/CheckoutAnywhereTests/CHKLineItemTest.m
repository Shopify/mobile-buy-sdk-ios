//
//  CHKLineItemTest.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

//Models
#import "CHKLineItem.h"
#import "CHKProductVariant.h"

@interface CHKLineItemTest : XCTestCase
@end

@implementation CHKLineItemTest {
	CHKLineItem *_lineItem;
}

- (void)setUp
{
	[super setUp];
	_lineItem = [[CHKLineItem alloc] init];
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
	_lineItem.variant = [[CHKProductVariant alloc] init];
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertNil(json[@"variant_id"]);
}

- (void)testJsonDictionaryShouldShowAllProperties
{
	_lineItem.variant = [[CHKProductVariant alloc] initWithDictionary:@{ @"id" : @5 }];
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
	
	CHKLineItem *lineItem = [[CHKLineItem alloc] initWithDictionary:@{ @"id" : @5, @"price" : @"5.99", @"quantity" : @5, @"requires_shipping" : @YES, @"title" : @"banana" }];
	XCTAssertEqualObjects(@5, lineItem.identifier);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5.99"], lineItem.price);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5"], lineItem.quantity);
	XCTAssertEqualObjects(@"banana", lineItem.title);
	XCTAssertTrue([[lineItem requiresShipping] boolValue]);
}

@end
