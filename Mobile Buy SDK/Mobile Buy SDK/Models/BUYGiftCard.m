//
//  BUYGiftCard.m
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
