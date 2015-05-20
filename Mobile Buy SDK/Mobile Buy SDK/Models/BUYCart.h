//
//  BUYCart.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;
#import "BUYSerializable.h"

@class BUYLineItem;
@class BUYProductVariant;

/**
 *  The BUYCart is the starting point for the Checkout API. You are responsible for building a cart, then transforming it
 *  into a BUYCheckout using the BUYDataProvider.
 */
@interface BUYCart : NSObject <BUYSerializable>

@property (nonatomic, readonly, copy) NSArray *lineItems;

/**
 *  Returns true if the cart is acceptable to send to Shopify.
 */
- (BOOL)isValid;

/**
 *  Empties the cart and any custom-stored propreties.
 */
- (void)clearCart;

#pragma mark - Simple Cart Editing

/**
 *  Adds a BUYProductVariant to the BUYCart.
 *  If the associated BUYLineItem exists, that BUYLineItem's quantity is increased by one.
 *
 *  @param variant The BUYProductVariant to add to the BUYCart
 */
- (void)addVariant:(BUYProductVariant *)variant;

/**
 *  Removes a BUYProductVariant from the BUYCart.
 *  If the associated BUYLineItem exists, that BUYLineItem's quantity is decreased by one.
 *
 *  @param variant The BUYProductVariant to remove from the BUYCart
 */
- (void)removeVariant:(BUYProductVariant *)variant;

#pragma mark - Direct Line Item Editing

/**
 *  Adds a custom-built BUYLineItem to the BUYCart.
 *
 *  @param object BUYLineItem to add the the BUYCart
 */
- (void)addLineItemsObject:(BUYLineItem *)object;

/**
 *  Removes a BUYLineItem from the BUYCart, including all BUYProductVariant's
 *
 *  @param object BUYLineItem to remove from the BUYCart
 */
- (void)removeLineItemsObject:(BUYLineItem *)object;

@end
