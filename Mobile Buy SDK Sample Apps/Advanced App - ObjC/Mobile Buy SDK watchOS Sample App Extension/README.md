# Shopify's Mobile Buy SDK watchOS Sample App

### Motivation
The watchOS sample app is intended to show users how to integrate Shopify's Mobile Buy SDK into their watchOS applications.

The watchOS sample app demonstrates how to perform several tasks:
- Fetching shops
- Fetching products
- Fetching and displaying product images
- Using the currency formatter specified by the shop
- Creating interface controllers and using `WKInterfaceTable` to display products
- Using `WKInterfacePicker` to select a variant
- Using `BUYApplePayPaymentProvider` and `BUYPaymentController` to support Apple Pay
- Updating user activity for Handoff

### Getting Started 
Add your shop domain, API key, App ID and Merchant ID to `Credentials.h`

```objective-c
#define SHOP_DOMAIN @"<shop_domain>"
#define API_KEY     @"<api_key>"
#define APP_ID      @"<app_id>"
#define MERCHANT_ID @"<merchant_id>"
```

Change `shopify` from the bundle identifier of all three targets (`Mobile Buy SDK Advanced Sample`, `Mobile Buy SDK watchOS Sample App` and `Mobile Buy SDK watchOS Sample App Extension`) to something unique. Update `WKAppBundleIdentifier` and `WKCompanionAppBundleIdentifier` to reflect those changes.

Go to the `Capabilities` section under the `Mobile Buy SDK watchOS Sample App Extension` target and enable `Wallet` and `Apple Pay`. Under `Apple Pay` make sure you select your Merchant ID (created through the Apple Developer Portal)

### Classes

#### Controllers

###### `InterfaceController.swift`
* Initializes the `DataProvider`
* Configures each row controller within the `WKInterfaceTable`
* Handles the selection of a product in the `WKInterfaceTable` - pushes `ProductDetailsInterfaceController`

###### `ProductDetailsInterfaceController.swift`
* Shows the product image, a `WKInterfacePicker` to select the variant and a Apple Pay button for checkout
* Handles Apple Pay button click and forwards it to the `ApplePayHandler` class

###### `ProductRowController.swift`
* Contains a product image, price and title - used for the `WKInterfaceTable`


#### Data Provider

###### `DataProvider.swift`
* Handles all network requests within the app - fetching shop and products
* Has a local cache for everything it fetches


#### Models

###### `BaseModel.swift`
* Manages an `Operation` and makes sure that if it's receiving another `Operation` to cancel the previous one

###### `ProductsModel.swift`
* Subclasses `BaseViewModel`
* Interacts with `DataProvider` to download products
* Configures `ProductRowController` and `ProductDetailsInterfaceController`


#### Other

###### `ApplePayHandler.swift`
* Handles everything related to Apple Pay on the app
* Adds support for Apple Pay in the app using `BUYPaymentController` and `BUYApplePayPaymentProvider`
* Presents and dismisses `PKPaymentAuthorizationController`

###### `ProductItem.swift`
* Used to abstract model objects from controllers
* Configures `WKInterfacePicker` and `ProductDetailsInterfaceController`


All commits associated to the watchOS app have been approved in the following PRs:
- PR #441
- PR #452
- PR #457
- PR #458
- PR #463
- PR #465
- PR #467
- PR #470
- PR #471
- PR #474
- PR #476
- PR #477
