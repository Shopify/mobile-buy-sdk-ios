[![Circle CI](https://circleci.com/gh/Shopify/mobile-buy-sdk-ios-private.svg?style=svg&circle-token=bc81f8016a1c01955fb98204e59f01c418e02c4c)](https://circleci.com/gh/Shopify/mobile-buy-sdk-ios-private)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Shopify/mobile-buy-sdk-ios-private/blob/master/LICENSE) [![GitHub release](https://img.shields.io/github/release/shopify/mobile-buy-sdk-private.svg)](https://github.com/Shopify/mobile-buy-sdk-ios-private/releases)

# Shopify's Mobile Buy SDK for iOS

Shopify’s Mobile Buy SDK makes it simple to sell physical products inside your mobile app. With a few lines of code, you can connect your app with the Shopify platform and let your users buy your products using Apple Pay or their credit card.

### Documentation

Please find all documentation on the [Mobile Buy SDK for iOS page](https://docs.shopify.com/mobile-buy-sdk).

### Building the SDK

Clone this repo or download as .zip and open `Mobile Buy SDK.xcworkspace`.

The workspace includes the Mobile Buy SDK project and the two sample app projects. The sample apps can also be opened outside the workspace with the `.xcodeproj` files found in the sample app folders. However, if you need to use breakpoints or inspect methods in the SDK, run the sample apps from the workspace.

### Mobile Buy SDK Targets and schemes

The Mobile Buy SDK includes a number of targets and schemes:

* **Buy**: This is the Mobile Buy SDK framework. This build is based on the current build configuration. To build a universal framework that can run on a device and on the Simulator and to be included in your app, please refer to the `Universal Framework` target below

* **Universal Framework**: This builds the framework using same `build.sh` script in the `Universal Framework` target and copies the built framework in the `/Mobile Buy SDK Sample Apps` folder. Build this target and scheme if you have made any changes to the framework that you want to test with the sample apps as the sample apps do not build the framework directly but embed the already built framework 

* **Mobile Buy SDK Tests**: Tests for the Mobile Buy SDK framework. See instructions below

* **Documentation**: This generates appledoc documentation for the framework

* **Playground**: This target is a basic app that depends directly on the `Buy` framework target and builds the framework every time using the `Playground` app's build configuration. You may use this app and target to play around with the SDK. Be sure not to check in any changes you may have made in files related to this app

### Integration Tests

To run the Mobile Buy SDK integration tests locally, you will need a Shopify shop that is publicly accessible (not password protected). Please note that the integration tests **will create an order** on that shop. This is to validate that the SDK works properly with Shopify.

To run the tests, edit the `Mobile Buy SDK Tests` scheme and add the following arguments to the **Environment Variables**:

* `shop_domain`: Your shop's domain, for example: `abetterlookingshop.myshopify.com`
* `api_key`: The API provided when setting up the Mobile App channel on Shopify Admin: *https://your_shop_id.myshopify.com/admin/mobile_app/integration*
* `channel_id`: The Channel ID provided with the API Key above
* `gift_card_code`, `gift_card_code_2`, `gift_card_code_2`: Three valid [Gift Card](https://docs.shopify.com/manual/your-store/gift-cards) codes for your shop
* `expired_gift_card_code`: An expired Gift Card code
* `expired_gift_card_id`: The `product_id` for the expired Gift Card
