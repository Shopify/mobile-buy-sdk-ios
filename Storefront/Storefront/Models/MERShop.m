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
	
	self.name = dictionary[@"name"];
	self.city = dictionary[@"city"];
	self.province = dictionary[@"province"];
	self.currency = dictionary[@"currency"];
	self.domain = dictionary[@"domain"];
	self.shopDescription = dictionary[@"description"];
	self.shipsToCountries = dictionary[@"ships_to_countries"];
}

@end
