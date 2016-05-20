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

#import "BUYClient.h"
#import "BUYClient+Checkout.h"
#import "BUYSerializable.h"

static NSString * const BUYShopifyErrorDomain = @"shopify";
static NSString * const BUYClientVersionString = @"1.3";
static NSString * const BUYClientCustomerAccessToken = @"X-Shopify-Customer-Access-Token";

typedef void (^BUYClientRequestJSONCompletion)(NSDictionary *json, NSURLResponse *response, NSError *error);

@interface BUYClient (Internal)

- (BUYRequestOperation *)getRequestForURL:(NSURL *)url    completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)deleteRequestForURL:(NSURL *)url completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (BUYRequestOperation *)postRequestForURL:(NSURL *)url  object:(id <BUYSerializable>)object completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)putRequestForURL:(NSURL *)url   object:(id<BUYSerializable>)object  completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)patchRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (BUYRequestOperation *)getRequestForURL:(NSURL *)url    start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)deleteRequestForURL:(NSURL *)url start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (BUYRequestOperation *)postRequestForURL:(NSURL *)url  object:(id <BUYSerializable>)object start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)putRequestForURL:(NSURL *)url   object:(id<BUYSerializable>)object  start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;
- (BUYRequestOperation *)patchRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object start:(BOOL)start completionHandler:(BUYClientRequestJSONCompletion)completionHandler;

- (BUYStatus)statusForStatusCode:(NSUInteger)statusCode error:(NSError *)error;
- (NSError *)errorFromJSON:(NSDictionary *)json response:(NSURLResponse *)response;

- (void)startOperation:(BUYOperation *)operation;

@end

@class BUYCheckout;

@protocol BUYPaymentToken;

@interface BUYClient (PrivateCheckout)

- (BUYRequestOperation *)beginCheckout:(BUYCheckout *)checkout paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block;
- (BUYRequestOperation *)getCompletionStatusOfCheckoutToken:(NSString *)token start:(BOOL)start completion:(BUYDataStatusBlock)block;
- (BUYRequestOperation *)getCheckout:(BUYCheckout *)checkout start:(BOOL)start completion:(BUYDataCheckoutBlock)block;

@end
