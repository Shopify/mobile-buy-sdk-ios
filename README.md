![Mobile Buy SDK](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Mobile_Buy_SDK_Github_banner.png)

[![Build status](https://badge.buildkite.com/3951692121947fbf7bb06c4b741601fc091efea3fa119a4f88.svg)](https://buildkite.com/shopify/mobile-buy-sdk-ios)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/shopify/mobile-buy-sdk-ios.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/Mobile-Buy-SDK.svg)](https://cocoapods.org/pods/Mobile-Buy-SDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Mobile Buy SDK for iOS

Shopify’s Mobile Buy SDK makes it simple to sell physical products inside your mobile app. With a few lines of code, you can connect your app with the Shopify platform and let your users buy your products using Apple Pay or their credit card.

- [Documentation](#documentation)
  - [API Documentation](#api-documentation)
- [Installation](#installation)
  - [Dynamic Framework Installation](#dynamic-framework-installation)
  - [Static Framework Installation](#static-framework-installation)
  - [CocoaPods](#cocoapods)
  - [Carthage](#carthage)
- [Quick Start](#quick-start)
- [Building the SDK](#building-the-sdk)
- [Mobile Buy SDK Targets and schemes](#mobile-buy-sdk-targets-and-schemes)
- [Sample Apps](#sample-apps)
- [Product View](#product-view)
- [Unit Tests](#unit-tests)
- [Contributions](#contributions)
- [Help](#help)
- [License](#license)

### Documentation

Official documentation can be found on the [Mobile Buy SDK for iOS page](https://docs.shopify.com/mobile-buy-sdk/ios).

#### API Documentation

API docs (`.docset`) can be generated with the `Documentation` scheme or viewed online at Cocoadocs: [http://cocoadocs.org/docsets/Mobile-Buy-SDK/](http://cocoadocs.org/docsets/Mobile-Buy-SDK/).

The SDK includes a pre-compiled [.docset](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK/docs/com.shopify.Mobile-Buy-SDK.docset) that can be used in API documentation browser apps such as Dash.

### Installation

<a href="https://github.com/Shopify/mobile-buy-sdk-ios/releases/latest">Download the latest version</a>

#### Dynamic Framework Installation

1. Drag the `Mobile Buy SDK.xcodeproj` into your existing project
2. Add the `Buy` target as a `Target Dependancy` in the `Build Phases` of your project's target
3. Add the `Buy` (second target on the list is the Dynamic framework) target in the `Embedded Binaries` section in `Build Phases`

See the [Sample Apps](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/) for an example of Dynamic Framework usage.

#### Static Framework Installation

If you would like to not include the Mobile Buy SDK Project within your existing project, you can link directly to the `Buy.framework`.

1.  Open the `Mobile Buy SDK.xcodeproj` and build the `Static Universal Framework` scheme
2.  Drag the `Buy.framework` that was just created from `Mobile Buy SDK Sample Apps` into the `Linked Frameworks and Libraries` section for the target you want to add the framework to. Check Copy items if needed so the framework is copied to your project
3.  In the `Build Settings` tab, add `-all_load` to `Other Linker Flags`

#### CocoaPods

Add the following line to your podfile:

```ruby
pod "Mobile-Buy-SDK"
```

Then run `pod install`

```objc
#import "Buy.h"
```

#### Carthage

Add the following line to your Cartfile

```ruby
github "Shopify/mobile-buy-sdk-ios"
```

Then run `carthage update`

### Quick Start

Import the module

```objc
@import Buy;
```

Initialize the `BUYClient` with your credentials from the *Mobile App Channel*


```objc
BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"yourshop.myshopify.com"
                                                   apiKey:@"aaaaaaaaaaaaaaaaaa"
                                                    appId:@"99999"];
```

### Storefront API
After initializing the client with valid shop credentials, you can begin fetching collections.
```objc
[client getCollectionsPage:1 completion:^(NSArray<BUYCollection *> *collections, NSError *error) {
	if (collections && !error) {
		// Do something with collections
	} else {
		NSLog(@"Error fetching collections: %@", error.userInfo);
	}
}];
```
Having a collection, we can then retrieve an array of products within that collection:
```objc
BUYCollection *collection = collections.firstObject;

[client getProductsPage:1 inCollection:collection.collectionId completion:^(NSArray<BUYProduct *> *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
	if (products && !error) {
		// Do something with products
	} else {
		NSLog(@"Error fetching products in collection %@: %@", collection.collectionId, error.userInfo);
	}
}];
```

### Customer API
##### Customer Login
You can allow customers to login with their existing account using the SDK. First, we'll need to create the `BUYAccountCredentials` object used to pass authentication credentials to the server.
```objc
NSArray *credentialItems = @[
						     [BUYAccountCredentialItem itemWithEmail:@"john.smith@gmail.com"],
							 [BUYAccountCredentialItem itemWithPassword:@"password"],
							];
BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:credentialItems];
```
We can now use the credentials object to login the customer.
```objc
[client loginCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
	if (customer && token && !error) {
		// Do something with customer and store token for future requests
	} else {
		NSLog(@"Failed to login customer: %@", error.userInfo);
	}
}];
```
##### Customer Creation
Creating a customer account is very similar to login flow but requres a little more info in the credentials object.
```objc
NSArray *credentialItems = @[
							 [BUYAccountCredentialItem itemWithFirstName:@"John"],
							 [BUYAccountCredentialItem itemWithLastName:@"Smith"],
							 [BUYAccountCredentialItem itemWithEmail:@"john.smith@gmail.com"],
							 [BUYAccountCredentialItem itemWithPassword:@"password"]
							];
BUYAccountCredentials *credentials = [BUYAccountCredentials credentialsWithItems:credentialItems];
```
After we obtain the customers first name, last name and password in addition to the email and password fields, we can create an account.
```objc
[client createCustomerWithCredentials:credentials callback:^(BUYCustomer *customer, NSString *token, NSError *error) {
	if (customer && token && !error) {
		// Do something with customer and store token for future requests
	} else {
		NSLog(@"Failed to create customer: %@", error.userInfo);
	}
}];
```

### Integration Guide
Consult the [Usage Section](https://docs.shopify.com/mobile-buy-sdk/ios/integration-guide/#using-the-mobile-buy-sdk) of the Integration Guide on how to create a cart, checkout and more with the SDK.

### Building the SDK

Clone this repo or download as .zip and open `Mobile Buy SDK.xcodeproj`.

The workspace includes the Mobile Buy SDK project.

### Mobile Buy SDK Targets and schemes

The Mobile Buy SDK includes a number of targets and schemes:

* **Buy**: This is the Mobile Buy SDK dynamic framework. Please refer to the installation section above

* **Static Universal Framework**: This builds a **static** framework from the `Buy` target using the `build_universal.sh` script in the `Static Universal Framework` target and copies the built framework in the `/Mobile Buy SDK Sample Apps` folder. This is a fat binary that includes arm and i386 slices. Build this target if you have made any changes to the framework that you want to test with the sample apps as the sample apps do not build the framework directly but embed the already built framework

* **Mobile Buy SDK Tests**: Tests for the Mobile Buy SDK framework. See instructions below

* **Documentation**: This generates appledoc documentation for the framework

### Sample Apps

The repo includes 2 sample apps. Each sample apps embeds the dynamic framework and includes readme files with more information:

* [Advanced Sample App - Objective C](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Advanced%20App%20-%20ObjC)
* [Customers Sample App - Swift](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Customers%20App%20-%20Swift)


We suggest you take a look at the **Advanced Sample App** and test your shop with the sample app before you begin. If you run into any issues, the **Advanced Sample App** is also a great resource for debugging integration issues and checkout.

### Product View

The Advanced Sample App includes an easy-to-use product view to make selling simple in any app. The `ProductViewController` displays any product, it's images, price and details and includes a variant selection flow. It will even handle Apple Pay and web checkout automatically:

![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_1.png)

You can also theme the `ProductViewController` to better match your app and products being displayed:

![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_2.png)

The [Advanced Sample App](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/Sample App Advanced/) includes a demo of the `ProductViewController`. Documentation on how to use the `ProductViewController` is also available [here](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/Sample App Advanced/PRODUCT_VIEW_README.md).

### Unit Tests

To run the Mobile Buy SDK integration tests against an actual shop, you will need a Shopify shop that is publicly accessible (not password protected). Please note that the integration tests **will create an order** on that shop. This is to validate that the SDK works properly with Shopify.  Modify the **test_shop_data.json** file to contain your shop's credentials and the required product IDs, gift cards, and discounts as necessary.

If the credentials in the **test_shop_data.json** are empty, running the integration tests will use mocked respoonses.  The mocked responses are defined in **mocked_responses.json**.  Do not check in credentials in this file.

Alternatively, you can edit the `Mobile Buy SDK Tests` scheme and add the following arguments to the **Environment Variables**:

* `shop_domain`: Your shop's domain, for example: `abetterlookingshop.myshopify.com`
* `api_key`: The API provided when setting up the Mobile App channel on Shopify Admin: *https://your_shop_id.myshopify.com/admin/mobile_app/integration*
* `app_id`: The App ID provided with the API Key above
* `gift_card_code_11`, `gift_card_code_25`, `gift_card_code_50`: Three valid [Gift Card](https://docs.shopify.com/manual/your-store/gift-cards) codes for your shop
* `expired_gift_card_code`: An expired Gift Card code
* `expired_gift_card_id`: The ID for the expired Gift Card
* `product_ids_comma_separated`: a comma seperated list of product IDs (2 is suitable) to use for the cart

### Contributions

We welcome contributions. Follow the steps in [CONTRIBUTING](CONTRIBUTING.md) file.

### Help

For help, please post questions on our forum, in the Shopify APIs & Technology section: https://ecommerce.shopify.com/c/shopify-apis-and-technology

### License

The Mobile Buy SDK is provided under an MIT Licence.  See the [LICENSE](LICENSE) file
