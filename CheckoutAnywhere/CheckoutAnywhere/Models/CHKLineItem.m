//
//  CHKLineItem.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-16.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "CHKLineItem.h"

//Model
#import "MERProductVariant.h"

@implementation CHKLineItem

- (instancetype)init
{
	return [self initWithVariant:nil];
}

- (instancetype)initWithVariant:(MERProductVariant *)variant
{
	self = [super init];
	if (self) {
		self.variant = variant;
		self.quantity = [NSDecimalNumber one];
		self.price = variant ? [variant price] : [NSDecimalNumber zero];
	}
	return self;
}

@end
