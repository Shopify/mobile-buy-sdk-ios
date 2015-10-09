# Mobile Buy SDK Release Notes prior to 1.2.0 (Open Source)

Here is a reverse-chronologically ordered list of patch notes for the Mobile Buy SDK for iOS prior to the SDK becoming open source at 1.2.0.

For release notes following the 1.2.0 (open source) release, please see [Github releases](https://github.com/Shopify/mobile-buy-sdk-ios/releases).

### Version 1.1.6
###### Released September 28, 2015

* Add "PAY [SHOP NAME]" to `PKPaymentAuthorizationViewController` when using `BUYApplePayHelpers`. This is also available through `buy_summaryItemsWithShopName:` in `BUYApplePayAdditions`. Apple's HIG specifies that the store's name is required in the summary items for the total amount.
* Set `DWARF` to suppress compiler warnings for all sample apps.

### Version 1.1.5
###### Released September 17, 2015

* [Advanced Sample App](https://docs.shopify.com/mobile-buy-sdk/ios/advanced-sample-app) which takes the developer through all the steps from downloading products to building a cart and completing a checkout.
* Fix for additional country code validation for Apple Pay, where addresses from the `PKPaymentAuthorizationViewControllerDelegate` sometimes don't return country codes correctly.

### Version 1.1.4
###### Released September 10, 2015

* Add support for the SafariViewController on iOS 9.
* Add support for Discover credit cards.
* Use new Contact API for Apple Pay on iOS 9.
* Option breadcrumbs for variant selection in `BUYProductViewController`.

### Version 1.1.3
###### Released September 2, 2015

* Use of HTTPs for all network calls.
* Improvements to shipping address validation including client-side pre-condition check for address when user selects an address in the `PKPaymentViewController`.
* BUYProduct objects with no images will no longer show the header placeholder in `BUYProductViewController`.
* `setVariant:withQuantity:` available on `BUYCart` to easily add or remove `BUYCartLineItem` objects for an associated `BUYProductVariant`.
* Updated documentation.
* `sourceUrl` has been removed from `BUYCheckout`.

### Version 1.1.2
###### Released August 20, 2015

`BUYProductViewController`:

* Products with one variant will now correctly show the variant but variant selection flow is disabled.
* Prices and "Sold Out" are now displayed for the last variant option in the variant selection flow.
* Variant selection controller size tied to device width and height for better UI on larger device screens.
* An error alert is shown if an error occurs creating a new checkout.
* Improved iPad presentation.
* Fixed an issue where dark theme wasn't properly applied to all views.
* Added `initWithClient:theme:` to more easily set the theme.
* Navigation bar title colour fix.

Other changes:

* `source` and `source_name` are now correctly set to `mobile_app` for checkouts, which propagates to orders in the shop admin. An *order.json* will include both and the orders CSV file will include the `source`.
* `sourceId` on `BUYCheckout` has been changed to `sourceIdentifer`. This is a `readonly` property, which automatically gets the channel ID for the Mobile App channel. This gets shows in *orders.json* as `source_identifier` on the shop admin.
* Clearer documentation for `reservationTime`.
* Fixed an issue with summary items for Apple Pay.
* Fix crash on `getCollections:` when a collection does not include an image.

### Version 1.1.1
###### Released August 12, 2015

* `BUYLineItem` now uses `lineItemIdentifier` as its identifier.
* Fix an issue where image would reset while scrolling.
* Added "Powered by Shopify" footer in `BUYProductViewController`.
* Hiding image page control on scrolling in `BUYProductViewController`.
* `webReturnToLabel` on `BUYCheckout` can now correctly be used for the web checkout return-to-app-name button.
* Unavailable variants now appear as "Sold Out" and the customer is unable to checkout via the web and Apple Pay using the `BUYProductViewController`.
* Improved support for portrait orientation for the `BUYProductViewController` when presented in landscape apps.

### Version 1.1
###### Released August 6, 2015

* Product View: Easily display and sell products from your shop using the new `BUYProductViewController`, which can be presented from any view controller in your app.
* Support for Product Collections.
* Support for custom properties on `BUYLineItem`.
* Added better support for responsive web checkout.
* Added `BUYApplePayHelpers` to help easily support Apple Pay if `BUYViewController` isn't used.
* `getCompletionStatusOfCheckout:completion:` no longer returns the `BUYCheckout` object that was passed in - use `getCheckout:completion:` to retrieve the updated `BUYCheckout` object.
* Added `isApplePayAvailable` flag on `BUYViewController` that returns YES if the customer can pay with Apple Pay.
* Applying or removing gift cards now applies/removes the gift card(s) on the BUYCheckout and updates the `paymentDue` amount on the `BUYCheckout` object.
* `BUYProduct` and `BUYProductVariant` objects now include an `inventory` flag.
* Add support for Storyboard usage for `BUYViewController`.
* Added `BUYCartLineItem` which contains the original `BUYProductVariant` objects added to the cart.
* `BUYLineItem` objects on a `BUYCheckout` object now reference variant IDs, not a BUYProductVariant.
* `sku` property has been added to `BUYProductVariant` objects.
* Added `paymentSessionId` on `BUYCheckout`.
* Better error messaging.

### Version 1.0.3
###### Released July 2, 2015

* Fixed an issue retrieving a cart when using Apple Pay and WKWebView checkout

### Version 1.0.2
###### Released June 25, 2015

* Changed SDK to a static framework (see updated [Getting Started guide](https://docs.shopify.com/mobile-buy-sdk/integration-guide))
* Fixed `BUYTaxLine` parsing
* Fixed channel attribution
* Removed `app.js`
* Updated docs

### Version 1.0.1
###### Released May 26, 2015

* Supports Apple Pay purchases without shipping requirement
* Fixes missing symbols for `getProductId:completion:`

### Version 1.0
###### Released May 19, 2015

* Initial public release
