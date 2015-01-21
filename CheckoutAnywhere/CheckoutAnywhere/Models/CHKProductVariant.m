//
//  MERProductVariant.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKProductVariant.h"

//Additions
#import "NSDecimalNumber+CHKAdditions.h"

@implementation CHKProductVariant

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = [dictionary[@"title"] copy];
	_option1 = [dictionary[@"option1"] copy];
	_option2 = [dictionary[@"option2"] copy];
	_option3 = [dictionary[@"option3"] copy];
	
	_price = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"price"]];
	_compareAtPrice = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"compare_at_price"]];
	_grams = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"grams"]];
	
	_requiresShipping = dictionary[@"requires_shipping"];
	_taxable = dictionary[@"taxable"];
	_position = dictionary[@"position"];
}

@end
