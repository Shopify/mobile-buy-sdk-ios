//
//  CHKCreditCard.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKCreditCard.h"

#import "NSString+Trim.h"

@implementation CHKCreditCard

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	NSString *name = [self.nameOnCard trim];
	if ([name length] > 0) {
		json[@"name"] = name;
	}
	
	NSString *number = [self.number trim];
	if ([number length] > 0) {
		json[@"number"] = number;
	}
	
	NSString *expiryMonth = [self.expiryMonth trim];
	if ([expiryMonth length] > 0) {
		json[@"month"] = expiryMonth;
	}
	
	NSString *expiryYear = [self.expiryYear trim];
	if ([expiryYear length] > 0) {
		json[@"year"] = expiryYear;
	}
	
	NSString *cvv = [self.cvv trim];
	if ([cvv length] > 0) {
		json[@"verification_value"] = cvv;
	}
	return json;
}

@end
