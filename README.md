![Mobile Buy SDK](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Mobile_Buy_SDK_Github_banner.png)

[![Build status](https://badge.buildkite.com/3951692121947fbf7bb06c4b741601fc091efea3fa119a4f88.svg)](https://buildkite.com/shopify/mobile-buy-sdk-ios/builds?branch=sdk-3.0%2Fmaster)
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

1. Drag the `Buy.xcodeproj` into your existing project
2. Add `Buy.framework` target as a depenency - `Your Project > (Select your target) > Build Phases > Target Dependencies > + > Buy.framework`
3. Link `Buy.framework` - `Your Project > (Select your target) > Build Phases > Link Binary With Libraries > + > Buy.framework`
4. Ensure the framework is copied into the bundle - `Your Project > (Select your target) > Build Phases > + > New Copy Files Phase > Destination (Select 'Frameworks') > + > Buy.framework`
5. Import at use site `import Buy`

See the [Sample Apps](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/) for an example of Dynamic Framework usage.

#### CocoaPods

Add the following line to your podfile:

```ruby
pod "Mobile-Buy-SDK"
```

Then run `pod install`

Import the SDK module:
```swift
import Buy
```

#### Carthage

Add the following line to your Cartfile

```ruby
github "Shopify/mobile-buy-sdk-ios"
```

Then run `carthage update`

Import the SDK module:
```swift
import Buy
```

### Getting started

The Buy SDK is built on top of GraphQL. While some knowledge of GraphQL is good to have, you don't have to be an expert to start using with the Buy SDK. Instead of writing stringly-typed queries, the SDK provides generated classes and a builder pattern to help you write compile-time checked and auto-complete friendly queries and work with typed response models.

This is what a sample query looks like to fetch a shop's name:

```swift
let query = ApiSchema.buildQuery { $0
    .shop { $0
        .name()
    }
}
```

### Types and models

The Buy SDK provides classes for models that represent resources in the GraphQL schema 1-to-1. These classes are all scoped under the `Storefront` namespace. To access these classes you'll need to provide the entire name:

```swift
let collections: [Storefront.Collection] = []
collection.forEach {
    $0.doSomething()
}
```

Initialize the `GraphClient` with your credentials from the *Mobile App Channel*

```swift
let client = GraphClient(shopDomain: "yourshop.myshopify.com", apiKey: "your-api-key")
```

### Queries & Mutations

The Buy SDK is built on GraphQL, which means that you'll inherit all the powerful capabilities GraphQL has to offer. As a result, there's a paradigm shift. With Buy SDK, you'll need to "query" the API and describe in the shape of an object graph what kind of fields and entities the server should return. Let's take a look at how to build a simple query.

GraphQL queries are written in plain text but the SDK offers a builder that abstracts the knowledge of the GraphQL schema and provides auto-completion. There are two types of queries:

##### Query
Using the `buildQuery()` method, we can build a query to retrieve entities and fields. Semantically, these are requivalent to `GET` requests in RESTful APIs. No reasource are modified as a result of a `query`.
```swift
let query = Storefront.buildQuery { $0
    .shop {
        .name()
        .currencyCode()
        .moneyFormat()
    }
}
```
this will produce the following GraphQL query:
```graphql
query {
	shop {
    	name
        currencyCode
        moneyFormat
    }
}
```

##### Mutation
Using the `buildMutation()` method, we can a build a query to modify resources on the server. Semantically, these are equivalent to `POST`, `PUT` and `DELETE` requests in RESTful APIs.
```swift
let mutation = Storefront.buildMutation { $0
    .customerCreate(input: customerInput) { $0
        .customer { $0
            .displayName()
            .firstName()
            .lastName()
        }
    }
}
```

Mutations are slightly different. Unlike simple queries, mutations can require an input object to represent the resource to be created or updated. The above `customerInput` parameter is created by simply initializing a `Storefront.CustomerInput` object like this:
```swift
let customerInput = Storefront.CustomerInput(
    firstName: "John",
    lastName:  "Smith",
    email:     "john.smith@gmail.com",
    password:  "johnny123",
    acceptsMarketing: true
)
```
The above will yield the following GraphQL query:
```graphql
mutation {
	customerCreate(input: {
    	firstName: "John"
        lastName:  "Smith"
        email:     "john.smith@gmail.com"
        password:  "johnny123"
        acceptsMarketing: true
    }) {
    	customer {
    		displayName
        	firstName
        	lastName
        }
    }
}
```

### Storefront API
After initializing the client with valid shop credentials, you can begin fetching collections.
```objc
[client getCollectionsPage:1 completion:^(NSArray<BUYCollection *> * _Nullable collections, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error) {
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

[client getProductsPage:1 inCollection:collection.identifier completion:^(NSArray<BUYProduct *> * _Nullable products, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error) {
	if (products && !error) {
		// Do something with products
	} else {
		NSLog(@"Error fetching products in collection %@: %@", collection.identifier, error.userInfo);
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
[client loginCustomerWithCredentials:credentials callback:^(BUYCustomer * _Nullable customer, BUYCustomerToken * _Nullable token, NSError * _Nullable error) {
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
[client createCustomerWithCredentials:credentials callback:^(BUYCustomer * _Nullable customer, BUYCustomerToken * _Nullable token, NSError * _Nullable error) {
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

The repo includes 4 sample apps. Each sample apps embeds the dynamic framework and includes readme files with more information:

* [Advanced Sample App - Objective C](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Advanced%20App%20-%20ObjC)
* [Customers Sample App - Swift](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Customers%20App%20-%20Swift)
* [tvOS Sample App - Swift](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Mobile%20Buy%20SDK%20tvOS%20Sample)
* [watchOS Sample App - Swift](https://github.com/Shopify/mobile-buy-sdk-ios/tree/develop/Mobile%20Buy%20SDK%20Sample%20Apps/Advanced%20App%20-%20ObjC/Mobile%20Buy%20SDK%20watchOS%20Sample%20App%20Extension)


We suggest you take a look at the **Advanced Sample App** and test your shop with the sample app before you begin. If you run into any issues, the **Advanced Sample App** is also a great resource for debugging integration issues and checkout.

### Product View

The Advanced Sample App includes an easy-to-use product view to make selling simple in any app. The `ProductViewController` displays any product, it's images, price and details and includes a variant selection flow. It will even handle Apple Pay and web checkout automatically:

![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_1.png)

You can also theme the `ProductViewController` to better match your app and products being displayed:

![Product View Screenshot](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Product_View_Screenshot_2.png)

The [Advanced Sample App](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/Advanced App - ObjC/) includes a demo of the `ProductViewController`. Documentation on how to use the `ProductViewController` is also available [here](https://github.com/Shopify/mobile-buy-sdk-ios/tree/master/Mobile Buy SDK Sample Apps/Advanced App - ObjC/PRODUCT_VIEW_README.md).

### Unit Tests

To run the Mobile Buy SDK integration tests against an actual shop, you will need a Shopify shop that is publicly accessible (not password protected). Please note that the integration tests **will create an order** on that shop. This is to validate that the SDK works properly with Shopify.  Modify the **test_shop_data.json** file to contain your shop's credentials and the required product IDs, gift cards, and discounts as necessary.

If the credentials in the **test_shop_config.json** are empty, running the integration tests will use mocked respoonses.  The mocked responses are defined in **mocked_responses.json**.  Do not check in credentials in this file.

Example `test_shop_config.json`
```
{	
	"domain":"yourshop.myshopify.com",
	"api_key":"abc123",
	"app_id":"8",
	"merchant_id":"merchant.com.yourcompany.app"
}
```

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
