//
//  _BUYCart.h
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
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BUYCart.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCartRelationships {
	__unsafe_unretained NSString *lineItems;
} BUYCartRelationships;

extern const struct BUYCartUserInfo {
	__unsafe_unretained NSString *discussion;
	__unsafe_unretained NSString *documentation;
	__unsafe_unretained NSString *private;
} BUYCartUserInfo;

@class BUYCartLineItem;

@class BUYCart;
@interface BUYModelManager (BUYCartInserting)
- (NSArray<BUYCart *> *)allCartObjects;
- (BUYCart *)fetchCartWithIdentifierValue:(int64_t)identifier;
- (BUYCart *)insertCartWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCart *> *)insertCartsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A collection of products the user intends to purchase.
 *
 * The BUYCart is the starting point for the Checkout API. You are responsible for building a cart, then transforming it into a BUYCheckout using the BUYDataClient. Private to app.
 */
@interface _BUYCart : BUYCachedObject
+ (NSString *)entityName;

/**
 * Array of BUYCartLineItem objects in the cart
 *
 * These are different from BUYLineItem objects. The line item objects do include the BUYProductVariant.
 */
@property (nonatomic, strong) NSOrderedSet *lineItems;
- (NSMutableOrderedSet *)lineItemsSet;

@end

@interface _BUYCart (LineItemsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYCartLineItem *)value inLineItemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLineItemsAtIndex:(NSUInteger)idx;
- (void)insertLineItems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLineItemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLineItemsAtIndex:(NSUInteger)idx withObject:(BUYCartLineItem *)value;
- (void)replaceLineItemsAtIndexes:(NSIndexSet *)indexes withLineItems:(NSArray *)values;

@end

@interface _BUYCart (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableOrderedSet *)primitiveLineItems;
- (void)setPrimitiveLineItems:(NSMutableOrderedSet *)value;

@end
