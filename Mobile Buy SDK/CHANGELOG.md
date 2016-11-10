# 2.1.0 ()
Features
* Allow collections to be retrieved by an array of IDs #292
* Add a unit test for customer creation #298
* Add new method to `BUYClient+Storefront` for support to get product tags by collection #310
* Convert all `#import` declarations to use user/quoted style #316
* Add API to `BUYClient` for getting products by a list of tags #347
* Allow a custom page size to be set based off the type of data being fetched #357
* Add `minimumPrice property` to `BUYProduct` #381

Bug Fixes
* Put arguments in the correct order when invoking the completion block #280
* Change `completeCheckout:` return value from `BUYOperation` to `NSOperation` #287
* Update snippet in `README` to use correct callback arguments #296
* Fix Apple Pay button logic in `PaymentViewController` #305
* Add required casting for Xcode 8 support #306
* Update test to remove delay and add explicit expectation #311
* Fix `testCustomerInvalidEmailPassword` test by adding updated credentials #320
* Add SDK as an embedded bundle #334
* Various changes to attempt to make tests faster, easier to configure, and more reliable #338
* Clears out the checkout object after the delegate is called #361
* Update checkout after authorizing Apple Pay payment #382
* Fix ternary operator assignment for Apple Pay Shipping Address Required Fields #399
* Fix broken links in `README` #400

Refactor
* Remove code from sample app that is not used #321
* Remove `BUYRuntime` since it's not being used anymore #380
* Update the default variant check to match Android and server side #383
* Add helper method to remove discount from checkout #396

Tasks
* Add new responses to `mocked_responses` which fix customer and tags tests #286
* Make the sort ordering comments clearer #330
* Fix links for sample apps #337
* Update Buildkite config and tests for Xcode 8 #348
* Update method signatures in `README` #363
* Update Customer Sample App to use Swift 3 #371
* Re-enables some disabled tests and correct order of cancel before execution test #373
* Updates the `README` with correct info on running the unit tests #391
* Add missing parameter documentation for collection callback block #404

Build Settings
* Use recommended setting from Xcode #312
