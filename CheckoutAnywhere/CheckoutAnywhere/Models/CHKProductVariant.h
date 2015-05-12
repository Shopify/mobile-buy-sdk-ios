//
//  CHKProductVariant.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"

@class CHKProduct;

/**
 *  A CHKProductVariant is a different version of a product, such as differing sizes or differing colours.
 */
@interface CHKProductVariant : CHKObject

/**
 *  The CHKProduct associated this CHKProductVariant
 */
@property (nonatomic, strong) CHKProduct *product;

/**
 *  The title of the CHKProductVariant.
 */
@property (nonatomic, readonly, copy) NSString *title;

/**
 *  Custom properties that a shop owner can use to define CHKProductVariants. 
 *  Multiple options can exist. Options are represented as: option1, option2, option3.
 */
@property (nonatomic, readonly, copy) NSString *option1;
@property (nonatomic, readonly, copy) NSString *option2;
@property (nonatomic, readonly, copy) NSString *option3;

/**
 *  The price of the CHKProductVariant.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *price;

/**
 *  The competitor's prices for the same item.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *compareAtPrice;

/**
 *  The weight of the CHKProductVariant in grams.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *grams;

/**
 *  Specifies whether or not a customer needs to provide a shipping address when placing an order for this CHKProductVariant.
 *  Valid values are:
 *  true: Customer needs to supply a shipping address.
 *  false: Customer does not need to supply a shipping address.
 */
@property (nonatomic, readonly, strong) NSNumber *requiresShipping;

/**
 *  Specifies whether or not a tax is charged when the CHKProductVariant is sold.
 */
@property (nonatomic, readonly, strong) NSNumber *taxable;

/**
 *  The order of the CHKProductVariant in the list of product variants. 1 is the first position.
 */
@property (nonatomic, readonly, strong) NSNumber *position;

@end
