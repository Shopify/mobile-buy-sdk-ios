//
//  BUYApplePayPaymentProvider.h
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

@import UIKit;
#import <Buy/BUYPaymentProvider.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const BUYApplePayPaymentProviderId;

@class BUYClient;

@interface BUYApplePayPaymentProvider : NSObject <BUYPaymentProvider>

/**
 *  Initializer for Apple Pay payment provider
 *
 *  @param client     a `BUYClient`
 *  @param merchantID the merchant ID for Apple Pay
 *
 *  @return an instance of `BUYApplePayPaymentProvider`
 */
- (instancetype)initWithClient:(BUYClient *)client merchantID:(NSString *)merchantID NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

/**
 *  The supported credit card payment networks.  Default values:
 *  iOS 8.3: PKPaymentNetworkAmex, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa.
 *  iOS 9.0: PKPaymentNetworkAmex, PKPaymentNetworkDiscover, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa.
 */
@property (nonatomic, copy) NSArray * supportedNetworks;

/**
 *  The merchant ID required for Apple Pay
 */
@property (nonatomic, copy, readonly) NSString * merchantID;

/**
 *  If the merchantId is set and the device support Apple Pay but no credit card is present this allows the user to add a payment pass to the Wallet.
 *  The user is given the option to add a payment pass or continue with web checkout. Default is set to true. The Set Up Apple Pay button will, however
 *  still only show if [PKAddPaymentPassViewController canAddPaymentPass] returns true, merchantId is set and the app is running iOS 9.0 and above.
 */
@property (nonatomic, assign) BOOL allowApplePaySetup;

/**
 *  Whether the device is setup to show the Apple Pay setup sheet.
 *  `allowApplePaySetup` must be set to YES, and the `merchantId` must also be set in addition to the
 *  device settings for this method to return YES.
 *
 *  @return YES if the Setup Apple Pay button should be shown
 */
- (BOOL)canShowApplePaySetup;

@end

NS_ASSUME_NONNULL_END
