//
//  BUYMaskedCreditCard.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-08-04.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYMaskedCreditCard.h"

@implementation BUYMaskedCreditCard

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_firstName = [dictionary[@"first_name"] copy];
	_lastName = [dictionary[@"last_name"] copy];

	_firstDigits = [dictionary[@"first_digits"] copy];
	_lastDigits = [dictionary[@"last_digits"] copy];

	_expiryMonth = [dictionary[@"expiry_month"] copy];
	_expiryYear = [dictionary[@"expiry_year"] copy];
}

@end
