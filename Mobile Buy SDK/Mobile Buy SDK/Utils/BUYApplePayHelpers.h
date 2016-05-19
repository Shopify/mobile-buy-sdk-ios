//
//  BUYApplePayHelpers.h
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
@import PassKit;

#import <Buy/BUYModelManager.h>

@class BUYAddress;
@class BUYClient;
@class BUYCheckout;
@class BUYShop;

NS_ASSUME_NONNULL_BEGIN

@interface BUYApplePayHelpers : NSObject <PKPaymentAuthorizationViewControllerDelegate>

/**
 *  Initializes a helper to support Apple Pay
 *
 *  @param client   A configured client
 *  @param checkout The checkout which is to be completed using Apple Pay
 *  @param shop     A shop object to alleviate the need for ApplePayHelper to retrieve it via the BUYClient
 *
 *  @return helper object
 */
- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout shop:(BUYShop *)shop NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 *  The current checkout
 */
@property (nonatomic, strong, readonly) BUYCheckout *checkout;

/**
 *  The client used to communicate with Shopify
 */
@property (nonatomic, strong, readonly) BUYClient *client;

/**
 *  The last error message
 */
@property (nonatomic, strong, readonly) NSError *lastError;

/** 
 *  The shop object
 */
@property (nonatomic, strong, readonly) BUYShop *shop;

@end

@interface BUYModelManager (ApplePay)

/**
 *  Creates a BUYAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a BUYAddress from
 *
 *  @return The BUYAddress created from an ABRecordRef
 */
- (BUYAddress *)buyAddressWithABRecord:(ABRecordRef)addressRecord NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `buyAddressWithContact:` instead");

/**
 *  Creates a BUYAddress from a PKContact
 *
 *  @param contact PKContact to create a BUYAddress from
 *
 *  @return The BUYAddress created from a PKContact
 */
- (BUYAddress *)buyAddressWithContact:(PKContact *)contact NS_AVAILABLE_IOS(9_0);

@end

NS_ASSUME_NONNULL_END
