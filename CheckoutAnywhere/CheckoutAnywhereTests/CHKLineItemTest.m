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

@end
