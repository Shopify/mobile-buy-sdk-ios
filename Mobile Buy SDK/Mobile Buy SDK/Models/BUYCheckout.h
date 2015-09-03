//
//  BUYCheckout.h
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
#import "BUYSerializable.h"

@class BUYAddress;
@class BUYCart;
@class BUYCreditCard;
@class BUYDiscount;
@class BUYShippingRate;
@class BUYTaxLine;
@class BUYMaskedCreditCard;

/**
 *  The checkout object. This is the main object that you will interact with when creating orders on Shopify.
 *
 *  Note: Do not create a BUYCheckout object directly. Use initWithCart: to transform a BUYCart into a BUYCheckout.
 */
@interface BUYCheckout : BUYObject <BUYSerializable>

/**
 *  The customer's email address
 */
@property (nonatomic, copy) NSString *email;

/**
 *  Unique token for the checkout on Shopify
 */
@property (nonatomic, copy, readonly) NSString *token;

/**
 *  Unique token for a cart which can be used to convert to a checkout
 */
@property (nonatomic, copy, readonly) NSString *cartToken;

/**
 *  The unique order ID
 */
@property (nonatomic, copy, readonly) NSNumber *orderId;

/**
 *  States whether or not the fulfillment requires shipping
 */
@property (nonatomic, assign, readonly) BOOL requiresShipping;

/**
 *  States whether or not the taxes are included in the price
 */
@property (nonatomic, assign, readonly) BOOL taxesIncluded;

/**
 *  The three letter code (ISO 4217) for the currency used for the payment
 */
@property (nonatomic, copy, readonly) NSString *currency;

/**
 *  Price of the order before shipping and taxes
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *subtotalPrice;

/**
 *  The sum of all the taxes applied to the line items in the order
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *totalTax;

/**
 *  The sum of all the prices of all the items in the order, taxes and discounts included
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *totalPrice;

/**
 *  The Payment Session ID associated with a credit card transaction
 */
@property (nonatomic, strong, readonly) NSString *paymentSessionId;

/**
 *  URL to the payment gateway
 */
@property (nonatomic, strong, readonly) NSURL *paymentURL;

/**
 *  Reservation time on the checkout in seconds. Setting to @0 and updating the checkout 
 *  will release inventory reserved by the checkout (when product inventory is not infinite).
 *
 *  300 seconds is default and maximum. `reservationTime` is reset to @300 on every
 *  `updateCheckout:completion:` call.
 *
 *  Note: This can also be done with `removeProductReservationsFromCheckout:completion` 
 *  found in the BUYClient.
 */
@property (nonatomic, strong) NSNumber *reservationTime;

/**
 *  Reservation time remaining on the checkout in seconds
 */
@property (nonatomic, strong, readonly) NSNumber *reservationTimeLeft;

/**
 *  Amount of payment due on the checkout
 */
@property (nonatomic, strong, readonly) NSDecimalNumber *paymentDue;

/**
 *  Array of BUYLineItem objects in the checkout
 *  Note: These are different from BUYCartLineItems in that the line item
 *  objects do not include the BUYProductVariant
 */
@property (nonatomic, readonly, copy) NSArray *lineItems;

/**
 *  Array of tax line objects on the checkout
 */
@property (nonatomic, readonly, copy) NSArray *taxLines;

/**
 *  The mailing address associated with the payment method
 */
@property (nonatomic, strong) BUYAddress *billingAddress;

/**
 *  The mailing address to where the order will be shipped
 */
@property (nonatomic, strong) BUYAddress *shippingAddress;

/**
 *  The shipping rate chosen for the checkout
 */
@property (nonatomic, strong) BUYShippingRate *shippingRate;

/**
 *  Shipping rate identifier
 */
@property (nonatomic, readonly) NSString *shippingRateId;

/**
 *  A discount added to the checkout
 *  Only one discount can be added to a checkout. Call `updateCheckout:completion:`
 *  after adding a discount to apply the discount code to the checkout.
 */
@property (nonatomic, strong) BUYDiscount *discount;

/**
 *  An array of BUYGiftCard objects applied to the checkout
 */
@property (nonatomic, strong, readonly) NSArray *giftCards;

/**
 *  URL for the website showing the order status
 */
@property (nonatomic, strong, readonly) NSURL *orderStatusURL;

/**
 *  Channel ID where the checkout was created
 */
@property (nonatomic, strong) NSString *channelId;

/**
 *  Attributions for the checkout, containing the application name and platform (defaults to applicationName set 
 *  on the BUYClient, and "iOS" respectively
 */
@property (nonatomic, strong) NSDictionary *marketingAttribution;

/**
 *  URL which is used for completing checkout.  It is recommended to open the URL in Safari to take
 *  advantage of its autocompletion and credit card capture capabilities
 */
@property (nonatomic, strong, readonly) NSURL *webCheckoutURL;

/**
 *  The URL Scheme of the host app.  Used to return to the app from the web checkout
 */
@property (nonatomic, strong) NSString *webReturnToURL;

/**
 *  The button title that will appear after checkout to return to the host app.  Defaults to "Return to 'application'", 
 *  where 'application' is the `applicationName` set on the BUYClient
 */
@property (nonatomic, strong) NSString *webReturnToLabel;

/**
 *  Creation date of the checkout
 */
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

/**
 *  Last updated date for the checkout
 */
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

/**
 *  The website URL for the privacy policy for the checkout
 */
@property (nonatomic, strong, readonly) NSURL *privacyPolicyURL;

/**
 *  The website URL for the refund policy for the checkout
 */
@property (nonatomic, strong, readonly) NSURL *refundPolicyURL;

/**
 *  The website URL for the terms of service for the checkout
 */
@property (nonatomic, strong, readonly) NSURL *termsOfServiceURL;

/**
 *  The name of the source of the checkout: "mobile_app"
 */
@property (nonatomic, copy, readonly) NSString *sourceName;

/**
 *  The unique identifier for the source: the channelId
 */
@property (nonatomic, copy, readonly) NSString *sourceIdentifier;

/**
 *  Credit card stored on the checkout
 */
@property (nonatomic, strong, readonly) BUYMaskedCreditCard *creditCard;

/**
 *  Customer ID associated with the checkout
 */
@property (nonatomic, copy, readonly) NSString *customerId;

/**
 *  It is recommended to instantiate a checkout with a cart, or cart token
 *
 *  @return Checkout
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Creates a new checkout
 *
 *  @param cart a Cart with line items on it
 *
 *  @return a checkout object
 */
- (instancetype)initWithCart:(BUYCart *)cart;

/**
 *  Creates a new checkout
 *
 *  @param cartToken a token for a previously created cart
 *
 *  @return a checkout object
 */
- (instancetype)initWithCartToken:(NSString *)cartToken;

/**
 *  Helper method to determine if there is a valid token on the checkout
 *
 *  @return YES if the token is valid
 */
- (BOOL)hasToken;

@end
