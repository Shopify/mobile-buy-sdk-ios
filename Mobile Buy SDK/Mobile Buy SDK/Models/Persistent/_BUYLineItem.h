//
//  _BUYLineItem.h
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
// Make changes to BUYLineItem.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYLineItemAttributes {
	__unsafe_unretained NSString *compareAtPrice;
	__unsafe_unretained NSString *fulfilled;
	__unsafe_unretained NSString *fulfillmentService;
	__unsafe_unretained NSString *grams;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *linePrice;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *productId;
	__unsafe_unretained NSString *properties;
	__unsafe_unretained NSString *quantity;
	__unsafe_unretained NSString *requiresShipping;
	__unsafe_unretained NSString *sku;
	__unsafe_unretained NSString *taxable;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *variantId;
	__unsafe_unretained NSString *variantTitle;
} BUYLineItemAttributes;

extern const struct BUYLineItemRelationships {
	__unsafe_unretained NSString *checkout;
	__unsafe_unretained NSString *order;
} BUYLineItemRelationships;

extern const struct BUYLineItemUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYLineItemUserInfo;

@class BUYCheckout;
@class BUYOrder;

@class NSDictionary;

@class BUYLineItem;
@interface BUYModelManager (BUYLineItemInserting)
- (NSArray<BUYLineItem *> *)allLineItemObjects;
- (BUYLineItem *)fetchLineItemWithIdentifierValue:(int64_t)identifier;
- (BUYLineItem *)insertLineItemWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYLineItem *> *)insertLineItemsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * This represents a BUYLineItem on a BUYCart or on a BUYCheckout.
 */
@interface _BUYLineItem : BUYCachedObject
+ (NSString *)entityName;

/**
 * The competitor's prices for the same item.
 */
@property (nonatomic, strong) NSDecimalNumber* compareAtPrice;

@property (nonatomic, strong) NSNumber* fulfilled;

@property (atomic) BOOL fulfilledValue;
- (BOOL)fulfilledValue;
- (void)setFulfilledValue:(BOOL)value_;

/**
 * Service provider who is doing the fulfillment.
 */
@property (nonatomic, strong) NSString* fulfillmentService;

/**
 * The weight of the BUYProductVariant in grams.
 */
@property (nonatomic, strong) NSDecimalNumber* grams;

@property (nonatomic, strong) NSString* identifier;

/**
 * The line price of the item (price * quantity).
 */
@property (nonatomic, strong) NSDecimalNumber* linePrice;

/**
 * The price of the BUYLineItem.
 *
 * This price does not need to match the product variant.
 */
@property (nonatomic, strong) NSDecimalNumber* price;

@property (nonatomic, strong) NSNumber* productId;

@property (atomic) int64_t productIdValue;
- (int64_t)productIdValue;
- (void)setProductIdValue:(int64_t)value_;

/**
 * Custom properties set on the line item.
 */
@property (nonatomic, strong) NSDictionary* properties;

/**
 * The quantity of the BUYLineItem.
 */
@property (nonatomic, strong) NSDecimalNumber* quantity;

/**
 * Whether this BUYLineItem requires shipping.
 *
 * This needs to match the product variant.
 */
@property (nonatomic, strong) NSNumber* requiresShipping;

@property (atomic) BOOL requiresShippingValue;
- (BOOL)requiresShippingValue;
- (void)setRequiresShippingValue:(BOOL)value_;

/**
 * The unique SKU for the line item.
 */
@property (nonatomic, strong) NSString* sku;

/**
 * Whether the line item is taxable.
 */
@property (nonatomic, strong) NSNumber* taxable;

@property (atomic) BOOL taxableValue;
- (BOOL)taxableValue;
- (void)setTaxableValue:(BOOL)value_;

/**
 * The title of the BUYLineItem.
 *
 * The title does not need to match the product variant.
 */
@property (nonatomic, strong) NSString* title;

/**
 * BUYProductVariant identifer.
 *
 * Keep a reference to a cart or products if you wish to display information for product variants in a BUYCheckout.
 */
@property (nonatomic, strong) NSNumber* variantId;

@property (atomic) int64_t variantIdValue;
- (int64_t)variantIdValue;
- (void)setVariantIdValue:(int64_t)value_;

/**
 * The title for the variant in the line item.
 */
@property (nonatomic, strong) NSString* variantTitle;

/**
 * Inverse of Checkout.lineItem.
 */

@property (nonatomic, strong) BUYCheckout *checkout;

@property (nonatomic, strong) BUYOrder *order;

@end

@interface _BUYLineItem (CoreDataGeneratedPrimitiveAccessors)

- (NSDecimalNumber*)primitiveCompareAtPrice;
- (void)setPrimitiveCompareAtPrice:(NSDecimalNumber*)value;

- (NSNumber*)primitiveFulfilled;
- (void)setPrimitiveFulfilled:(NSNumber*)value;

- (NSString*)primitiveFulfillmentService;
- (void)setPrimitiveFulfillmentService:(NSString*)value;

- (NSDecimalNumber*)primitiveGrams;
- (void)setPrimitiveGrams:(NSDecimalNumber*)value;

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;

- (NSDecimalNumber*)primitiveLinePrice;
- (void)setPrimitiveLinePrice:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSDecimalNumber*)value;

- (NSNumber*)primitiveProductId;
- (void)setPrimitiveProductId:(NSNumber*)value;

- (NSDictionary*)primitiveProperties;
- (void)setPrimitiveProperties:(NSDictionary*)value;

- (NSDecimalNumber*)primitiveQuantity;
- (void)setPrimitiveQuantity:(NSDecimalNumber*)value;

- (NSNumber*)primitiveRequiresShipping;
- (void)setPrimitiveRequiresShipping:(NSNumber*)value;

- (NSString*)primitiveSku;
- (void)setPrimitiveSku:(NSString*)value;

- (NSNumber*)primitiveTaxable;
- (void)setPrimitiveTaxable:(NSNumber*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSNumber*)primitiveVariantId;
- (void)setPrimitiveVariantId:(NSNumber*)value;

- (NSString*)primitiveVariantTitle;
- (void)setPrimitiveVariantTitle:(NSString*)value;

- (BUYCheckout *)primitiveCheckout;
- (void)setPrimitiveCheckout:(BUYCheckout *)value;

- (BUYOrder *)primitiveOrder;
- (void)setPrimitiveOrder:(BUYOrder *)value;

@end
