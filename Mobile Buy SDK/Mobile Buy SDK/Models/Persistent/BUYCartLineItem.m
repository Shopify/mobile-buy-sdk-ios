//
//  _BUYCartLineItem.m
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

#import "BUYCartLineItem.h"
#import "BUYProductVariant.h"
#import "BUYModelManager.h"

@implementation BUYCartLineItem

#if defined CORE_DATA_PERSISTENCE
- (void)awakeFromInsert
{
	self.quantity = [NSDecimalNumber one];
}
#else
- (instancetype)init
{
	self = [super init];
	if (self) {
		self.quantity = [NSDecimalNumber one];
	}
	return self;
}
#endif

+ (NSSet *)keyPathsForValuesAffectingLinePrice
{
	NSString *variantPriceKeyPath = [@[BUYCartLineItemRelationships.variant, BUYProductVariantAttributes.price] componentsJoinedByString:@"."];
	return [NSSet setWithObjects:BUYCartLineItemAttributes.quantity, variantPriceKeyPath, nil];
}

- (NSNumber *)variantId
{
	return self.variant.identifier;
}

- (NSDecimalNumber *)linePrice
{
	return [self.quantity decimalNumberByMultiplyingBy:self.variant.price];
}

- (NSDecimalNumber *)addQuantity:(NSDecimalNumber *)amount
{
	NSDecimalNumber *quantity = [self.quantity decimalNumberByAdding:amount];
	self.quantity = quantity;
	return quantity;
}

- (NSDecimalNumber *)subtractQuantity:(NSDecimalNumber *)amount
{
	NSDecimalNumber *quantity = self.quantity ?: [NSDecimalNumber zero];
	if ([quantity compare:amount] == NSOrderedDescending) {
		quantity = [quantity decimalNumberBySubtracting:amount];
	}
	else {
		quantity = [NSDecimalNumber zero];
	}
	self.quantity = quantity;
	return quantity;
}

- (NSDecimalNumber *)incrementQuantity
{
	return [self addQuantity:[NSDecimalNumber one]];
}

- (NSDecimalNumber *)decrementQuantity
{
	return [self subtractQuantity:[NSDecimalNumber one]];
}

@end

@implementation BUYModelManager (BUYCartLineItemCreation)

- (BUYCartLineItem *)cartLineItemWithVariant:(BUYProductVariant *)variant
{
	BUYCartLineItem *lineItem = [self insertCartLineItemWithJSONDictionary:nil];
	lineItem.variant = variant;
	return lineItem;
}

@end
