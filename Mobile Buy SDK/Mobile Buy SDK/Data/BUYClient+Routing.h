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

#import <Buy/BUYClient.h>

@interface BUYClient (Routing)

- (NSURL *)urlForAPI;
- (NSURL *)urlForApps;

- (NSURL *)urlForShop;
- (NSURL *)urlForProductListingsWithParameters:(NSDictionary *)parameters;
- (NSURL *)urlForCollectionListingsWithParameters:(NSDictionary *)parameters;
- (NSURL *)urlForProductTagsWithParameters:(NSDictionary *)parameters;

- (NSURL *)urlForCheckouts;
- (NSURL *)urlForCheckoutsWithToken:(NSString *)token;
- (NSURL *)urlForCheckoutsProcessingWithToken:(NSString *)token;
- (NSURL *)urlForCheckoutsCompletionWithToken:(NSString *)token;
- (NSURL *)urlForCheckoutsShippingRatesWithToken:(NSString *)token parameters:(NSDictionary *)parameters;

- (NSURL *)urlForCheckoutsUsingGiftCard;
- (NSURL *)urlForCheckoutsUsingGiftCardWithToken:(NSString *)token;
- (NSURL *)urlForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token;

- (NSURL *)urlForCustomers;
- (NSURL *)urlForCustomersToken;
- (NSURL *)urlForCustomersPasswordRecovery;
- (NSURL *)urlForLoggedInCustomer;
- (NSURL *)urlForLoggedInCustomerToken;
- (NSURL *)urlForCustomersTokenRenewal;

- (NSURL *)urlForCustomersOrders;
- (NSURL *)urlForCustomersOrdersWithOrderID:(NSNumber *)orderID;

- (NSURL *)urlForCustomersWithID:(NSString *)identifier;
- (NSURL *)urlForCustomersActivationWithID:(NSString *)identifier parameters:(NSDictionary *)parameters;
- (NSURL *)urlForCustomersPasswordResetWithID:(NSString *)identifier parameters:(NSDictionary *)parameters;

- (NSURL *)urlForCustomersAddresses;
- (NSURL *)urlForCustomersAddressWithAddressID:(NSNumber *)addressID;

@end
