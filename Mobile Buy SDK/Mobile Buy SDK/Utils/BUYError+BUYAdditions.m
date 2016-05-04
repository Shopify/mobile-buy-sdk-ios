//
//  BUYError+BUYAdditions.m
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

#import "BUYError+BUYAdditions.h"

@implementation BUYError (Checkout)

+ (NSArray<BUYError *> *)errorsFromCheckoutJSON:(NSDictionary *)json
{
	NSArray *lineItems = json[@"errors"][@"checkout"][@"line_items"];
	NSMutableArray *errors = [NSMutableArray array];
	
	for (NSDictionary<NSString *, NSArray *> *lineItem in lineItems) {
		if (lineItem == (id)[NSNull null]) {
			[errors addObject:lineItem];
		}
		else {
			for (NSString *key in lineItem.allKeys) {
				NSDictionary *reason = [lineItem[key] firstObject];
				[errors addObject:[[BUYError alloc] initWithKey:key json:reason]];
			};
		}
	};
	return errors;
}

- (NSString *)quantityRemainingMessage
{
	NSNumber *remaining = (id)self.options[@"remaining"];
	NSString *localizedString;
	
	if ([remaining isEqualToNumber:@0]) {
		localizedString = NSLocalizedString(@"Completely sold out", @"String describing a line item with zero stock available");
	} else {
		localizedString = NSLocalizedString(@"Only %1$@ left in stock, reduce the quantity and try again.", @"String describing an out of stock line item with first parameter representing amount remaining");
	}
	return [NSString localizedStringWithFormat:localizedString, remaining];
}

@end

@implementation BUYError (Customer)

+ (NSArray<BUYError *> *)errorsFromSignUpJSON:(NSDictionary *)json
{
	NSDictionary *reasons = json[@"errors"][@"customer"];
	
	__block NSMutableArray *errors = [NSMutableArray array];
	[reasons enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray * _Nonnull obj, BOOL * _Nonnull stop) {
		for (NSDictionary *reason in obj) {
			[errors addObject:[[BUYError alloc] initWithKey:key json:reason]];
		}
	}];
	
	return errors;
}

@end
