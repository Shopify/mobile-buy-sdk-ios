//
//  BUYCreditCard.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYCreditCard.h"
#import "NSString+Trim.h"

@implementation BUYCreditCard

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	NSString *name = [self.nameOnCard buy_trim];
	if ([name length] > 0) {
		json[@"name"] = name;
	}
	
	NSString *number = [self.number buy_trim];
	if ([number length] > 0) {
		json[@"number"] = number;
	}
	
	NSString *expiryMonth = [self.expiryMonth buy_trim];
	if ([expiryMonth length] > 0) {
		json[@"month"] = expiryMonth;
	}
	
	NSString *expiryYear = [self.expiryYear buy_trim];
	if ([expiryYear length] > 0) {
		json[@"year"] = expiryYear;
	}
	
	NSString *cvv = [self.cvv buy_trim];
	if ([cvv length] > 0) {
		json[@"verification_value"] = cvv;
	}
	return json;
}

@end
