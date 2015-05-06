//
//  CHKCart.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;
#import "CHKSerializable.h"

@class CHKLineItem;
@class CHKProductVariant;

/**
 *  The CHKCart is the starting point for the Checkout API. You are responsible for building a cart, then transforming it
 *  into a CHKCheckout using the CHKDataProvider.
 */
@interface CHKCart : NSObject <CHKSerializable>

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
 *  Adds a CHKProductVariant to the CHKCart.
 *  If the associated CHKLineItem exists, that CHKLineItem's quantity is increased by one.
 *
 *  @param variant The CHKProductVariant to add to the CHKCart
 */
- (void)addVariant:(CHKProductVariant *)variant;

/**
 *  Removes a CHKProductVariant from the CHKCart.
 *  If the associated CHKLineItem exists, that CHKLineItem's quantity is decreased by one.
 *
 *  @param variant The CHKProductVariant to remove from the CHKCart
 */
- (void)removeVariant:(CHKProductVariant *)variant;

#pragma mark - Direct Line Item Editing

/**
 *  Adds a custom-built CHKLineItem to the CHKCart.
 *
 *  @param object CHKLineItem to add the the CHKCart
 */
- (void)addLineItemsObject:(CHKLineItem *)object;

/**
 *  Removes a CHKLineItem from the CHKCart, including all CHKProductVariant's
 *
 *  @param object CHKLineItem to remove from the CHKCart
 */
- (void)removeLineItemsObject:(CHKLineItem *)object;

@end
