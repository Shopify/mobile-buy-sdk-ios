//
//  CHKAddress.m
//  CheckoutAnywhere
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKAddress.h"
#import "NSString+Trim.h"

@implementation CHKAddress

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.address1 = dictionary[@"address1"];
	self.address2 = dictionary[@"address2"];
	self.city = dictionary[@"city"];
	self.company = dictionary[@"company"];
	self.firstName = dictionary[@"first_name"];
	self.lastName = dictionary[@"last_name"];
	self.phone = dictionary[@"phone"];
	
	self.country = dictionary[@"country"];
	self.countryCode = dictionary[@"country_code"];
	self.province = dictionary[@"province"];
	self.provinceCode = dictionary[@"province_code"];
	self.zip = dictionary[@"zip"];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"address1"] = [self.address1 chk_trim] ?: @"";
	json[@"address2"] = [self.address2 chk_trim] ?: @"";
	json[@"city"] = [self.city chk_trim] ?: @"";
	json[@"company"] = [self.company chk_trim] ?: @"";
	json[@"first_name"] = [self.firstName chk_trim] ?: @"";
	json[@"last_name"] = [self.lastName chk_trim] ?: @"";
	json[@"phone"] = [self.phone chk_trim] ?: @"";
	json[@"zip"] = [self.zip chk_trim] ?: @"";
	
	NSString *country = [self.country chk_trim];
	if ([country length] > 0) {
		json[@"country"] = country;
	}
	
	NSString *countryCode = [self.countryCode chk_trim];
	if ([countryCode length] > 0) {
		json[@"country_code"] = countryCode;
	}
	
	NSString *province = [self.province chk_trim];
	if ([province length] > 0) {
		json[@"province"] = province;
	}
	
	NSString *provinceCode = [self.provinceCode chk_trim];
	if ([provinceCode length] > 0) {
		json[@"province_code"] = provinceCode;
	}
	return json;
}

@end
