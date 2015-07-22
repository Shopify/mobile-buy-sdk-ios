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
@class BUYCartLineItem;
@class BUYProductVariant;

/**
 *  The BUYCart is the starting point for the Checkout API. You are responsible for building a cart, then transforming it
 *  into a BUYCheckout using the BUYDataClient.
 */
@interface BUYCart : NSObject <BUYSerializable>

/**
 *  Array of BUYCartLineItem objects in the cart
 *  Note: These are different from BUYLineItem objects in that
 *  the line item objects do include the BUYProductVariant.
 */
@property (nonatomic, strong, readonly) NSArray *lineItems;

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
 *  Adds a BUYCartLineItem to the BUYCart with the given BUYProductVariant object on it.
 *  If the associated BUYCartLineItem exists, that BUYCartLineItem's quantity is increased by one.
 *
 *  @param variant The BUYProductVariant to add to the BUYCart or increase by one quantity
 */
- (void)addVariant:(BUYProductVariant *)variant;

/**
 *  Removes the BUYCartLineItem from the BUYCart associated with the given BUYProductVariant object.
 *  If the associated BUYCartLineItem exists, that BUYCartLineItem's quantity is decreased by one.
 *
 *  @param variant The BUYProductVariant to remove from the BUYCart or decrease by one quantity
 */
- (void)removeVariant:(BUYProductVariant *)variant;

@end
