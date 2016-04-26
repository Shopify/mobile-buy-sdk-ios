//
//  BUYCart.m
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

#import "BUYCart.h"
#import "BUYCartLineItem.h"
#import "BUYProductVariant.h"

@interface BUYCart ()

@property (nonatomic, strong, nonnull) NSMutableSet<BUYCartLineItem *> *lineItemsSet;

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

- (nonnull NSArray<BUYCartLineItem *> *)lineItems
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

- (void)addVariant:(nonnull BUYProductVariant *)variant
{
	BUYCartLineItem *lineItem = [[BUYCartLineItem alloc] initWithVariant:variant];
	BUYCartLineItem *existingLineItem = [self.lineItemsSet member:lineItem];
	if (existingLineItem) {
		existingLineItem.quantity = [existingLineItem.quantity decimalNumberByAdding:[NSDecimalNumber one]];
	} else {
		[self.lineItemsSet addObject:lineItem];
	}
}

- (void)removeVariant:(nonnull BUYProductVariant *)variant
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

- (void)setVariant:(nonnull BUYProductVariant *)variant withTotalQuantity:(NSInteger)quantity
{
	BUYCartLineItem *lineItem = [[BUYCartLineItem alloc] initWithVariant:variant];
	BUYCartLineItem *existingLineItem = [self.lineItemsSet member:lineItem];
	if (existingLineItem && quantity > 0) {
		existingLineItem.quantity = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:quantity];
	} else if (existingLineItem && quantity == 0) {
		[self.lineItemsSet removeObject:existingLineItem];
	} else {
		lineItem.quantity = (NSDecimalNumber*)[NSDecimalNumber numberWithInteger:quantity];
		[self.lineItemsSet addObject:lineItem];
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
