![Mobile Buy SDK](http://s3.amazonaws.com/shopify-marketing_assets/static/mbsdk-github.png)

[![Build status](https://badge.buildkite.com/3951692121947fbf7bb06c4b741601fc091efea3fa119a4f88.svg)](https://buildkite.com/shopify/mobile-buy-sdk-ios)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/shopify/mobile-buy-sdk-ios.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/releases)
[![Cocoapods](https://img.shields.io/cocoapods/v/Mobile-Buy-SDK.svg)](https://cocoapods.org/pods/Mobile-Buy-SDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Mobile Buy SDK for iOS

Shopify’s Mobile Buy SDK makes it simple to sell physical products inside your mobile app. With a few lines of code, you can connect your app with the Shopify platform and let your users buy your products using Apple Pay or their credit card.

### Documentation

Please find all documentation on the [Mobile Buy SDK for iOS page](https://docs.shopify.com/mobile-buy-sdk/ios).

### Installation

<a href="../../releases/latest">Download the latest version</a>

#### Dynamic Framework Installation

1. Drag the `Mobile Buy SDK.xcodeproj` into your existing project
2. Add the `Buy` target as a `Target Dependancy` in the `Build Phases` of your project's target
3. Add the `Buy` (second target on the list is the Dynamic framework) target in the `Embedded Binaries` section in `Build Phases`

See the [Sample Apps](/Mobile Buy SDK Sample Apps/) for an example of Dynamic Framework usage.

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
                                                channelId:@"99999"];

// Fetch your products
[self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        if (error) {
                NSLog(@"Error retrieving products: %@", error.userInfo);
        } else {
                for (BUYProduct *product in products) {
                        NSLog(@"%@", product.title);
                }
        }
}];
```

Consult the [Usage Section](https://docs.shopify.com/mobile-buy-sdk/ios/integration-guide/#using-the-mobile-buy-sdk) of the Integration Guide on how to create a cart, and checkout with the SDK.

### Building the SDK

Clone this repo or download as .zip and open `Mobile Buy SDK.xcodeproj`.

The workspace includes the Mobile Buy SDK project.

### Mobile Buy SDK Targets and schemes

The Mobile Buy SDK includes a number of targets and schemes:

* **Buy**: This is the Mobile Buy SDK dynamic framework. Please refer to the installation section above

* **Buy Static** (target only): This is the Mobile Buy SDK static framework. This build is based on the current build configuration. To build a universal framework that can run on a device and on the Simulator and to be included in your app, please refer to the `Static Universal Framework` target below

* **Static Universal Framework**: This builds a **static** framework from the `Buy Static` target using the `build_universal.sh` script in the `Static Universal Framework` target and copies the built framework in the `/Mobile Buy SDK Sample Apps` folder. This is a fat binary that includes arm and i386 slices. Build this target if you have made any changes to the framework that you want to test with the sample apps as the sample apps do not build the framework directly but embed the already built framework

* **Mobile Buy SDK Tests**: Tests for the Mobile Buy SDK framework. See instructions below

* **Documentation**: This generates appledoc documentation for the framework

### Sample Apps

The repo includes 3 sample apps. Each sample apps embeds the dynamic framework and includes readme files with more information:

* [Advanced Sample App](/Mobile Buy SDK Sample Apps/Sample App Advanced/README.md)
* [Swift Sample App](/Mobile Buy SDK Sample Apps/Sample App Swift/README.md)
* [Web Sample App](/Mobile Buy SDK Sample Apps/Sample App Web/README.md)

We suggest you take a look at the **Advanced Sample App** and test your shop with the sample app before you begin. If you run into any issues, the **Advanced Sample App** is also a great resource for debugging integration issues and checkout.

### Unit Tests

To run the Mobile Buy SDK integration tests against an actual shop, you will need a Shopify shop that is publicly accessible (not password protected). Please note that the integration tests **will create an order** on that shop. This is to validate that the SDK works properly with Shopify.  Modify the **test_shop_data.json** file to contain your shop's credentials and the required product IDs, gift cards, and discounts as necessary.

If the credentials in the **test_shop_data.json** are empty, running the integration tests will use using mocked respoonses.  The mocked responses are defined in **mocked_responses.json**.  Do not check in credentials in this file.

Alternatively, you can edit the `Mobile Buy SDK Tests` scheme and add the following arguments to the **Environment Variables**:

* `shop_domain`: Your shop's domain, for example: `abetterlookingshop.myshopify.com`
* `api_key`: The API provided when setting up the Mobile App channel on Shopify Admin: *https://your_shop_id.myshopify.com/admin/mobile_app/integration*
* `channel_id`: The Channel ID provided with the API Key above
* `gift_card_code_11`, `gift_card_code_25`, `gift_card_code_50`: Three valid [Gift Card](https://docs.shopify.com/manual/your-store/gift-cards) codes for your shop
* `expired_gift_card_code`: An expired Gift Card code
* `expired_gift_card_id`: The ID for the expired Gift Card
* `product_ids_comma_separated`: a comma seperated list of product IDs (2 is suitable) to use for the cart

### How Can I Contribute?

We welcome contributions.  Follow the steps in [CONTRIBUTING](CONTRIBUTING.md) file

### License

The Mobile Buy SDK is provided under an MIT Licence.  See the [LICENSE](LICENSE) file
