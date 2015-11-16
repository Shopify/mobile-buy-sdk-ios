# Mobile Buy SDK - Product View

The SDK includes an easy-to-use product view to make selling simple in any app.

![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_1.png)
![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_2.png)

Simply initialize the `BUYProductViewController` and present it from any view controller in your app to sell a product from you shop.

### Getting started

The `BUYProductViewController` needs a `BUYClient` setup with your shop's credentials to work, so first create a `BUYClient` object:

```objc
BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"yourshop.myshopify.com"
                                                   apiKey:@"aaaaaaaaaaaaaaaaaa"
                                                channelId:@"99999"];
```

Now, create a `BUYProductViewController` with the `BUYClient`, and optionally add Apple Pay and a custom theme.

```objc
// Optionally customize the UI:
BUYTheme *theme = [[BUYTheme alloc] init];
theme.style = BUYThemeStyleLight;
theme.tintColor = [UIColor redColor];

BUYProductViewController *productViewController = [[BUYProductViewController alloc] initWithClient:self.client theme:theme];

// Optionally enable Apple Pay:
productViewController.merchantId = @"MERCHANT_ID";
```

Now the `BUYProductViewController` is ready to load a product and be presented in your app:

```objc
[productViewController loadProduct:@"PRODUCT_ID" completion:^(BOOL success, NSError *error) {
    if (success) {
        [self presentViewController:self.productViewController animated:YES completion:nil];
    } else {
        NSLog(@"Error: %@", error.userInfo);
    }
}];
```

If you have already loaded a product, you can call `loadWithProduct:completion:` instead. 

For a complete demo, check out the [Advanced Sample App](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/Sample App Advanced/README.md), which demoes more UI customization with `BUYTheme` and both modal and navigation controller push presentations.
