//
//  BUYShippingRate.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYShippingRate.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"

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
	
	if ([dictionary[@"delivery_range"] isKindOfClass:[NSNull class]] == NO) {
		NSDateFormatter* dateFormatter = [self dateFormatter];
		NSMutableArray *shippingRangeDates = [NSMutableArray new];
		for (NSString *dateString in dictionary[@"delivery_range"]) {
			[shippingRangeDates addObject:[dateFormatter dateFromString:dateString]];
		}
		self.deliveryRange = [shippingRangeDates copy];
	}
}

- (NSDateFormatter *)dateFormatter
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
	return dateFormatter;
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"id"] = [self.shippingRateIdentifier buy_trim] ?: @"";
	json[@"title"] = [self.title buy_trim] ?: @"";
	json[@"price"] = self.price ?: [NSDecimalNumber zero];
	if (self.deliveryRange) {
		NSDateFormatter* dateFormatter = [self dateFormatter];
		NSMutableArray *shippingRangeStrings = [NSMutableArray new];
		for (NSDate *date in self.deliveryRange) {
			[shippingRangeStrings addObject:[dateFormatter stringFromDate:date]];
		}
		json[@"delivery_range"] = [shippingRangeStrings copy];
		
	} else {
		json[@"delivery_range"] = @"";
	}
	return json;
}

@end
