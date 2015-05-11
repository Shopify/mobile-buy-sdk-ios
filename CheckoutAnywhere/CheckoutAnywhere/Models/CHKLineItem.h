//
//  CHKLineItem.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKSerializable.h"
#import "CHKObject.h"

@class CHKProductVariant;

/**
 *  This represents a CHKLineItem on a CHKCart or on a CHKCheckout.
 */
@interface CHKLineItem : CHKObject <CHKSerializable>

/**
 *  Optional CHKProductVariant.
 */
@property (nonatomic, strong) CHKProductVariant *variant;

/**
 *  The quantity of the CHKLineItem.
 */
@property (nonatomic, strong) NSDecimalNumber *quantity;

/**
 *  The price of the CHKLineItem. 
 *  Note: This price does not need to match the product variant.
 */
@property (nonatomic, strong) NSDecimalNumber *price;

/**
 *  The title of the CHKLineItem.
 *  Note: The title does not need to match the product variant.
 */
@property (nonatomic, copy) NSString *title;

/**
 *  YES if this CHKLineItem requires shipping.
 *  Note: This needs to match the product variant.
 */
@property (nonatomic, strong) NSNumber *requiresShipping;

/**
 *  Initialize a CHKLineItem with an optional variant.
 *  Note: We recommend setting up a CHKCart and using `addVariant:`, which handles incrementing
 *  existing variants for line items in a cart
 *
 *  @param variant A CHKProductVariant to initialize the CHKLineItem with
 *
 *  @return Returns an instance of CHKLineItem
 */
- (instancetype)initWithVariant:(CHKProductVariant *)variant;

@end
