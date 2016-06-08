//
//  BUYClient+Internal.h
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
#import <Buy/BUYClient+Checkout.h>
#import <Buy/BUYSerializable.h>

static NSString * const BUYShopifyErrorDomain = @"BUYShopifyErrorDomain";
static NSString * const BUYClientCustomerAccessToken = @"X-Shopify-Customer-Access-Token";

typedef void (^BUYClientRequestJSONCompletion)(NSDictionary *json, NSHTTPURLResponse *response, NSError *error);

@interface BUYClient (Internal)

@property (nonatomic, strong) NSOperationQueue *requestQueue;

- (NSOperation *)pollCompletionStatusAndGetCheckoutWithToken:(NSString *)token start:(BOOL)start completion:(BUYCheckoutStatusOperationCompletion)block;

- (NSOperation *)getRequestForURL:(NSURL *)url    completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)deleteRequestForURL:(NSURL *)url completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (NSOperation *)postRequestForURL:(NSURL *)url  object:(id <BUYSerializable>)object completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)putRequestForURL:(NSURL *)url   object:(id<BUYSerializable>)object  completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)patchRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (NSOperation *)getRequestForURL:(NSURL *)url    start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)deleteRequestForURL:(NSURL *)url start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (NSOperation *)postRequestForURL:(NSURL *)url  object:(id <BUYSerializable>)object start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)putRequestForURL:(NSURL *)url   object:(id<BUYSerializable>)object  start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (NSOperation *)patchRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (BUYStatus)statusForStatusCode:(NSUInteger)statusCode error:(NSError *)error;

- (void)startOperation:(NSOperation *)operation;

@end

@class BUYCheckout;

@protocol BUYPaymentToken;

@interface BUYClient (PrivateCheckout)

- (NSOperation *)beginCheckoutWithToken:(NSString *)checkoutToken paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block;
- (NSOperation *)getCompletionStatusOfCheckoutWithToken:(NSString *)token start:(BOOL)start completion:(BUYDataStatusBlock)block;
- (NSOperation *)getCheckoutWithToken:(NSString *)checkoutToken start:(BOOL)start completion:(BUYDataCheckoutBlock)block;

@end
