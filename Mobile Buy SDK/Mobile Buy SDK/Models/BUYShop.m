//
//  BUYShop.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYShop.h"

@implementation BUYShop

+ (void)initialize
{
	if (self == [BUYShop class]) {
		[self trackDirtyProperties];
	}
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_city = [dictionary[@"city"] copy];
	_country = [dictionary[@"country"] copy];
	_province = [dictionary[@"province"] copy];
	_currency = [dictionary[@"currency"] copy];
	_domain = [dictionary[@"domain"] copy];
	_shopDescription = [dictionary[@"description"] copy];
	_shipsToCountries = [dictionary[@"ships_to_countries"] copy];
}

@end
