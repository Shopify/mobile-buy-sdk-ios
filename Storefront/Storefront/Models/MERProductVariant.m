//
//  MERProductVariant.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "MERProductVariant.h"

//Additions
#import "NSDecimalNumber+MERAdditions.h"

@implementation MERProductVariant

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super initWithDictionary:dictionary];
	if (self) {
		self.title = dictionary[@"title"];
		self.option1 = dictionary[@"option1"];
		self.option2 = dictionary[@"option2"];
		self.option3 = dictionary[@"option3"];
		
		self.price = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"price"]];
		self.compareAtPrice = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"compare_at_price"]];
		self.grams = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"grams"]];
		
		self.requiresShipping = dictionary[@"requires_shipping"];
		self.taxable = dictionary[@"taxable"];
		self.position = dictionary[@"position"];
	}
	return self;
}

@end
