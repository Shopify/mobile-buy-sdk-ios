//
//  CHKLineItem.m
//  Checkout
//
//  Created by Shopify on 2014-09-16.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKLineItem.h"

//Model
#import "CHKProductVariant.h"

//Utils & Additions
#import "NSString+Trim.h"
#import "NSDecimalNumber+CHKAdditions.h"

@implementation CHKLineItem

- (instancetype)init
{
	return [self initWithVariant:nil];
}

- (instancetype)initWithVariant:(CHKProductVariant *)variant
{
	self = [super init];
	if (self) {
		self.variant = variant;
		self.quantity = variant ? [NSDecimalNumber one] : [NSDecimalNumber zero];
		self.price = variant ? [variant price] : [NSDecimalNumber zero];
		self.title = variant ? [variant title] : @"";
		self.requiresShipping = variant.requiresShipping;
	}
	return self;
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	self.title = dictionary[@"title"];
	self.quantity = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"quantity"]];
	self.price = [NSDecimalNumber chk_decimalNumberFromJSON:dictionary[@"price"]];
	self.requiresShipping = dictionary[@"requires_shipping"];
}

- (void)setVariant:(CHKProductVariant *)variant
{
	[self willChangeValueForKey:@"variant"];
	_variant = variant;
	[self didChangeValueForKey:@"variant"];
	self.requiresShipping = variant.requiresShipping;
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *lineItem = [[NSMutableDictionary alloc] init];
	if (self.variant.identifier) {
		lineItem[@"variant_id"] = self.variant.identifier;
	}
	
	if ([self.title length] > 0) {
		lineItem[@"title"] = [self.title chk_trim];
	}
	
	if (self.quantity) {
		lineItem[@"quantity"] = self.quantity;
	}
	
	if (self.price) {
		lineItem[@"price"] = self.price;
	}
	
	lineItem[@"requires_shipping"] = self.requiresShipping ?: @NO;
	
	return lineItem;
}

@end
