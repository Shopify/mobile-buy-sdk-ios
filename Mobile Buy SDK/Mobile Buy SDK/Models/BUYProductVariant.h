//
//  BUYProductVariant.h
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

#import "BUYObject.h"

@class BUYProduct;

/**
 *  A BUYProductVariant is a different version of a product, such as differing sizes or differing colours.
 */
@interface BUYProductVariant : BUYObject

/**
 *  The BUYProduct associated this BUYProductVariant
 */
@property (nonatomic, strong) BUYProduct *product;

/**
 *  The title of the BUYProductVariant.
 */
@property (nonatomic, readonly, copy) NSString *title;

/**
 *  Custom properties that a shop owner can use to define BUYProductVariants.
 */
@property (nonatomic, readonly, copy) NSArray *options;

/**
 *  The price of the BUYProductVariant.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *price;

/**
 *  The competitor's prices for the same item.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *compareAtPrice;

/**
 *  The weight of the BUYProductVariant in grams.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *grams;

/**
 *  Specifies whether or not a customer needs to provide a shipping address when placing an order for this BUYProductVariant.
 *  Valid values are:
 *  true: Customer needs to supply a shipping address.
 *  false: Customer does not need to supply a shipping address.
 */
@property (nonatomic, readonly, strong) NSNumber *requiresShipping;

/**
 *  A unique identifier for the product in the shop.
 */
@property (nonatomic, readonly, strong) NSString *sku;

/**
 *  Specifies whether or not a tax is charged when the BUYProductVariant is sold.
 */
@property (nonatomic, readonly, strong) NSNumber *taxable;

/**
 *  The order of the BUYProductVariant in the list of product variants. 1 is the first position.
 */
@property (nonatomic, readonly, strong) NSNumber *position;

/**
 *  If the variant is in stock
 */
@property (nonatomic, readonly, assign) BOOL available;

@end
