//
//  BUYGiftCard.m
//  Mobile Buy SDK
//
//  Created by IBK Ajila on 2015-03-17.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYGiftCard.h"
#import "NSDecimalNumber+BUYAdditions.h"

@implementation BUYGiftCard

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_code = dictionary[@"code"];
	_lastCharacters = dictionary[@"last_characters"];
	_balance = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"balance"]];
	_amountUsed = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"amount_used"]];
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
		json[@"amount_used"] = _amountUsed;
	}
	
	return @{ @"gift_card" : json };
}

@end
