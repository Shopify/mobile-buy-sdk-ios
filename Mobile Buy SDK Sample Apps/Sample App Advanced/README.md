# Mobile Buy SDK Advanced Sample App

The Advanced Sample App demonstrates how to perform several tasks related to creating a checkout.

- Fetch collections
- Fetch products
- Optionally present using the `BUYProductViewController`
- Create a checkout
- Apply shipping rate
- Apply gift cards and discounts
- Complete checkout via web view, native checkout implementation, and Apple Pay

### Getting started

First, add your shop domain, API key and Channel ID to the `CollectionListViewController.m` macros.

```objc
#define SHOP_DOMAIN @"<shop_domain>"
#define API_KEY @"<api_key>"
#define CHANNEL_ID @"<channel_id>"
```


### Overview

The Advanced Sample App demonstrates several tasks that can be performed using the Mobile Buy SDK.  Each task is broken up into seperate view controllers. Polling endpoints are represented as NSOperations which can easily be utilized in your own apps.

### Classes
#### View Controllers

###### `CollectionListViewController`
* Initializes the `BUYClient`
* Fetches collections and displays them in a list
* Optionally allows for fetch of the first product page

###### `ProductListViewController`
* Fetches the products and displays them in a list
* Can present a product using the `BUYProductViewController` and demo the theme settings on the controller, or
* Creates a checkout with the selected product and pushes to the `ShippingRatesTableViewController`

###### `ShippingRatesTableViewController`
* Fetches the shipping rates for the checkout using `GetShippingRatesOperation`
* Updates the checkout with the selected shipping rate and pushes to the `PreCheckoutViewController`

###### `PreCheckoutViewController`
* Displays a summary of the checkout
* Allows for discounts and gift cards to be added to the checkout

###### `CheckoutViewController`
* Displays a summary of the checkout
* Checkout using a credit card
* Web checkout using Safari
* Checkout using Apple Pay

#### `NSOperation`s

###### `GetShopOperation`
* `NSOperation` based class to fetch the shop object

###### `GetShippingRatesOperation`
* `NSOperation` based class to poll for shipping rates

###### `GetCompletionStatusOperation`
* `NSOperation` based class to poll for the checkout completion status

### Apple Pay

Apple Pay is implemented in the CheckoutViewController.  It utilizes the `BUYApplePayHelpers` class which acts as the delegate for the `PKPaymentAuthorizationViewController`.  Setting the `MerchantId` is required to use Apple Pay.  For more information about supporting Apple Pay in your app, please consult [https://docs.shopify.com/mobile-buy-sdk/ios/enable-apple-pay](https://docs.shopify.com/mobile-buy-sdk/ios/enable-apple-pay).
