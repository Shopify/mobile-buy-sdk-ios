//
//  BUYRouter.h
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

#import <Foundation/Foundation.h>

@interface BUYRoute : NSObject

@property (strong, nonatomic, readonly) NSURL *URL;
@property (strong, nonatomic, readonly) NSDictionary *queryItems;

- (void)setQueryItems:(NSDictionary *)queryItems;

@end

@interface BUYRouter : NSObject

- (instancetype)initWithShopDomain:(NSString *)shopDomain appID:(NSString *)appID;

- (BUYRoute *)routeForAPI;
- (BUYRoute *)routeForApps;

- (BUYRoute *)routeForShop;
- (BUYRoute *)routeForProductListings;
- (BUYRoute *)routeForCollectionListings;

- (BUYRoute *)routeForCheckouts;
- (BUYRoute *)routeForCheckoutsWithToken:(NSString *)token;
- (BUYRoute *)routeForCheckoutsProcessingWithToken:(NSString *)token;
- (BUYRoute *)routeForCheckoutsCompletionWithToken:(NSString *)token;
- (BUYRoute *)routeForCheckoutsShippingRatesWithToken:(NSString *)token;

- (BUYRoute *)routeForCheckoutsUsingGiftCard;
- (BUYRoute *)routeForCheckoutsUsingGiftCardWithToken:(NSString *)token;
- (BUYRoute *)routeForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token;

- (BUYRoute *)routeForCustomers;
- (BUYRoute *)routeForCustomersOrders;
- (BUYRoute *)routeForCustomersWithID:(NSString *)identifier;
- (BUYRoute *)routeForCustomersActivationWithID:(NSString *)identifier;
- (BUYRoute *)routeForCustomersToken;
- (BUYRoute *)routeForCustomersTokenRenewalWithID:(NSString *)customerID;
- (BUYRoute *)routeForCustomersPasswordRecovery;
- (BUYRoute *)routeForCustomersPasswordResetWithID:(NSString *)identifier;

@end
