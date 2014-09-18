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

@end
