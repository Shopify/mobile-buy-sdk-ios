# Mobile Buy SDK Sample Native App

The native sample app shows an example of displaying a product from a shop and checking out using Apple Pay.

<img src="Sample_App_Native_Screenshot_1.png" width="50%" alt="Mobile Buy SDK sample native app 1"/><img src="Sample_App_Native_Screenshot_2.png" width="50%" alt="Mobile Buy SDK sample native app 1"/>

### Getting started

First, add your shop domain, API key and Channel ID to the `AppDelegate.m` macros.

	#define SHOP_DOMAIN @"<shop_domain>"
	#define API_KEY @"<api_key>"
	#define CHANNEL_ID @"<channel_id>"

Add a product ID for a product in your shop.

	#define PRODUCT_ID @"<product_id>"
	
This sample requires Apple Pay. Add your Merchant ID as well.

	#define MERCHANT_ID @"<merchant_id>"

### Overview

The sample app displays a single product from a shop retrieved on app launch as well as a `PKPaymentButton` (requires iOS 8.3 or later).

The `ProductController` is a subclass of `BUYViewController`. When the customer taps the **Buy with Apple Pay** button a `BUYCart` is created with the product and Apple Pay using `startCheckoutWithCart:`.

The `AppDelegate` implements the `BUYViewControllerDelegate` protocol and logs errors and progress to the console.
