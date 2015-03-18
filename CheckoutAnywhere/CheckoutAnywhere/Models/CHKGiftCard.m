//
//  CHKGiftCard.m
//  CheckoutAnywhere
//
//  Created by IBK Ajila on 2015-03-17.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKGiftCard.h"
#import "NSDecimalNumber+CHKAdditions.h"

//Models
#import "CHKCheckout.h"

@implementation CHKGiftCard

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_code = dictionary[@"code"];
	_lastCharacters = dictionary[@"last_characters"];
	_balance = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"balance"]];
	_amountUsed = [NSDecimalNumber decimalNumberFromJSON:dictionary[@"amountUsed"]];
	_checkout = [CHKCheckout convertObject:dictionary[@"checkout"]];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	
	if (_code) {
		json[@"code"] = _code;
	}

	if (_lastCharacters) {
		json[@"last_characters"] = _lastCharacters;
	}
	
	if (_balance) {
		json[@"balance"] = _balance;
	}
	
	if (_amountUsed) {
		json[@"amountUsed"] = _amountUsed;
	}
	
	if (_checkout) {
		json[@"checkout"] = [_checkout jsonDictionaryForCheckout];
	}
	
	return @{ @"gift_card" : json };
}

@end
