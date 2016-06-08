//
//  BUYClient+Checkout.h
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

#import <Buy/BUYClient.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYCheckout;
@class BUYShippingRate;
@class BUYGiftCard;
@class BUYCreditCard;

@protocol BUYPaymentToken;

/**
 *  Return block containing a BUYCheckout, id<BUYPaymentToken> and/or an NSError
 *
 *  @param checkout      The returned BUYCheckout
 *  @param paymentToken  An opaque payment token type that wraps necessary credentials for payment
 *  @param error         Optional NSError
 */
typedef void (^BUYDataCreditCardBlock)(id<BUYPaymentToken> _Nullable paymentToken, NSError * _Nullable error);

/**
 *  Return block containing a BUYCheckout and/or an NSError
 *
 *  @param checkout The returned BUYCheckout
 *  @param error    Optional NSError
 */
typedef void (^BUYDataCheckoutBlock)(BUYCheckout * _Nullable checkout, NSError * _Nullable error);

/**
 *  Return block containing BUYShippingRate objects, a BUYStatus and/or an NSError
 *
 *  @param shippingRates Array of SHKShippingRates
 *  @param status        A BUYStatus specifying the requested job's completion status
 *  @param error         Optional NSError
 */
typedef void (^BUYDataShippingRatesBlock)(NSArray<BUYShippingRate *> * _Nullable shippingRates, BUYStatus status, NSError * _Nullable error);

/**
 *  Return block containing a BUYGiftCard
 *
 *  @param giftCard A BUYGiftCard
 *  @param error    An optional NSError
 */
typedef void (^BUYDataGiftCardBlock)(BUYGiftCard * _Nullable giftCard, NSError * _Nullable error);

@interface BUYClient (Checkout)

#pragma mark - Checkout -

/**
 *  Updates or create a checkout based on wether or not it has a token
 *
 *  @param checkout   BUYCheckout to create or update
 *  @param completion (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)updateOrCreateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)completion;

/**
 *  Builds a checkout on Shopify. The checkout object is used to prepare an order
 *
 *  @param checkout BUYCheckout to create on Shopify
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Builds a checkout on Shopify using a Cart Token from an existing cart on your Shopify store's storefront.
 *  The BUYCheckout object is used to prepare an order.
 *
 *  @param cartToken Cart Token associated with an existing BUYCheckout on Shopify
 *  @param block     (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block;

/**
 *  Updates a given BUYCheckout on Shopify.
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  Note: A BUYCheckout object with an `orderId` is a completed checkout.
 *
 *  @param checkout The BUYCheckout to updated on Shopify
 *  @param block    (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Retrieves an updated BUYCheckout.
 *
 *  @param checkoutToken The checkout token for which to retrieve the updated checkout
 *  @param block         (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataCheckoutBlock)block;

/**
 *  Finalizes the BUYCheckout associated with the token and charges the payment provider (ex: Credit Card, Apple Pay, etc).
 *  This enqueues a completion job on Shopify and returns immediately.
 *  You must get the job's status by calling checkCompletionStatusOfCheckout:block
 *
 *  Note: There's no guarantee that the BUYCheckout returned will be the same as the one that is passed in.
 *  We recommended using the BUYCheckout returned in the block.
 *
 *  @param checkoutToken The checkout token for which to complete checkout. May be nil if the total checkout amount is equal to $0.00 
 *  @param paymentToken  Opaque payment token object. May be nil if the total checkout amount is equal to $0.00
 *  @param block         (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYOperation
 */
- (BUYOperation *)completeCheckoutWithToken:(nullable NSString *)checkoutToken paymentToken:(_Nullable id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block;

/**
 *  Retrieve the status of a checkout with token. This checks the status of the current payment processing job for the provided checkout.
 *  Once the job is complete (status == BUYStatusComplete), you can retrieve the completed order by calling `getCheckout:completion`
 *
 *  @param checkoutToken  The checkout token for which to retrieve completion status
 *  @param block          (^BUYDataStatusBlock)(BUYCheckout *checkout, BUYStatus status, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getCompletionStatusOfCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataStatusBlock)block;

/**
 *  Retrieve the status of a checkout given a URL obtained in the UIApplicationDelegate method `application:sourceApplication:annotation`
 *
 *  @param url   The URL resource used to open the application
 *  @param block    (^BUYDataStatusBlock)(BUYCheckout *checkout, BUYStatus status, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getCompletionStatusOfCheckoutURL:(NSURL *)url completion:(BUYDataStatusBlock)block;

#pragma mark - Shipping Rates -

/**
 *  Retrieves a list of applicable shipping rates for a given checkout token.
 *  Add the preferred/selected BUYShippingRate to BUYCheckout, then update BUYCheckout
 *
 *  @param checkoutToken The checkout token for which to retrieve shipping rates
 *  @param block         (^BUYDataShippingRatesBlock)(NSArray *shippingRates, BUYStatus status, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getShippingRatesForCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataShippingRatesBlock)block;

#pragma mark - Cards -

/**
 *  Prepares a credit card for usage during the checkout process. This sends it to Shopify's secure servers.
 *  Note: Storing the token does not charge the associated card (credit or otherwise).
 *  The card will be charged upon finalizing the checkout (`completeCheckout:completion:`)
 *
 *  You MUST call `completeCheckout:completion:` after this call and receiving a `paymentSessionId`.
 *  The `paymentSessionId` on the `BUYCheckout` object is not persisted on `updateCheckout:completion:` calls.
 *
 *  @param creditCard BUYCreditCard to prepare for usage
 *  @param checkout   The BUYCheckout associated to the purchase.
 *                    The `billingAddress` stored on the BUYCheckout object is optional and recommended and
 *                    used (if provided) to help with fraud checking.
 *  @param block      (^BUYDataCreditCardBlock)(BUYCheckout *checkout, NSString *paymentSessionId, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)storeCreditCard:(BUYCreditCard *)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)block;

/**
 *  Applies a gift card code to the checkout.
 *
 *  @param giftCardCode The gift card code to apply on an existing checkout on Shopify. Note: This is not the same as the gift card identifier.
 *  @param checkout     An existing BUYCheckout on Shopify
 *  @param block        (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)applyGiftCardCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

/**
 *  Removes a gift card from the checkout.
 *
 *  @param giftCardCode The BUYGiftCard identifier to remove on an existing checkout on Shopify.
 *  @param checkout     An existing BUYCheckout on Shopify
 *  @param block        (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block;

#pragma mark - Reservations -

/**
 *  Convenience method to release all product inventory reservations by setting its
 *  `reservationTime` to `@0` and calls `updateCheckout:completion`. We recommend creating
 *  a new BUYCheckout object from a BUYCart for further API calls.
 *
 *  @param checkoutToken The checkout token for which to expire
 *  @param block         (^BUYDataCheckoutBlock)(BUYCheckout *checkout, NSError *error);
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)removeProductReservationsFromCheckoutWithToken:(NSString *)checkoutToken completion:(BUYDataCheckoutBlock)block;

@end

NS_ASSUME_NONNULL_END
