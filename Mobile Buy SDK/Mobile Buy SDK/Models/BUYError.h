//
//  BUYError.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const BUYShopifyError;

typedef NS_ENUM(NSUInteger, BUYCheckoutError) {
	BUYShopifyError_CartFetchError,
	BUYShopifyError_NoShippingMethodsToAddress,
	BUYShopifyError_NoProductSpecified,
	BUYShopifyError_InvalidProductID,
	BUYShopifyError_NoCollectionIdSpecified,
	BUYShopifyError_NoGiftCardSpecified,
	BUYShopifyError_NoCreditCardSpecified,
	BUYShopifyError_NoApplePayTokenSpecified,
	BUYShopifyError_InvalidCheckoutObject,

};

@interface BUYError : NSError

@end
