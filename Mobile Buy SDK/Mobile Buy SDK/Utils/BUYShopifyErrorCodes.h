//
//  BUYShopifyErrorCodes.h
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

#ifndef BUYShopifyErrorCodes_h
#define BUYShopifyErrorCodes_h

static NSString * const BUYShopifyError = @"BUYShopifyError";

/**
 *  A collection of enums for error codes specific to the SDK
 */
typedef NS_ENUM(NSUInteger, BUYCheckoutError){
	/**
	 *  An error occurred retrieving the cart for an existing web checkout with StoreViewController
	 */
	BUYShopifyError_CartFetchError,
	/**
	 *  No shipping rates are available for the selected address
	 */
	BUYShopifyError_NoShippingMethodsToAddress,
	/**
	 *  No product or product ID was provided when loading a product in BUYProductViewController
	 */
	BUYShopifyError_NoProductSpecified,
	/**
	 *  The product ID or IDs provided were invalid for the shop. Check that the product are made visible on the Mobile App channel on /admin.
	 */
	BUYShopifyError_InvalidProductID,
	/**
	 *  No collection ID was provided when loading a collection
	 */
	BUYShopifyError_NoCollectionIdSpecified,
	/**
	 *  No gift card code was provided when applying a gift card to a checkout
	 */
	BUYShopifyError_NoGiftCardSpecified,
	/**
	 *  No credit card was provided when calling `storeCreditCard:completion:`
	 */
	BUYShopifyError_NoCreditCardSpecified,
	/**
	 *  No Apple Pay token was provided when attempting to complete a checkout using Apple Pay
	 */
	BUYShopifyError_NoApplePayTokenSpecified,
	/**
	 *  The checkout is invalid and does not have a checkout token. This generally means the BUYCheckout object
	 *  has not been synced with Shopify via `createCheckout:completion:` before making subsequent calls to update
	 *  or complete the checkout
	 */
	BUYShopifyError_InvalidCheckoutObject,
	
	/**
	 *  A customer token has not been configured on the client
	 */
	BUYShopifyError_InvalidCustomerToken
};


#endif /* BUYShopifyErrorCodes_h */
