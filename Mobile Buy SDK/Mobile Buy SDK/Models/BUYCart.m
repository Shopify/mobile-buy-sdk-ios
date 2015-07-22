//
//  BUYCart.m
//  Buy SDK
//
//  Created by Shopify on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYCart.h"
#import "BUYCartLineItem.h"
#import "BUYProductVariant.h"

@interface BUYCart ()

@property (nonatomic, strong) NSMutableSet *lineItemsSet;

@end

@implementation BUYCart

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.lineItemsSet = [[NSMutableSet alloc] init];
	}
	return self;
}

- (NSArray *)lineItems
{
	return [self.lineItemsSet allObjects];
}

- (BOOL)isValid
{
	return [self.lineItemsSet count] > 0;
}

- (void)clearCart
{
	[self.lineItemsSet removeAllObjects];
}

#pragma mark - Simple Cart Editing

- (void)addVariant:(BUYProductVariant *)variant
{
	BUYCartLineItem *lineItem = [[BUYCartLineItem alloc] initWithVariant:variant];
	BUYCartLineItem *existingLineItem = [self.lineItemsSet member:lineItem];
	if (existingLineItem) {
		existingLineItem.quantity = [existingLineItem.quantity decimalNumberByAdding:[NSDecimalNumber one]];
	} else {
		[self.lineItemsSet addObject:lineItem];
	}
}

- (void)removeVariant:(BUYProductVariant *)variant
{
	BUYCartLineItem *lineItem = [[BUYCartLineItem alloc] initWithVariant:variant];
	BUYCartLineItem *existingLineItem = [self.lineItemsSet member:lineItem];
	if (existingLineItem) {
		existingLineItem.quantity = [existingLineItem.quantity decimalNumberBySubtracting:[NSDecimalNumber one]];
		if ([[existingLineItem quantity] isEqual:[NSDecimalNumber zero]]) {
			[self.lineItemsSet removeObject:existingLineItem];
		}
	}
}

#pragma mark - Helpers

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *cart = [[NSMutableDictionary alloc] init];
	NSArray *lineItems = [self lineItems];
	if ([lineItems count] > 0) {
		NSMutableArray *lineItemsJson = [[NSMutableArray alloc] init];
		for (BUYCartLineItem *lineItem in lineItems) {
			[lineItemsJson addObject:[lineItem jsonDictionaryForCheckout]];
		}
		cart[@"line_items"] = lineItemsJson;
	}
	return cart;
}

@end
