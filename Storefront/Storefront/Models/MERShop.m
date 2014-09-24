//
//  MERShop.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERShop.h"

@implementation MERShop

+ (void)initialize
{
	if (self == [MERShop class]) {
		[self trackDirtyProperties];
	}
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_name = [dictionary[@"name"] copy];
	_city = [dictionary[@"city"] copy];
	_province = [dictionary[@"province"] copy];
	_currency = [dictionary[@"currency"] copy];
	_domain = [dictionary[@"domain"] copy];
	_shopDescription = [dictionary[@"description"] copy];
	_shipsToCountries = [dictionary[@"ships_to_countries"] copy];
}

@end
