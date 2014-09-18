//
//  CHKCartTest.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

//Models
#import "CHKCart.h"
#import "CHKLineItem.h"
#import "MERProductVariant.h"

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
	XCTAssertEqual(1, [json count]);
	XCTAssertNotNil(json[@"checkout"]);
	
	NSDictionary *checkoutJson = json[@"checkout"];
	XCTAssertEqual(0, [checkoutJson count]);
}

- (void)testJsonDictionaryContainsLineItems
{
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	
	NSDictionary *json = [_cart jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqual(1, [json count]);
	XCTAssertNotNil(json[@"checkout"]);
	
	NSDictionary *checkoutJson = json[@"checkout"];
	XCTAssertNotNil(checkoutJson[@"line_items"]);
	XCTAssert([checkoutJson[@"line_items"] isKindOfClass:[NSArray class]]);
	XCTAssertEqual(3, [checkoutJson[@"line_items"] count]);
}

@end
