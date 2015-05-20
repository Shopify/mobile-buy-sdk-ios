//
//  BUYLineItem.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYSerializable.h"
#import "BUYObject.h"

@class BUYProductVariant;

/**
 *  This represents a BUYLineItem on a BUYCart or on a BUYCheckout.
 */
@interface BUYLineItem : BUYObject <BUYSerializable>

/**
 *  Optional BUYProductVariant.
 */
@property (nonatomic, strong) BUYProductVariant *variant;

/**
 *  The quantity of the BUYLineItem.
 */
@property (nonatomic, strong) NSDecimalNumber *quantity;

/**
 *  The price of the BUYLineItem.
 *  Note: This price does not need to match the product variant.
 */
@property (nonatomic, strong) NSDecimalNumber *price;

/**
 *  The title of the BUYLineItem.
 *  Note: The title does not need to match the product variant.
 */
@property (nonatomic, copy) NSString *title;

/**
 *  YES if this BUYLineItem requires shipping.
 *  Note: This needs to match the product variant.
 */
@property (nonatomic, strong) NSNumber *requiresShipping;

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
