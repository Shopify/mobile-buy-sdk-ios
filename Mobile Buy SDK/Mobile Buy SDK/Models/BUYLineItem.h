//
//  BUYLineItem.h
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

#import "BUYSerializable.h"
#import "BUYObject.h"

@class BUYProductVariant;

/**
 *  This represents a BUYLineItem on a BUYCart or on a BUYCheckout.
 */
@interface BUYLineItem : BUYObject <BUYSerializable>

/**
 *  The unique line item identifier
 */
@property (nonatomic, strong, readonly) NSString *lineItemIdentifier;

/**
 *  BUYProductVariant identifer. Keep a reference to a cart or products if you wish to 
 *  display information for product variants in a BUYCheckout
 */
@property (nonatomic, strong, readonly) NSNumber *variantId;

/**
 *  The `BUYProduct` product ID for the product in the line item
 */
@property (nonatomic, strong, readonly) NSNumber *productId;

/**
 *  The quantity of the BUYLineItem.
 */
@property (nonatomic, strong) NSDecimalNumber *quantity;

/**
 *  The weight of the BUYProductVariant in grams.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *grams;

/**
 *  The price of the BUYLineItem.
 *  Note: This price does not need to match the product variant.
 */
@property (nonatomic, strong) NSDecimalNumber *price;

/**
 *  The line price of the item (price * quantity)
 */
@property (nonatomic, strong) NSDecimalNumber *linePrice;

/**
 *  The competitor's prices for the same item.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *compareAtPrice;

/**
 *  The title of the BUYLineItem.
 *  Note: The title does not need to match the product variant.
 */
@property (nonatomic, copy) NSString *title;

/**
 *  The title for the variant in the line item
 */
@property (nonatomic, copy) NSString *variantTitle;

/**
 *  YES if this BUYLineItem requires shipping.
 *  Note: This needs to match the product variant.
 */
@property (nonatomic, strong) NSNumber *requiresShipping;

/**
 *  The unique SKU for the line item
 */
@property (nonatomic, readonly, copy) NSString *sku;

/**
 *  If the line item is taxable
 */
@property (nonatomic, readonly, assign) BOOL taxable;

/**
 *  Custom properties set on the line item
 */
@property (nonatomic, copy) NSDictionary *properties;

/**
 *  Service provider who is doing the fulfillment
 */
@property (nonatomic, readonly, copy) NSString *fulfillmentService;

/**
 *  Initialize a BUYLineItem with an optional variant.
 *  Note: We recommend setting up a BUYCart and using `addVariant:`, which handles incrementing
 *  existing variants for line items in a cart
 *
 *  @param variant A BUYProductVariant to initialize the BUYLineItem with
 *
 *  @return Returns an instance of BUYLineItem
 */
- (instancetype)initWithVariant:(BUYProductVariant *)variant;

@end
