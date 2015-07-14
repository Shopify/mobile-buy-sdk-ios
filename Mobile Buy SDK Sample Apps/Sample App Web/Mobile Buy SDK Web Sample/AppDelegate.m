//
//  AppDelegate.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@import Buy;

#warning - Enter your shop domain and API Key
#define SHOP_DOMAIN @""
#define API_KEY @""
#define CHANNEL_ID @""

#warning Optionally, to support Apple Pay, enter your merchant ID
#define MERCHANT_ID @""

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialize the Buy SDK
    BUYClient *client = [[BUYClient alloc] initWithShopDomain:SHOP_DOMAIN
                                                       apiKey:API_KEY
                                                    channelId:CHANNEL_ID];
    
    
    [client enableApplePayWithMerchantId:MERCHANT_ID];
    
    // Setup the views
    ViewController *storeController = [[ViewController alloc] initWithClient:client];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:storeController];
    navController.toolbarHidden = NO;
    navController.navigationBarHidden = NO;
    navController.navigationBar.barStyle = UIStatusBarStyleLightContent;

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
