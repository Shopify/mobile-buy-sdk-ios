//
//  BUYErrors.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#ifndef Mobile_Buy_SDK_BUYErrors_h
#define Mobile_Buy_SDK_BUYErrors_h

extern NSString * const BUYShopifyError;

typedef NS_ENUM(NSUInteger, BUYCheckoutError) {
	BUYShopifyError_CartFetchError,
	BUYShopifyError_NoShippingMethodsToAddress,
	BUYShopifyError_NoProductSpecified
};

#endif
