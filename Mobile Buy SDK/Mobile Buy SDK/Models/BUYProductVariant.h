//
//  BUYProductVariant.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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
 *  Specifies whether or not a tax is charged when the BUYProductVariant is sold.
 */
@property (nonatomic, readonly, strong) NSNumber *taxable;

/**
 *  The order of the BUYProductVariant in the list of product variants. 1 is the first position.
 */
@property (nonatomic, readonly, strong) NSNumber *position;

@end
