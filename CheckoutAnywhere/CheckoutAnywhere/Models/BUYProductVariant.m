//
//  BUYProductVariant.m
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYProductVariant.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "BUYOptionValue.h"

@implementation BUYProductVariant

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	
	_options = [BUYOptionValue convertJSONArray:dictionary[@"option_values"]];
	
	_price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	_compareAtPrice = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"compare_at_price"]];
	_grams = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"grams"]];
	
	_requiresShipping = dictionary[@"requires_shipping"];
	_taxable = dictionary[@"taxable"];
	_position = dictionary[@"position"];
}

@end
