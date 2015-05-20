//
//  BUYShippingRate.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYShippingRate.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"

@implementation BUYShippingRate

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.shippingRateIdentifier = dictionary[@"id"];
	self.price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	self.title = dictionary[@"title"];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"id"] = [self.shippingRateIdentifier buy_trim] ?: @"";
	json[@"title"] = [self.title buy_trim] ?: @"";
	json[@"price"] = self.price ?: [NSDecimalNumber zero];
	return json;
}

@end
