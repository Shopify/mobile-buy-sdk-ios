//
//  BUYLineItem.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-16.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYLineItem.h"
#import "BUYProductVariant.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSString+Trim.h"

@interface BUYLineItem ()

@property (nonatomic, strong) NSNumber *variantId;

@end

@implementation BUYLineItem

- (instancetype)init
{
	return [self initWithVariant:nil];
}

- (instancetype)initWithVariant:(BUYProductVariant *)variant
{
	self = [super init];
	if (self) {
		self.variantId = variant.identifier;
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
	self.variantId = dictionary[@"variant_id"];
	self.title = dictionary[@"title"];
	self.quantity = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"quantity"]];
	self.price = [NSDecimalNumber buy_decimalNumberFromJSON:dictionary[@"price"]];
	self.requiresShipping = dictionary[@"requires_shipping"];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *lineItem = [[NSMutableDictionary alloc] init];
	if (self.variantId) {
		lineItem[@"variant_id"] = self.variantId;
	}
	
	if ([self.title length] > 0) {
		lineItem[@"title"] = [self.title buy_trim];
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
