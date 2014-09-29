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
	XCTAssertEqual(0, [json count]);
}

- (void)testJsonDictionaryContainsLineItems
{
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	[_cart addLineItemsObject:[[CHKLineItem alloc] init]];
	
	NSDictionary *json = [_cart jsonDictionaryForCheckout];
	XCTAssertNotNil(json);
	XCTAssertEqual(1, [json count]);

	XCTAssertNotNil(json[@"line_items"]);
	XCTAssert([json[@"line_items"] isKindOfClass:[NSArray class]]);
	XCTAssertEqual(3, [json[@"line_items"] count]);
}

@end
