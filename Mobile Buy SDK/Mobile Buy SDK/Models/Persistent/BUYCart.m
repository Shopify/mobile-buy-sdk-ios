//
//  _BUYCart.m
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

#import "./BUYCartLineItem.h"
#import "BUYModelManager.h"

@implementation BUYCart

#if !defined CORE_DATA_PERSISTENCE
- (instancetype)init
{
	self = [super init];
	if (self) {
		self.lineItems = [NSOrderedSet orderedSet];
	}
	return self;
}
#endif

- (NSArray<BUYCartLineItem *> *)lineItemsArray
{
	return self.lineItems.array ?: @[];
}

- (BOOL)isValid
{
	return [self.lineItems count] > 0;
}

- (void)clearCart
{
	self.lineItems = [NSOrderedSet orderedSet];
}

- (void)addVariant:(BUYProductVariant *)variant
{
	[self willChangeValueForKey:BUYCartRelationships.lineItems];
	
	BUYCartLineItem *lineItem = [self linetItemForVariant:variant];
	if (lineItem) {
		[lineItem incrementQuantity];
	}
	else {
		// quantity is 1 by default
		[self.lineItemsSet addObject:[self newCartLineItemWithVariant:variant]];
	}
	
	[self didChangeValueForKey:BUYCartRelationships.lineItems];
}

- (void)removeVariant:(BUYProductVariant *)variant
{
	[self willChangeValueForKey:BUYCartRelationships.lineItems];
	
	BUYCartLineItem *lineItem = [self linetItemForVariant:variant];
	if (lineItem && [lineItem decrementQuantity].integerValue <= 0) {
		[self.lineItemsSet removeObject:lineItem];
	}
	
	[self didChangeValueForKey:BUYCartRelationships.lineItems];
}

- (void)setVariant:(BUYProductVariant *)variant withTotalQuantity:(NSInteger)quantity
{
	[self willChangeValueForKey:BUYCartRelationships.lineItems];

	BUYCartLineItem *lineItem = [self linetItemForVariant:variant];

	if (quantity == 0 && lineItem != nil) {
		[self.lineItemsSet removeObject:lineItem];
	}
	else if (quantity > 0) {
		if (lineItem == nil) {
			lineItem = [self newCartLineItemWithVariant:variant];
			[self.lineItemsSet addObject:lineItem];
		}
		lineItem.quantity = [NSDecimalNumber decimalNumberWithMantissa:quantity exponent:0 isNegative:NO];
	}
	
	[self didChangeValueForKey:BUYCartRelationships.lineItems];
}

- (BUYCartLineItem *)newCartLineItemWithVariant:(BUYProductVariant *)variant
{
	BUYCartLineItem *lineItem = [self.modelManager buy_objectWithEntityName:[BUYCartLineItem entityName] JSONDictionary:nil];
	lineItem.variant = variant;
	return lineItem;
}

- (BUYCartLineItem *)linetItemForVariant:(BUYProductVariant *)variant
{
	return [[self.lineItems filteredOrderedSetUsingPredicate:[NSPredicate predicateWithFormat:@"variant = %@", variant]] lastObject];
}

@end
