//
//  CHKDiscount.m
//  CheckoutAnywhere
//
//  Created by Rune Madsen on 2015-05-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKDiscount.h"
#import "NSDecimalNumber+CHKAdditions.h"
#import "NSString+trim.h"

@implementation CHKDiscount

- (instancetype)initWithCode:(NSString *)code
{
	return [super initWithDictionary:@{@"code": code ?: @""}];
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	self.code = dictionary[@"code"];
	self.amount = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"amount"]];
	self.applicable = [dictionary[@"applicable"] boolValue];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"code"] = [self.code chk_trim] ?: @"";
	return json;
}

@end
