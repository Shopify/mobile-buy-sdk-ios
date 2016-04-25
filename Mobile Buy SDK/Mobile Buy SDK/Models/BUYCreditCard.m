//
//  BUYCreditCard.m
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

#import "BUYCreditCard.h"
#import "NSString+BUYAdditions.h"

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
