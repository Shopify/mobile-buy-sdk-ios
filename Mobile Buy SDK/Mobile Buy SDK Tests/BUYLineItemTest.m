//
//  BUYLineItemTest.m
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

@interface BUYLineItemTest : XCTestCase
@end

@implementation BUYLineItemTest {
	BUYProductVariant *_variant;
	BUYLineItem *_lineItem;
	BUYModelManager *_modelManager;
}

- (void)setUp
{
	[super setUp];

	_modelManager = [BUYModelManager modelManager];
	_variant = [[BUYProductVariant alloc] initWithModelManager:_modelManager JSONDictionary:@{ @"id" : @1, @"requires_shipping" : @YES }];
	_lineItem = [[BUYLineItem alloc] initWithVariant:_variant];
}

- (void)tearDown
{
	_modelManager = nil;
}

- (void)testInitRespectsVariantShippingFlag
{
	XCTAssertTrue([[_lineItem requiresShipping] boolValue]);
	_variant.requiresShipping = @NO;
	XCTAssertTrue([[_lineItem requiresShipping] boolValue]);
}

#pragma mark - Serialization Tests

- (void)testJsonDictionaryShouldHaveSaneDefaults
{
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqualObjects(@"0", json[@"price"]);
	XCTAssertEqualObjects(@"1", json[@"quantity"]);
}

- (void)testJsonDictionaryDoesntIncludeVariantsWithoutIds
{
	_lineItem = [_modelManager lineItemWithVariant:nil];
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertNil(json[@"variant_id"]);
}

- (void)testJsonDictionaryShouldShowAllProperties
{
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithModelManager:[BUYModelManager modelManager] JSONDictionary:@{ @"id" : @5 }];
	_lineItem = [[BUYLineItem alloc] initWithVariant:variant];
	_lineItem.quantity = [NSDecimalNumber decimalNumberWithString:@"3"];
	_lineItem.price = [NSDecimalNumber decimalNumberWithString:@"5.55"];
	_lineItem.title = @"banana";
	
	NSDictionary *json = [_lineItem jsonDictionaryForCheckout];
	XCTAssertEqualObjects(@5, json[@"variant_id"]);
	XCTAssertEqualObjects(@"3", json[@"quantity"]);
	XCTAssertEqualObjects(@"5.55", json[@"price"]);
	XCTAssertEqualObjects(@"banana", json[@"title"]);
}

- (void)testUpdatingFromJsonShouldUpdateAllValues
{
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithModelManager:[BUYModelManager modelManager] JSONDictionary:@{ @"id" : @"5", @"price" : @"5.99", @"quantity" : @5, @"requires_shipping" : @YES, @"title" : @"banana" }];
	XCTAssertEqualObjects(@"5", lineItem.identifier);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5.99"], lineItem.price);
	XCTAssertEqualObjects([NSDecimalNumber decimalNumberWithString:@"5"], lineItem.quantity);
	XCTAssertEqualObjects(@"banana", lineItem.title);
	XCTAssertTrue([[lineItem requiresShipping] boolValue]);
}

@end
