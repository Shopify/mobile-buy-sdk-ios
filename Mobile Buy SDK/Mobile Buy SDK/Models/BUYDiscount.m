//
//  BUYDiscount.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYDiscount.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+trim.h"

@implementation BUYDiscount

- (instancetype)initWithCode:(NSString *)code
{
	return [super initWithDictionary:@{@"code": code ?: @""}];
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	self.code = dictionary[@"code"];
	self.amount = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"amount"]];
	self.applicable = [dictionary[@"applicable"] boolValue];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"code"] = [self.code buy_trim] ?: @"";
	return json;
}

@end
