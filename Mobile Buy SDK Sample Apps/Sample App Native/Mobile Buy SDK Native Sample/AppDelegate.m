//
//  AppDelegate.m
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

#import "AppDelegate.h"
#import "ProductController.h"

@import Buy;

#warning - Enter your shop domain and API Key
#define SHOP_DOMAIN @""
#define API_KEY @""
#define CHANNEL_ID @""

#define PRODUCT_ID @""

#warning Optionally, to support Apple Pay, enter your merchant ID
#define MERCHANT_ID @""

@interface AppDelegate () <BUYViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BUYClient *client = [[BUYClient alloc] initWithShopDomain:SHOP_DOMAIN apiKey:API_KEY channelId:CHANNEL_ID];
    client.urlScheme = @"nativeapp://";
    
    ProductController *productController = [[ProductController alloc] initWithClient:client productId:PRODUCT_ID];
    productController.merchantId = MERCHANT_ID;
    productController.delegate = self;
    self.window.rootViewController = productController;
    
    return YES;
}

#pragma mark - BUYControllerDelegate Methods

- (void)controller:(BUYViewController *)controller failedToCreateCheckout:(NSError *)error
{
    NSLog(@"Failed to create checkout: %@", error);
}

- (void)controllerFailedToStartApplePayProcess:(BUYViewController *)controller
{
    NSLog(@"Failed to start the Apple Pay process. We weren't given an error :(");
}

- (void)controller:(BUYViewController *)controller failedToUpdateCheckout:(BUYCheckout *)checkout withError:(NSError *)error
{
    NSLog(@"Failed to update checkout: %@, error: %@", checkout.token, error);
}

- (void)controller:(BUYViewController *)controller failedToGetShippingRates:(BUYCheckout *)checkout withError:(NSError *)error
{
    NSLog(@"Failed to get shipping rates: %@, error: %@", checkout.token, error);
}

- (void)controller:(BUYViewController *)controller failedToCompleteCheckout:(BUYCheckout *)checkout withError:(NSError *)error
{
    NSLog(@"Failed to complete checkout: %@, error: %@", checkout.token, error);
}

- (void)controller:(BUYViewController *)controller didCompleteCheckout:(BUYCheckout *)checkout status:(BUYStatus)status
{
    NSLog(@"Did complete checkout: %@, status: %ld", checkout.token, (unsigned long)status);
}

- (void)controller:(BUYViewController *)controller didDismissApplePayControllerWithStatus:(PKPaymentAuthorizationStatus)status forCheckout:(BUYCheckout *)checkout
{
    NSLog(@"Did dismiss Apple Pay controller with status: %ld, checkout: %@", (unsigned long)status, checkout.token);
}

@end
