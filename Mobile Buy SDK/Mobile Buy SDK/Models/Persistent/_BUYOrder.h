//
//  _BUYOrder.h
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
// Make changes to BUYOrder.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYOrderAttributes {
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *orderStatusURL;
	__unsafe_unretained NSString *processedAt;
	__unsafe_unretained NSString *statusURL;
	__unsafe_unretained NSString *subtotalPrice;
	__unsafe_unretained NSString *totalPrice;
} BUYOrderAttributes;

extern const struct BUYOrderRelationships {
	__unsafe_unretained NSString *checkout;
	__unsafe_unretained NSString *lineItems;
} BUYOrderRelationships;

extern const struct BUYOrderUserInfo {
	__unsafe_unretained NSString *attributeValueClassName;
	__unsafe_unretained NSString *documentation;
} BUYOrderUserInfo;

@class BUYCheckout;
@class BUYLineItem;

@class NSURL;

@class NSURL;

@class BUYOrder;
@interface BUYModelManager (BUYOrderInserting)
- (NSArray<BUYOrder *> *)allOrderObjects;
- (BUYOrder *)fetchOrderWithIdentifierValue:(int64_t)identifier;
- (BUYOrder *)insertOrderWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYOrder *> *)insertOrdersWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * URL for the website showing the order status, doesn't require a customer token.
 */
@interface _BUYOrder : BUYCachedObject
+ (NSString *)entityName;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * The customer's order name as represented by a number.
 */
@property (nonatomic, strong) NSString* name;

/**
 * URL for the website showing the order status.
 */
@property (nonatomic, strong) NSURL* orderStatusURL;

@property (nonatomic, strong) NSDate* processedAt;

@property (nonatomic, strong) NSURL* statusURL;

@property (nonatomic, strong) NSDecimalNumber* subtotalPrice;

@property (nonatomic, strong) NSDecimalNumber* totalPrice;

/**
 * Inverse of Checkout.order.
 */

@property (nonatomic, strong) BUYCheckout *checkout;

@property (nonatomic, strong) NSOrderedSet *lineItems;
- (NSMutableOrderedSet *)lineItemsSet;

@end

@interface _BUYOrder (LineItemsCoreDataGeneratedAccessors)

- (void)insertObject:(BUYLineItem *)value inLineItemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLineItemsAtIndex:(NSUInteger)idx;
- (void)insertLineItems:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLineItemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLineItemsAtIndex:(NSUInteger)idx withObject:(BUYLineItem *)value;
- (void)replaceLineItemsAtIndexes:(NSIndexSet *)indexes withLineItems:(NSArray *)values;

@end

@interface _BUYOrder (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSURL*)primitiveOrderStatusURL;
- (void)setPrimitiveOrderStatusURL:(NSURL*)value;

- (NSDate*)primitiveProcessedAt;
- (void)setPrimitiveProcessedAt:(NSDate*)value;

- (NSURL*)primitiveStatusURL;
- (void)setPrimitiveStatusURL:(NSURL*)value;

- (NSDecimalNumber*)primitiveSubtotalPrice;
- (void)setPrimitiveSubtotalPrice:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveTotalPrice;
- (void)setPrimitiveTotalPrice:(NSDecimalNumber*)value;

- (BUYCheckout *)primitiveCheckout;
- (void)setPrimitiveCheckout:(BUYCheckout *)value;

- (NSMutableOrderedSet *)primitiveLineItems;
- (void)setPrimitiveLineItems:(NSMutableOrderedSet *)value;

@end
