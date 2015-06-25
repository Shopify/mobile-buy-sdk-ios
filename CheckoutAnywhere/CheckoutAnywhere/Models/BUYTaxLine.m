//
//  BUYTaxLine.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYTaxLine.h"
#import "NSDecimalNumber+BUYAdditions.h"

@implementation BUYTaxLine

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	_rate = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"rate"]];
	_title = dictionary[@"title"];
}

@end
