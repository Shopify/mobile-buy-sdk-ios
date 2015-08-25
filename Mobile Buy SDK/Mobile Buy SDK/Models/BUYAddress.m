//
//  BUYAddress.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYAddress.h"
#import "NSString+Trim.h"

@implementation BUYAddress

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
	json[@"address1"] = [self.address1 buy_trim] ?: @"";
	json[@"address2"] = [self.address2 buy_trim] ?: @"";
	json[@"city"] = [self.city buy_trim] ?: @"";
	json[@"company"] = [self.company buy_trim] ?: @"";
	json[@"first_name"] = [self.firstName buy_trim] ?: @"";
	json[@"last_name"] = [self.lastName buy_trim] ?: @"";
	json[@"phone"] = [self.phone buy_trim] ?: @"";
	json[@"zip"] = [self.zip buy_trim] ?: @"";
	
	NSString *country = [self.country buy_trim];
	if ([country length] > 0) {
		json[@"country"] = country;
	}
	
	NSString *countryCode = [self.countryCode buy_trim];
	if ([countryCode length] > 0) {
		json[@"country_code"] = countryCode;
	}
	
	NSString *province = [self.province buy_trim];
	if ([province length] > 0) {
		json[@"province"] = province;
	}
	
	NSString *provinceCode = [self.provinceCode buy_trim];
	if ([provinceCode length] > 0) {
		json[@"province_code"] = provinceCode;
	}
	return json;
}

-(NSString *)countryCode
{
	return [_countryCode uppercaseString];
}

@end
