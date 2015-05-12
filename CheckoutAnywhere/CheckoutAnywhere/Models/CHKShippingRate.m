//
//  CHKShippingRate.m
//  CheckoutAnywhere
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKShippingRate.h"
#import "NSDecimalNumber+CHKAdditions.h"
#import "NSString+Trim.h"

@implementation CHKShippingRate

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.shippingRateIdentifier = dictionary[@"id"];
	self.price = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"price"]];
	self.title = dictionary[@"title"];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"id"] = [self.shippingRateIdentifier chk_trim] ?: @"";
	json[@"title"] = [self.title chk_trim] ?: @"";
	json[@"price"] = self.price ?: [NSDecimalNumber zero];
	return json;
}

@end
