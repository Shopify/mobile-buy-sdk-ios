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
  - [CocoaPods](#cocoapods)
  - [Carthage](#carthage)

- [Getting Started](#getting-started)
- [Code Generation](#code-generation)
  - [Ruby Script](#)
  - [Generated query & mutation request models](#)
  - [Generated query & mutation response models](#)
  - [Node, aliases](#)

- [GraphClient](#)
  - [Initialization](#)
  - [Query & mutations](#)
  - [Retry & polling](#)
  - [Graph client errors](#)

- [Pay Helper](#)

- [Case study](#)
  - [Fetch Shop info](#)
  - [Fetch Collections ](#)
  - [Fetch Collections](#)
      - [Fetch Collection by ID](#)
      - [Fetch Product by ID](#)
  - [Create Checkout](#)
  - [Update Checkout](#)
      - [Update Checkout with Customer Email](#)
      - [Update Checkout with Customer Shipping Address](#)
      - [Polling Checkout Shipping Rates](#)
  - [Complete Checkout](#)
      - [With Credit Card](#)
      - [With Apple Pay](#)
      - [Polling Checkout Payment Status](#)
  - [Handling Errors](#)

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

2. Add `Buy.framework` target as a depenency by navigating to:
  - `Your Project` and (Select your target)
  - `Build Phases`
  - `Target Dependencies`
  -  Add  `Buy.framework`
3. Link `Buy.framework` by navigating to:
  - `Your Project` and (Select your target)
  - `Build Phases`
  - `Link Binary With Libraries`
  -  Add `Buy.framework`
4. Ensure the framework is copied into the bundle by navigating to:
  - `Your Project` and (Select your target)
  - `Build Phases`
  - Add `New Copy Files Phase`
  - Select `Destination` dropdown and chose `Frameworks`
  - Add `Buy.framework`
5. Import into your project files using `import Buy`
 
See the `Storefront` sample app for an example of how to add the `Buy` target a dependency.

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

The Buy SDK is built on top of [GraphQL](http://graphql.org/). While some knowledge of GraphQL is good to have, you don't have to be an expert to start using with the Buy SDK. Instead of writing stringly-typed queries, the SDK provides generated classes and a builder pattern to help you write compile-time checked and auto-complete friendly queries and work with typed response models.

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
To learn more about GraphQL types & models go to official [page](http://graphql.org/learn/schema/)

### Queries & Mutations

The Buy SDK is built on GraphQL, which means that you'll inherit all the powerful capabilities GraphQL has to offer. As a result, there's a paradigm shift. With Buy SDK, you'll need to "query" the API and describe in the shape of an object graph what kind of fields and entities the server should return. Let's take a look at how to build a simple query.

GraphQL queries are written in plain text but the SDK offers a builder that abstracts the knowledge of the GraphQL schema and provides auto-completion. There are two types of queries:

#### Query
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

#### Mutation
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
To learn more about GraphQL queries & mutations go to official [page](http://graphql.org/learn/queries/)

### Query Arguments
Example of query arguments:
```graphql
{
  shop {
    products(first:50, sortKey: TITLE) {
      edges {
        node {
          id
          title
        }
      }
    }
  }
}
```
To learn more about GraphQL errors go to official [page](http://graphql.org/learn/queries/#arguments)

### Errors
Example of GraphQL error reponse:
```graphql
{
  "errors": [
    {
      "message": "Field 'Shop' doesn't exist on type 'QueryRoot'",
      "locations": [
        {
          "line": 2,
          "column": 90
        }
      ],
      "fields": [
        "query CollectionsWithProducts",
        "Shop"
      ]
    }
  ]
}
```

### Code Generation
#### Ruby Script
#### Generated query & mutation request models
#### Generated query & mutation response models
#### Node, aliases

### GraphClient
#### Initialization
#### Query & mutations
#### Retry & polling
#### Graph client errors

### Pay Helper

### Case study
#### Fetch Shop info
#### Fetch Collections 
##### Fetch Collections with Products
#### Fetch Collection by ID
#### Fetch Product by ID
#### Create Checkout
#### Update Checkout
##### Update Checkout with Customer Email
##### Update Checkout with Customer Shipping Address
##### Polling Checkout Shipping Rates

### Complete Checkout
#### With Credit Card
#### With Apple Pay
#### Polling Checkout Payment Status

### Handling Errors


### Contributions

We welcome contributions. Follow the steps in [CONTRIBUTING](CONTRIBUTING.md) file.

### Help

For help, please post questions on our forum, in the Shopify APIs & Technology section: https://ecommerce.shopify.com/c/shopify-apis-and-technology

### License

The Mobile Buy SDK is provided under an MIT Licence.  See the [LICENSE](LICENSE) file
