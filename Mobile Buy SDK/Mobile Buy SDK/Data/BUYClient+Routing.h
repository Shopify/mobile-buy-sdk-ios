//
//  BUYClient+Routing.h
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

#import "BUYClient.h"

@interface BUYClient (Routing)

- (NSURL *)routeForAPI;
- (NSURL *)routeForApps;

- (NSURL *)routeForShop;
- (NSURL *)routeForProductListingsWithParameters:(NSDictionary *)parameters;
- (NSURL *)routeForCollectionListingsWithParameters:(NSDictionary *)parameters;

- (NSURL *)routeForCheckouts;
- (NSURL *)routeForCheckoutsWithToken:(NSString *)token;
- (NSURL *)routeForCheckoutsProcessingWithToken:(NSString *)token;
- (NSURL *)routeForCheckoutsCompletionWithToken:(NSString *)token;
- (NSURL *)routeForCheckoutsShippingRatesWithToken:(NSString *)token parameters:(NSDictionary *)parameters;

- (NSURL *)routeForCheckoutsUsingGiftCard;
- (NSURL *)routeForCheckoutsUsingGiftCardWithToken:(NSString *)token;
- (NSURL *)routeForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token;

- (NSURL *)routeForCustomers;
- (NSURL *)routeForCustomersOrders;
- (NSURL *)routeForCustomersWithID:(NSString *)identifier;
- (NSURL *)routeForCustomersActivationWithID:(NSString *)identifier parameters:(NSDictionary *)parameters;
- (NSURL *)routeForCustomersToken;
- (NSURL *)routeForCustomersTokenRenewalWithID:(NSString *)customerID;
- (NSURL *)routeForCustomersPasswordRecovery;
- (NSURL *)routeForCustomersPasswordResetWithID:(NSString *)identifier parameters:(NSDictionary *)parameters;

@end
