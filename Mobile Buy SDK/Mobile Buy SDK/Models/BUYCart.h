//
//  BUYCart.h
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

/**
 *  Adds a BUYCartLineItem with a set quantity to the BUYCart with the given BUYProductVariant object on it.
 *  If the associated BUYCartLineItem exists, that BUYCartLineItem's quantity is overriden with the quantity specificed.
 *  If the quantity is 0 the associated BUYCartLineItem is removed from `lineItems`.
 *
 *  @param variant  The BUYProductVariant to add to the BUYCart with a quantity
 *  @param quantity The quantity for the BUYCartLineItem associated with the BUYProductVariant
 */
- (void)setVariant:(BUYProductVariant *)variant withTotalQuantity:(NSInteger)quantity;

@end
