//
//  BUYCart.m
//  Buy SDK
//
//  Created by Shopify on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYCart.h"
#import "BUYLineItem.h"
#import "BUYProductVariant.h"

@implementation BUYCart {
	NSMutableArray *_lineItems;
	NSMutableDictionary *_variantToLineItem;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_lineItems = [[NSMutableArray alloc] init];
		_variantToLineItem = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (NSArray *)lineItems
{
	return [NSArray arrayWithArray:_lineItems];
}

- (BOOL)isValid
{
	return [[self lineItems] count] > 0;
}

- (void)clearCart
{
	NSArray *lineItems = [self lineItems];
	for (BUYLineItem *lineItem in lineItems) {
		[self removeLineItemsObject:lineItem];
	}
}

#pragma mark - Simple Cart Editing

- (void)createLineItem:(BUYProductVariant *)variant
{
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithVariant:variant];
	if (variant.identifier) {
		_variantToLineItem[variant.identifier] = lineItem;
	}
	[_lineItems addObject:lineItem];
}

- (void)addVariant:(BUYProductVariant *)variant
{
	BUYLineItem *existingLineItem = [self lineItemForVariantId:variant.identifier];
	if (existingLineItem) {
		existingLineItem.quantity = [existingLineItem.quantity decimalNumberByAdding:[NSDecimalNumber one]];
	}
	else {
		[self createLineItem:variant];
	}
}

- (void)removeVariant:(BUYProductVariant *)variant
{
	BUYLineItem *existingLineItem = [self lineItemForVariantId:variant.identifier];
	if (existingLineItem) {
		existingLineItem.quantity = [existingLineItem.quantity decimalNumberBySubtracting:[NSDecimalNumber one]];
		if ([[existingLineItem quantity] isEqual:[NSDecimalNumber zero]]) {
			[_lineItems removeObject:existingLineItem];
			if (existingLineItem.variantId) {
				[_variantToLineItem removeObjectForKey:existingLineItem.variantId];
			}
		}
	}
}

#pragma mark - Direct Line Item Editing

- (void)addLineItemsObject:(BUYLineItem *)lineItem
{
	BUYLineItem *existingLineItem = [self lineItemForVariantId:lineItem.variantId];
	if (existingLineItem) {
		[_lineItems removeObject:existingLineItem];
	}
	[_lineItems addObject:lineItem];
}

- (void)removeLineItemsObject:(BUYLineItem *)object
{
	[_lineItems removeObject:object];
}

#pragma mark - Helpers

- (BUYLineItem *)lineItemForVariantId:(NSNumber *)variantId
{
	return variantId ? _variantToLineItem[variantId] : nil;
}

- (void)removeVariantFromCache:(BUYProductVariant *)variant
{
	if (variant.identifier) {
		[_variantToLineItem removeObjectForKey:variant.identifier];
	}
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	NSMutableDictionary *cart = [[NSMutableDictionary alloc] init];
	NSArray *lineItems = [self lineItems];
	if ([lineItems count] > 0) {
		NSMutableArray *lineItemsJson = [[NSMutableArray alloc] init];
		for (BUYLineItem *lineItem in lineItems) {
			[lineItemsJson addObject:[lineItem jsonDictionaryForCheckout]];
		}
		cart[@"line_items"] = lineItemsJson;
	}
	return cart;
}

@end
