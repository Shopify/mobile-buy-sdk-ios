//
//  BUYDataClient.h
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
#import <Buy/BUYClientTypes.h>

@class BUYCustomerToken;
@class BUYModelManager;
@class BUYOperation;
@class BUYRequestOperation;

/**
 The BUYDataClient provides all requests needed to perform request on the Shopify Checkout API.
 Use this class to perform tasks such as getting a shop, products for a shop, creating a Checkout on Shopify
 and completing Checkouts.
 */
@interface BUYClient : NSObject
NS_ASSUME_NONNULL_BEGIN

- (instancetype)init NS_UNAVAILABLE;

/**
 *  Initialize a BUYDataClient using a shop's domain, API key and the Channel ID.
 *
 *  @param shopDomain The Shop Domain i.e. abetterlookingshop.myshopify.com
 *  @param apiKey     The API key provided via the Mobile SDK Channel on Shopify Admin
 *  @param appId      The App ID provided on Shopify Admin
 *
 *  @return An instance of BUYDataClient
 */
- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey appId:(NSString *)appId NS_DESIGNATED_INITIALIZER;

/**
 *
 */
@property (nonatomic, strong, nonnull) BUYModelManager *modelManager;

/**
 *  Queue on which network completion callbacks will be executed
 */
@property (nonatomic, strong, nonnull) NSOperationQueue *callbackQueue;

/**
 *  The page size for any paged request. This can range from 1-250.  Default is 25
 */
@property (nonatomic, assign) NSUInteger pageSize;

/**
 *  The shop domain set using the initializer
 */
@property (nonatomic, strong, readonly, nonnull) NSString *shopDomain;

/**
 *  The API Key set using the initializer
 */
@property (nonatomic, strong, readonly, nonnull) NSString *apiKey;

/**
 *  The Channel ID set using the initializer
 */
@property (nonatomic, strong, readonly, nonnull) NSString *appId;

/**
 *  Application name to attribute orders to.  Uses the app bundle name from info.plist (CFBundleName)
 */
@property (nonatomic, strong, nonnull) NSString *applicationName;

/**
 * The applications URLScheme, used to return to the application after a complete web checkout. Ex. @"storeApp://"
 */
@property (nonatomic, strong, nullable) NSString *urlScheme;

/**
 *  Allows the client to hold onto the customer token
 *
 *  @param token The token received from the create and login callbacks
 */
@property (strong, nonatomic, nullable) BUYCustomerToken *customerToken;

@end

NS_ASSUME_NONNULL_END
