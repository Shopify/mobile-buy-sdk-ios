//
//  CHKCart.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKSerializable.h"

@class CHKLineItem;
@class MERProductVariant;

@interface CHKCart : NSObject <CHKSerializable>

@property (nonatomic, readonly, copy) NSArray *lineItems;

/**
 * Returns true if the cart is acceptable to send to Shopify.
 */
- (BOOL)isValid;

/**
 * Empties the cart and any custom-stored propreties.
 */
- (void)clearCart;

#pragma mark - Simple Cart Editing

/**
 * Adds a variant to the cart. If the existing line item exists, that line item's quantity is increased by one.
 */
- (void)addVariant:(MERProductVariant *)variant;

/**
 * Removes a variant from the cart. If the existing line item exists, that line item's quantity is decreased by one.
 */
- (void)removeVariant:(MERProductVariant *)variant;

#pragma mark - Direct Line Item Editing

/**
 * Adds a custom-built line item to the cart.
 */
- (void)addLineItemsObject:(CHKLineItem *)object;

/**
 * Completely removes a line item from the cart.
 */
- (void)removeLineItemsObject:(CHKLineItem *)object;

@end
