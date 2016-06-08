//
//  _BUYCartLineItem.h
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
// Make changes to BUYCartLineItem.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCartLineItemAttributes {
	__unsafe_unretained NSString *quantity;
} BUYCartLineItemAttributes;

extern const struct BUYCartLineItemRelationships {
	__unsafe_unretained NSString *cart;
	__unsafe_unretained NSString *variant;
} BUYCartLineItemRelationships;

extern const struct BUYCartLineItemUserInfo {
	__unsafe_unretained NSString *documentation;
	__unsafe_unretained NSString *private;
} BUYCartLineItemUserInfo;

@class BUYCart;
@class BUYProductVariant;

@class BUYCartLineItem;
@interface BUYModelManager (BUYCartLineItemInserting)
- (NSArray<BUYCartLineItem *> *)allCartLineItemObjects;
- (BUYCartLineItem *)fetchCartLineItemWithIdentifierValue:(int64_t)identifier;
- (BUYCartLineItem *)insertCartLineItemWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCartLineItem *> *)insertCartLineItemsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * A line item that references a product variant. Private to app.
 */
@interface _BUYCartLineItem : BUYCachedObject
+ (NSString *)entityName;

/**
 * The quantity of the line item.
 */
@property (nonatomic, strong) NSDecimalNumber* quantity;

/**
 * The inverse relationship of Cart.lineItems.
 */

@property (nonatomic, strong) BUYCart *cart;

/**
 * The BUYProductVariant object associated with the line item when created using the preferred `initWithVariant:` initializer.
 */

@property (nonatomic, strong) BUYProductVariant *variant;

@end

@interface _BUYCartLineItem (CoreDataGeneratedPrimitiveAccessors)

- (NSDecimalNumber*)primitiveQuantity;
- (void)setPrimitiveQuantity:(NSDecimalNumber*)value;

- (BUYCart *)primitiveCart;
- (void)setPrimitiveCart:(BUYCart *)value;

- (BUYProductVariant *)primitiveVariant;
- (void)setPrimitiveVariant:(BUYProductVariant *)value;

@end
