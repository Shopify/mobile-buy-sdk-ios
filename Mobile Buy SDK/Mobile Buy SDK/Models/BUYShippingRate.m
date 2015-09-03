//
//  BUYShippingRate.m
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

#import "BUYShippingRate.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"
#import "NSDateFormatter+BUYAdditions.h"

@interface BUYShippingRate ()

@property (nonatomic, strong) NSString *shippingRateIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSArray *deliveryRange;

@end

@implementation BUYShippingRate

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	self.shippingRateIdentifier = dictionary[@"id"];
	self.price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	self.title = dictionary[@"title"];
	if ([dictionary[@"delivery_range"] isKindOfClass:[NSNull class]] == NO && [dictionary[@"delivery_range"] count]) {
		NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForShippingRates];
		NSMutableArray *shippingRangeDates = [NSMutableArray new];
		for (NSString *dateString in dictionary[@"delivery_range"]) {
			[shippingRangeDates addObject:[dateFormatter dateFromString:dateString]];
		}
		self.deliveryRange = [shippingRangeDates copy];
	}
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"id"] = [self.shippingRateIdentifier buy_trim] ?: @"";
	json[@"title"] = [self.title buy_trim] ?: @"";
	json[@"price"] = self.price ?: [NSDecimalNumber zero];
	if (self.deliveryRange) {
		NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForShippingRates];
		NSMutableArray *shippingRangeStrings = [NSMutableArray new];
		for (NSDate *date in self.deliveryRange) {
			[shippingRangeStrings addObject:[dateFormatter stringFromDate:date]];
		}
		json[@"delivery_range"] = [shippingRangeStrings copy];
		
	}
	return json;
}

@end
