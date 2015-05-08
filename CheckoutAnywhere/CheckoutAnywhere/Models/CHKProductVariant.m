//
//  CHKProductVariant.m
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKProductVariant.h"
#import "NSDecimalNumber+CHKAdditions.h"

@implementation CHKProductVariant

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_option1 = [dictionary[@"option1"] copy];
	_option2 = [dictionary[@"option2"] copy];
	_option3 = [dictionary[@"option3"] copy];
	
	_price = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"price"]];
	_compareAtPrice = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"compare_at_price"]];
	_grams = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"grams"]];
	
	_requiresShipping = dictionary[@"requires_shipping"];
	_taxable = dictionary[@"taxable"];
	_position = dictionary[@"position"];
}

@end
