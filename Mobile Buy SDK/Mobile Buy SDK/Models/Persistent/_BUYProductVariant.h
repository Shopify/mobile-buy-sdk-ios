//
//  _BUYProductVariant.h
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
// Make changes to BUYProductVariant.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYProductVariantAttributes {
	__unsafe_unretained NSString *available;
	__unsafe_unretained NSString *compareAtPrice;
	__unsafe_unretained NSString *grams;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *position;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *requiresShipping;
	__unsafe_unretained NSString *sku;
	__unsafe_unretained NSString *taxable;
	__unsafe_unretained NSString *title;
} BUYProductVariantAttributes;

extern const struct BUYProductVariantRelationships {
	__unsafe_unretained NSString *cartLineItems;
	__unsafe_unretained NSString *options;
	__unsafe_unretained NSString *product;
} BUYProductVariantRelationships;

extern const struct BUYProductVariantUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYProductVariantUserInfo;

@class BUYCartLineItem;
@class BUYOptionValue;
@class BUYProduct;

@class BUYProductVariant;
@interface BUYModelManager (BUYProductVariantInserting)
- (NSArray<BUYProductVariant *> *)allProductVariantObjects;
- (BUYProductVariant *)fetchProductVariantWithIdentifierValue:(int64_t)identifier;
- (BUYProductVariant *)insertProductVariantWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYProductVariant *> *)insertProductVariantsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A BUYProductVariant is a different version of a product, such as differing sizes or differing colours.
 */
@interface _BUYProductVariant : BUYCachedObject
+ (NSString *)entityName;

/**
 * If the variant is in stock.
 */
@property (nonatomic, strong) NSNumber* available;

@property (atomic) BOOL availableValue;
- (BOOL)availableValue;
- (void)setAvailableValue:(BOOL)value_;

/**
 * The competitor's prices for the same item.
 */
@property (nonatomic, strong) NSDecimalNumber* compareAtPrice;

/**
 * The weight of the BUYProductVariant in grams.
 */
@property (nonatomic, strong) NSDecimalNumber* grams;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * The order of the BUYProductVariant in the list of product variants. 1 is the first position.
 */
@property (nonatomic, strong) NSNumber* position;

@property (atomic) int32_t positionValue;
- (int32_t)positionValue;
- (void)setPositionValue:(int32_t)value_;

/**
 * The price of the BUYProductVariant.
 */
@property (nonatomic, strong) NSDecimalNumber* price;

/**
 * Whether or not a customer needs to provide a shipping address when placing an order for this BUYProductVariant.
 */
@property (nonatomic, strong) NSNumber* requiresShipping;

@property (atomic) BOOL requiresShippingValue;
- (BOOL)requiresShippingValue;
- (void)setRequiresShippingValue:(BOOL)value_;

/**
 * A unique identifier for the product in the shop.
 */
@property (nonatomic, strong) NSString* sku;

/**
 * Specifies whether or not a tax is charged when the BUYProductVariant is sold.
 */
@property (nonatomic, strong) NSNumber* taxable;

@property (atomic) BOOL taxableValue;
- (BOOL)taxableValue;
- (void)setTaxableValue:(BOOL)value_;

/**
 * The title of the BUYProductVariant.
 */
@property (nonatomic, strong) NSString* title;

/**
 * Inverse of CartLineItem.variant.
 */
@property (nonatomic, strong) NSSet *cartLineItems;
- (NSMutableSet *)cartLineItemsSet;

/**
 * Custom properties that a shop owner can use to define BUYProductVariants.
 */
@property (nonatomic, strong) NSSet *options;
- (NSMutableSet *)optionsSet;

@property (nonatomic, strong) BUYProduct *product;

@end

@interface _BUYProductVariant (CartLineItemsCoreDataGeneratedAccessors)

@end

@interface _BUYProductVariant (OptionsCoreDataGeneratedAccessors)

@end

@interface _BUYProductVariant (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAvailable;
- (void)setPrimitiveAvailable:(NSNumber*)value;

- (NSDecimalNumber*)primitiveCompareAtPrice;
- (void)setPrimitiveCompareAtPrice:(NSDecimalNumber*)value;

- (NSDecimalNumber*)primitiveGrams;
- (void)setPrimitiveGrams:(NSDecimalNumber*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSNumber*)primitivePosition;
- (void)setPrimitivePosition:(NSNumber*)value;

- (NSDecimalNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSDecimalNumber*)value;

- (NSNumber*)primitiveRequiresShipping;
- (void)setPrimitiveRequiresShipping:(NSNumber*)value;

- (NSString*)primitiveSku;
- (void)setPrimitiveSku:(NSString*)value;

- (NSNumber*)primitiveTaxable;
- (void)setPrimitiveTaxable:(NSNumber*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet *)primitiveCartLineItems;
- (void)setPrimitiveCartLineItems:(NSMutableSet *)value;

- (NSMutableSet *)primitiveOptions;
- (void)setPrimitiveOptions:(NSMutableSet *)value;

- (BUYProduct *)primitiveProduct;
- (void)setPrimitiveProduct:(BUYProduct *)value;

@end
