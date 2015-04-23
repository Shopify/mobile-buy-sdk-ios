//
//  CHKShop.m
//  Checkout
//
//  Created by Shopify on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKShop.h"

@implementation CHKShop

+ (void)initialize
{
	if (self == [CHKShop class]) {
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
