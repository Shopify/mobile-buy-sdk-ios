//
//  BUYPayment.m
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

#import "BUYPayment.h"
#import "BUYCheckout.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSDictionary+BUYAdditions.h"

@implementation BUYPayment

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	
	_amount         = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"amount"]];
	_createdAt      = [formatter dateFromString:[dictionary buy_objectForKey:@"created_at"]];
	
	_authorization  = [dictionary buy_objectForKey:@"authorization"];
	_currency       = [dictionary buy_objectForKey:@"currency"];
	_errorCode      = [dictionary buy_objectForKey:@"error_code"];
	_gateway        = [dictionary buy_objectForKey:@"gateway"];
	_kind           = [dictionary buy_objectForKey:@"kind"];
	_message        = [dictionary buy_objectForKey:@"message"];
	_status         = [dictionary buy_objectForKey:@"status"];
	
	_checkout       = [BUYCheckout convertObject:dictionary[@"checkout"]];
	
	_isTest         = [[dictionary buy_objectForKey:@"test"] boolValue];
}

@end
