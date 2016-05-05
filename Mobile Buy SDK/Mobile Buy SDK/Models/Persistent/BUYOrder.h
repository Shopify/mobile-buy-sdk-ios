//
//  BUYOrder.h
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

@class BUYAddress;
@class BUYLineItem;
@class BUYShippingRate;
@class BUYLineItem;

@interface BUYOrder : BUYObject

/**
 * Whether the order was cancelled or not.
 */
@property (nonatomic, assign, readonly) BOOL cancelled;

/**
 * Whether the fulfillment was aborted or not.
 */
@property (nonatomic, assign, readonly) BOOL fulfillmentAborted;

/**
 * The amount of discounts applied to the price of the order.
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *discountSavings;

/**
 * Price of the order before shipping and taxes
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *subtotalPrice;

/**
 * The sum of all the prices of all the items in the order, taxes and discounts included.
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *totalPrice;

/**
 *  The customer's order name as represented by a number.
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 * The reason why the order was cancelled. If the order was not cancelled, this value is "null." If the order was cancelled, the value will be one of the following:
 *
 * customer:  The customer changed or cancelled the order.
 * fraud:     The order was fraudulent.
 * inventory: Items in the order were not in inventory.
 * other:     The order was cancelled for a reason not in the list above.
 */
@property (nonatomic, strong, readonly) NSString *cancelReason;

/**
 * The three letter code (ISO 4217) for the currency used for the payment.
 */
@property (nonatomic, strong, readonly) NSString *currency;

/**
 * The state of finances. Value will be one of the following:
 *
 * pending:            The finances are pending.
 * authorized:         The finances have been authorized.
 * partially_paid:     The finances have been partially paid.
 * paid:               The finances have been paid. (This is the default value.)
 * partially_refunded: The finances have been partially refunded.
 * refunded:           The finances have been refunded.
 * voided:             The finances have been voided.
 */
@property (nonatomic, strong, readonly) NSString *financialStatus;

/**
 * The status of the fulfillment. Value will be one of the following:
 *
 * nil:       None of the line items in the order have been fulfilled.
 * partial:   At least one line item in the order has been fulfilled.
 * fulfilled: Every line item in the order has been fulfilled.
 */
@property (nonatomic, strong, readonly) NSString *fulfillmentStatus;

/**
 * A unique numeric identifier for the order. This one is used by the shop owner and customer. 
 * This is different from the id property, which is also a unique numeric identifier for the order, 
 * but used for API purposes.
 */
@property (nonatomic, strong, readonly) NSNumber *orderNumber;

/**
 * The URL for the customer.
 */
@property (nonatomic, strong, readonly) NSURL *customerURL;

/**
 * The URL pointing to the order status web page. The URL will be null unless the order was created from a checkout.
 */
@property (nonatomic, strong, readonly) NSURL *orderStatusURL;

/**
 *  URL for the website showing the order status
 */
@property (nonatomic, strong, readonly) NSURL *statusURL;

/**
 * The date and time when the order was imported, in ISO 8601 format.
 */
@property (nonatomic, strong, readonly) NSDate *processedAt;

/**
 * The date and time when the order was cancelled, in ISO 8601 format. Nil if the order was not cancelled.
 */
@property (nonatomic, strong, readonly) NSDate *cancelledAt;

/**
 * The mailing address to where the order will be shipped. This address is optional and will not be available on orders that do not require one.
 */
@property (nonatomic, strong, readonly) BUYAddress *shippingAddress;

/**
 * The mailing address associated with the payment method. This address is an optional field that will not be available on orders that do not require one.
 */
@property (nonatomic, strong, readonly) BUYAddress *billingAddress;

/**
 * An array of shipping rate objects.
 */
@property (nonatomic, strong, readonly) NSArray<BUYShippingRate *> *shippingRates;

/**
 * An array of fulfilled line item objects.
 */
@property (nonatomic, strong, readonly) NSArray<BUYLineItem *> *fulfilledLineItems;

/**
 * An array of unfulfilled line item objects.
 */
@property (nonatomic, strong, readonly) NSArray<BUYLineItem *> *unfulfilledLineItems;

@end
