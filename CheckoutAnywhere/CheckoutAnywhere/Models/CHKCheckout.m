//
//  MERCheckout.m
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKCheckout.h"

//Models
#import "CHKLineItem.h"

//Utils
#import "NSString+Trim.h"

@implementation CHKCheckout

+ (void)initialize
{
	if (self == [CHKCheckout class]) {
		[self trackDirtyProperties];
	}
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.email = dictionary[@"email"];
	self.token = dictionary[@"token"];
	self.requiresShipping = dictionary[@"requires_shipping"];
	self.taxesIncluded = dictionary[@"taxes_included"];
	self.currency = dictionary[@"currency"];
	self.subtotalPrice = dictionary[@"subtotal_price"];
	self.totalTax = dictionary[@"total_tax"];
	self.totalPrice = dictionary[@"total_price"];
	
	self.paymentSessionId = dictionary[@"payment_session_id"];
	NSString *paymentURLString = dictionary[@"payment_url"];
	self.paymentURL = paymentURLString ? [NSURL URLWithString:paymentURLString] : nil;
	self.reservationTime = dictionary[@"reservation_time"];
	self.reservationTimeLeft = dictionary[@"reservation_time_left"];
	
	_lineItems = [CHKLineItem convertJSONArray:dictionary[@"line_items"]];
	_taxLines = [CHKTaxLine convertJSONArray:dictionary[@"tax_lines"]];
	
	self.billingAddress = [CHKAddress convertObject:dictionary[@"billing_address"]];
	self.shippingAddress = [CHKAddress convertObject:dictionary[@"shipping_address"]];
	
	self.shippingRate = [CHKShippingRate convertObject:dictionary[@"shipping_address"]];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	//We only need the dirty properties
	NSSet *dirtyProperties = [self dirtyProperties];
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	for (NSString *dirtyProperty in dirtyProperties) {
		id value = [self valueForKey:dirtyProperty];
		if ([value conformsToProtocol:@protocol(CHKSerializable)]) {
			value = [(id <CHKSerializable>)value jsonDictionaryForCheckout];
		}
		else if ([value isKindOfClass:[NSString class]]) {
			value = [value trim];
		}
		json[dirtyProperty] = value ?: [NSNull null];
	}
	return json;
}

@end

@implementation CHKTaxLine

@end

@implementation CHKAddress

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"address1"] = [self.address1 trim] ?: @"";
	json[@"address2"] = [self.address2 trim] ?: @"";
	json[@"city"] = [self.city trim] ?: @"";
	json[@"company"] = [self.company trim] ?: @"";
	json[@"first_name"] = [self.firstName trim] ?: @"";
	json[@"last_name"] = [self.lastName trim] ?: @"";
	json[@"phone"] = [self.phone trim] ?: @"";
	json[@"zip"] = [self.zip trim] ?: @"";
	
	NSString *country = [self.country trim];
	if ([country length] > 0) {
		json[@"country"] = country;
	}
	
	NSString *countryCode = [self.countryCode trim];
	if ([countryCode length] > 0) {
		json[@"country_code"] = countryCode;
	}
	
	NSString *province = [self.province trim];
	if ([province length] > 0) {
		json[@"province"] = province;
	}
	
	NSString *provinceCode = [self.provinceCode trim];
	if ([provinceCode length] > 0) {
		json[@"province_code"] = provinceCode;
	}
	return json;
}

@end

@implementation CHKShippingRate

@end
