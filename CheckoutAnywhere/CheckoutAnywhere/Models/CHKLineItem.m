//
//  CHKLineItem.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-16.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKLineItem.h"

//Model
#import "CHKProductVariant.h"

//Utils
#import "NSString+Trim.h"

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
	}
	return self;
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *lineItem = [[NSMutableDictionary alloc] init];
	if (self.variant.identifier) {
		lineItem[@"variant_id"] = self.variant.identifier;
	}
	
	if ([self.title length] > 0) {
		lineItem[@"title"] = [self.title trim];
	}
	
	if (self.quantity) {
		lineItem[@"quantity"] = self.quantity;
	}
	
	if (self.price) {
		lineItem[@"price"] = self.price;
	}
	return lineItem;
}

@end
