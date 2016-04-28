//
//  BUYShopifyErrorCodes.h
//  Mobile Buy SDK
//
//  Created by Gabriel O'Flaherty-Chan on 2016-03-14.
//  Copyright © 2016 Shopify Inc. All rights reserved.
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
