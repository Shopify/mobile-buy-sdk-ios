//
//  BUYAddress.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "BUYAddress.h"
#import "NSString+Trim.h"
#import "NSDictionary+Additions.h"

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
	self.province = [dictionary buy_objectForKey:@"province"];
	self.provinceCode = [dictionary buy_objectForKey:@"province_code"];
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
