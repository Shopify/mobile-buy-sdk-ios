# Mobile Buy SDK Sample Web App

The web sample app demonstrates how you can load your shop's website in a webview, and support Apple Pay.

### Getting started

First, add your shop domain, API key and Channel ID to the `AppDelegate.h` macros.

```objc
#define SHOP_DOMAIN @"<shop_domain>"
#define API_KEY @"<api_key>"
#define CHANNEL_ID @"<channel_id>"
```
	
To support Apple Pay, add your Merchant ID as well.

```objc
#define MERCHANT_ID @"<merchant_id>"
```

### Overview

The sample app instantiates a view controller which is a subclass of `BUYStoreViewController`.  This displays a webview with your shop, but intercepts the checkout to support Apple Pay.

The sample app also demonstrates how to use the `BUYClient` to obtain shop details by calling `getShop:`

```objc
[self.provider getShop:^(BUYShop *shop, NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (error == nil && shop) {
            self.title = shop.name;
        }
        else {
            NSLog(@"Error fetching shop: %@", error.localizedDescription);
        }
    });
}];
```
