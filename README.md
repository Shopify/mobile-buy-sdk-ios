![Mobile Buy SDK](https://raw.github.com/Shopify/mobile-buy-sdk-ios/master/Assets/Mobile_Buy_SDK_Github_banner.png)

[![Build status](https://badge.buildkite.com/3951692121947fbf7bb06c4b741601fc091efea3fa119a4f88.svg)](https://buildkite.com/shopify/mobile-buy-sdk-ios/builds?branch=sdk-3.0%2Fmaster)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/shopify/mobile-buy-sdk-ios.svg)](https://github.com/Shopify/mobile-buy-sdk-ios/releases)
[![CocoaPods](https://img.shields.io/cocoapods/v/Mobile-Buy-SDK.svg)](https://cocoapods.org/pods/Mobile-Buy-SDK)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Mobile Buy SDK

The Mobile Buy SDK makes it easy to create custom storefronts in your mobile app, where users can buy products using Apple Pay or their credit card. The SDK connects to the Shopify platform using GraphQL, and supports a wide range of native storefront experiences.

## Table of contents

- [Documentation](#documentation-)
- [Installation](#installation-)
  - [Dynamic framework installation](#dynamic-framework-installation-)
  - [Carthage](#carthage-)
  - [CocoaPods](#cocoapods-)

- [Getting started](#getting-started-)
- [Code generation](#code-generation-)
  - [Request models](#request-models-)
  - [Response models](#response-models-)
  - [The `Node` protocol](#the-node-protocol-)
  - [Aliases](#aliases-)

- [Graph client](#graph-client-)
  - [Queries](#queries-)
  - [Mutations](#mutations-)
  - [Retry and polling](#retry-)
  - [Errors](#errors-)

- [Card vaulting](#card-vaulting-)
  - [Card client](#card-client-)

- [ Pay](#apple-pay-)
  - [Pay Session](#pay-session-)
      - [Did update shipping address](#did-update-shipping-address-)
      - [Did select shipping rate](#did-select-shipping-rate-)
      - [Did authorize payment](#did-authorize-payment-)
      - [Did finish payment](#did-finish-payment-)

- [Case studies](#case-studies-)
  - [Fetch shop](#fetch-shop-)
  - [Fetch collections and products](#fetch-collections-and-products-)
  - [Pagination](#pagination-)
  - [Fetch product details](#fetch-product-details-)
  - [Checkout](#checkout-)
      - [Creating a checkout](#checkout-)
      - [Updating a checkout](#updating-a-checkout-)
      - [Polling for shipping rates](#polling-for-shipping-rates-)
      - [Completing a checkout](#completing-a-checkout-)
          - [Web](#web-checkout-)
          - [Credit card](#credit-card-checkout-)
          - [ Pay](#apple-pay-checkout-)
      - [Polling for checkout completion](#polling-for-checkout-completion-)
  - [Handling Errors](#handling-errors-)

- [Sample application](#sample-application-)
- [Contributions](#contributions-)
- [Help](#help-)
- [License](#license-)

### Documentation [⤴](#table-of-contents)

You can generate a complete HTML and `.docset` documentation by running the `Documentation` scheme. You can then use a documentation browser like [Dash](https://kapeli.com/dash) to access the `.docset` artifact, or browse the HTML directly in the `Docs/Buy` and `Docs/Pay` directories.

The documentation is generated using [Jazzy](https://github.com/realm/jazzy).

## Installation [⤴](#table-of-contents)

<a href="https://github.com/Shopify/mobile-buy-sdk-ios/releases/latest">Download the latest version</a>

### Dynamic Framework Installation [⤴](#table-of-contents)

1. Add **Buy.framework** target as a dependency:
  1. Open **Your Project**, and then select your target.
  2. Navigate to **Build Phases** > **Target Dependencies**.
  3. Add `Buy.framework`.
2. Link `Buy.framework`:
  1. Open **Your Project**, and then select your target.
  2. Navigate to **Build Phases** > **Link Binary With Libraries**.
  3. Add `Buy.framework`.
3. Make sure that the framework is copied into the bundle:
  1. Open **Your Project**, and then select your target.
  2. Navigate to **Build Phases** > **New Copy Files Phase**.
  3. From the **Destination** dropdown, select **Frameworks**.
  4. Add `Buy.framework`.
4. Import into your project files using `import Buy`.

See the **Storefront** sample app for an example of how to add the `Buy` target a dependency.

### Carthage [⤴](#table-of-contents)

1. Add the following line to your Cartfile:
  ```ruby
  github "Shopify/mobile-buy-sdk-ios"
  ```
2. Run `carthage update`.
3. Follow the [steps to link the dynamic framework](#dynamic-framework-installation-) that Carthage produced.
4. Import the SDK module:
  ```swift
  import Buy
  ```

### CocoaPods [⤴](#table-of-contents)

1. Add the following line to your podfile:
  ```ruby
  pod "Mobile-Buy-SDK"
  ```
2. Run `pod install`.
3. Import the SDK module:
  ```swift
  import Buy
  ```

## Getting started [⤴](#table-of-contents)

The Buy SDK is built on [GraphQL](http://graphql.org/). The SDK handles all the query generation and response parsing, exposing only typed models and compile-time checked query structures. It doesn't require you to write stringed queries, or parse JSON responses.

You don't need to be an expert in GraphQL to start using it with the Buy SDK (but it helps if you've used it before). The sections below provide a brief introduction to this system, and some examples of how you can use it to build secure custom storefronts.

## Migration from SDK v2.0 [⤴](#table-of-contents)

The previous version of the Mobile Buy SDK (version 2.0) is based on a REST API. With version 3.0, Shopify is migrating the SDK from REST to GraphQL.

Unfortunately, the specifics of generation GraphQL models make it almost impossible to create a migration path from v2.0 to v3.0 (domains models are not backwards compatible). However, the main concepts are the same across the two versions, such as collections, products, checkouts, and orders.

## Code Generation [⤴](#table-of-contents)

The Buy SDK is built on a hierarchy of generated classes that construct and parse GraphQL queries and responses. These classes are generated manually by running a custom Ruby script that relies on the [GraphQL Swift Generation](https://github.com/Shopify/graphql_swift_gen) library. Most of the generation functionality and supporting classes live inside the library. It works by downloading the GraphQL schema, generating Swift class hierarchy, and saving the generated files to the specified folder path. In addition, it provides overrides for custom GraphQL scalar types like `DateTime`.

### Request Models [⤴](#table-of-contents)

All generated request models are derived from the `GraphQL.AbstractQuery` type. Although this abstract type contains enough functionality to build a query, you should never use it directly. Instead, rely on the typed methods provided in the generated subclasses.

Let's take a look at an example query for a shop's name:

```swift
let query = Storefront.buildQuery { $0
    .shop { $0
        .name()
    }
}
```

Never use the abstract class directly:

```swift
// Never do this

let shopQuery = GraphQL.AbstractQuery()
shopQuery.addField(field: "name")

let query = GraphQL.AbstractQuery()
query.addField(field: "shop", subfields: shopQuery)

```

Both of the above queries produce identical GraphQL queries (see below), but the former approach provides auto-completion and compile-time validation against the GraphQL schema. It will surface an error if a requested field doesn't exist, isn't the correct type, or is deprecated. You also might have noticed that the former approach resembles the GraphQL query language structure (this is intentional). The query is both easier to write and much more legible.

```graphql
query {
  shop {
    name
  }
}
```

### Response models [⤴](#table-of-contents)

All generated response models are derived from the `GraphQL.AbstractResponse` type. This abstract type provides a similar key-value type interface to a `Dictionary` for accessing field values in GraphQL responses. Just like `GraphQL.AbstractQuery`, you should never use these accessors directly, and instead rely on typed, derived properties in generated subclasses.

Let's continue the example of accessing the result of a shop name query:

```swift
// response: Storefront.QueryRoot

let name: String = response.shop.name
```

Never use the abstract class directly:

```swift
// Never do this

let response: GraphQL.AbstractResponse

let shop = response.field("shop") as! GraphQL.AbstractResponse
let name = shop.field("name") as! String
```

Again, both of the approaches produce the same result, but the former case is preferred: it requires no casting since it already knows about the expected type.

### The `Node` protocol [⤴](#table-of-contents)

The GraphQL schema defines a `Node` interface that declares an `id` field on any conforming type. This makes it convenient to query for any object in the schema given only its `id`. The concept is carried across to the Buy SDK as well, but requires a cast to the correct type. You need to make sure that the `Node` type is of the correct type, otherwise casting to an incorrect time will return a runtime exception.

Given this query:

```swift
let id    = GraphQL.ID(rawValue: "NkZmFzZGZhc")
let query = Storefront.buildQuery { $0
    .node(id: id) { $0
        .onOrder { $0
            .id()
            .createdAt()
        }
    }
}
```

The `Storefront.Order` requires a cast:

```swift
// response: Storefront.QueryRoot

let order = response.node as! Storefront.Order
```

#### Aliases [⤴](#table-of-contents)

Aliases are useful when a single query requests multiple fields with the same names at the same nesting level, since GraphQL allows only unique field names. Multiple nodes can be queried by using a unique alias for each one:

```swift
let query = Storefront.buildQuery { $0
    .node(aliasSuffix: "collection", id: GraphQL.ID(rawValue: "NkZmFzZGZhc")) { $0
        .onCollection { $0
            // fields for Collection
        }
    }
    .node(aliasSuffix: "product", id: GraphQL.ID(rawValue: "GZhc2Rm")) { $0
        .onProduct { $0
            // fields for Product
        }
    }
}
```

Accessing the aliased nodes is similar to a plain node:

```swift
// response: Storefront.QueryRoot

let collection = response.aliasedNode(aliasSuffix: "collection") as! Storefront.Collection
let product    = response.aliasedNode(aliasSuffix: "product")    as! Storefront.Product
```

Learn more about [GraphQL aliases](http://graphql.org/learn/queries/#aliases).

## Graph.Client [⤴](#table-of-contents)

The `Graph.Client` is a network layer built on top of `URLSession` that executes `query` and `mutation` requests. It also simplifies polling and retrying requests. To get started with `Graph.Client`, you need the following:

- Your shop's `.myshopify.com` domain
- Your API key, which you can find in your shop's admin page
- A `URLSession` (optional), if you want to customize the configuration used for network requests or share your existing `URLSession` with the `Graph.Client`

```swift
let client = Graph.Client(
	shopDomain: "shoes.myshopify.com",
	apiKey:     "dGhpcyBpcyBhIHByaXZhdGUgYXBpIGtleQ"
)
```

GraphQL specifies two types of operations: queries and mutations. The `Client` exposes these as two type-safe operations, although also offering some conveniences for retrying and polling in each.

### Queries [⤴](#table-of-contents)

Semantically, a GraphQL `query` operation is equivalent to a `GET` RESTful call. It guarantees that no resources will be mutated on the server. With `Graph.Client`, you can perform a query operation using:

```swift
public func queryGraphWith(_ query: Storefront.QueryRootQuery, retryHandler: RetryHandler<Storefront.QueryRoot>? = default, completionHandler: QueryCompletion) -> Task
```

For example, let's take a look at how we can query for a shop's name:

```swift
let query = Storefront.buildQuery { $0
    .shop {
        .name()
    }
}

client.queryGraphWith(query) { response, error in
    if let response = response {
        let name = response.shop.name
    } else {
        print("Query failed: \(error)")
    }
}
```

Learn more about [GraphQL queries](http://graphql.org/learn/queries/).

### Mutations [⤴](#table-of-contents)

Semantically a GraphQL `mutation` operation is equivalent to a `PUT`, `POST` or `DELETE` RESTful call. A mutation is almost always accompanied by an input that represents values to be updated and a query to fetch fields of the updated resource. You can think of a `mutation` as a two-step operation where the resource is first modified, and then queried using the provided `query`. The second half of the operation is identical to a regular `query` request. With `Graph.Client` you can perform a mutation operation using:

```swift
public func mutateGraphWith(_ mutation: Storefront.MutationQuery, retryHandler: RetryHandler<Storefront.Mutation>? = default, completionHandler: MutationCompletion) -> Task
```

For example, let's take a look at how we can reset a customer's password using a recovery token:

```swift
let customerID = GraphQL.ID(rawValue: "YSBjdXN0b21lciBpZA")
let input      = Storefront.CustomerResetInput(resetToken: "c29tZSB0b2tlbiB2YWx1ZQ", password: "abc123")
let mutation   = Storefront.buildMutation { $0
    .customerReset(id: customerID, input: input) { $0
        .customer { $0
            .id()
            .firstName()
            .lastName()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}

client.mutateGraphWith(mutation) { response, error in
    if let mutation = response?.customerReset {

        if let customer = mutation.customer, !mutation.userErrors.isEmpty {
            let firstName = customer.firstName
            let lastName = customer.lastName
        } else {

            print("Failed to reset password. Encountered invalid fields:")
            mutation.userErrors.forEach {
                let fieldPath = $0.field?.joined() ?? ""
                print("  \(fieldPath): \($0.message)")
            }
        }

    } else {
        print("Failed to reset password: \(error)")
    }
}
```

A mutation will often rely on some kind of user input. Although you should always validate user input before posting a mutation, there are never guarantees when it comes to dynamic data. For this reason, you should always request the `userErrors` field on mutations (where available) to provide useful feedback in your UI regarding any issues that were encountered in the mutation query. These errors can include anything from `Invalid email address` to `Password is too short`.

Learn more about [GraphQL mutations](http://graphql.org/learn/queries/#mutations).

### Retry [⤴](#table-of-contents)

Both `queryGraphWith` and `mutateGraphWith` accept an optional `RetryHandler<R: GraphQL.AbstractResponse>`. This object encapsulates the retry state and customization parameters for how the `Client` will retry subsequent requests (such as after a set delay, or a number of retries). By default, the `retryHandler` is nil and no retry behavior will be provided. To enable retry or polling, create a handler with a condition. If the `handler.condition` and `handler.canRetry` evaluate to `true`, then the `Client` will continue executing the request:

```swift
let handler = Graph.RetryHandler<Storefront.QueryRoot>() { (query, error) -> Bool in
    if myCondition {
        return true // will retry
    }
    return false // will complete the request, either succeed or fail
}
```

The retry handler is generic, and can handle both `query` and `mutation` requests equally well.

### Errors [⤴](#table-of-contents)

The completion for either a `query` or `mutation` request will always contain an optional `Graph.QueryError` that represents the current error state of the request. **It's important to note that `error` and `response` are NOT mutually exclusive.** That is to say that it's perfectly valid to have a non-nil error and response. The presence of an error can represent both a network error (such as a network error, or invalid JSON) or a GraphQL error (such as invalid query syntax, or a missing parameter). The `Graph.QueryError` is an `enum`, so checking the type of error is trivial:

```swift
client.queryGraphWith(query) { response, error in
    if let response = response {
        // Do something
    } else {

        if let error = error, case .http(let statusCode) = error {
            print("Query failed. HTTP error code: \(statusCode)")
        }
    }
}
```

If the error is of type `.invalidQuery`, then an array of `Reason` objects is returned. These will provide more in-depth information about the query error. Keep in mind that these errors are not meant to be displayed to the end-user. **They are for debugging purposes only**.

The following example shows a GraphQL error response for an invalid query:

```json
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

Learn more about [GraphQL errors](http://graphql.org/learn/validation/).

## Card Vaulting [⤴](#table-of-contents)

The Buy SDK support native checkout via GraphQL, which lets you complete a checkout with a credit card. However, it doesn't accept credit card numbers directly. Instead, you need to vault the credit cards via the standalone, PCI-compliant web service. The Buy SDK makes it easy to do this using `Card.Client`.

### Card Client [⤴](#table-of-contents)

Like `Graph.Client`, the `Card.Client` manages your interactions with the card server that provides opaque credit card tokens. The tokens are used to complete checkouts. After collecting the user's credit card information in a secure manner, create a credit card representation and submit a vault request:

```swift
// let checkout: Storefront.Checkout
// let cardClient: Card.Client

let creditCard = Card.CreditCard(
	firstName:        "John",
	middleName:       "Singleton",
	lastName:         "Smith",
	number:           "1234567812345678",
	expiryMonth:      "07",
	expiryYear:       "19",
	verificationCode: "1234"
)

let task = cardClient.vault(creditCard, to: checkout.vaultUrl) { token, error in
    if let token = token {
        // proceed to complete checkout with `token`
    } else {
        // handle error
    }
}
task.resume()
```

**IMPORTANT:** The credit card vaulting service does **not** provide any validation for submitted credit cards. As a result, submitting invalid credit card numbers or even missing fields will always yield a vault `token`. Any errors related to invalid credit card information will be surfaced only when the provided `token` is used to complete a checkout.

## Apple Pay [⤴](#table-of-contents)

Support for  Pay is provided by the `Pay` framework. It is compiled and tested separately from the `Buy` SDK and offers a simpler interface for supporting  Pay in your application. It is designed to take the guess work out of using partial GraphQL models with `PKPaymentAuthorizationController`.

### Pay Session [⤴](#table-of-contents)

When the customer is ready to pay for products in your application with  Pay, the `PaySession` encapsulates all the states necessary to complete the checkout process:

- your shop's currency
- your  Pay `merchantID`
- available shipping rates
- selected shipping rate
- billing & shipping address
- checkout state

To present the  Pay modal and begin the checkout process, you need:

- a created `Storefront.Checkout`
- currency information that can be obtained with a `query` on `Storefront.Shop`
-  Pay `merchantID`

After all the prerequisites have been met, you can initialize a `PaySession` and start the payment authorization process:

```swift
self.paySession = PaySession(
	checkout:   payCheckout,
	currency:   payCurrency,
	merchantID: "com.merchant.identifier"
)

self.paySession.delegate = self     
self.paySession.authorize()
```

After calling `authorize()`, the session will create a `PKPaymentAuthorizationController` on your behalf and present it to the customer. By providing a `delegate`, you'll be notified when the customer changes shipping address, selects a shipping rate, and authorizes the payment using TouchID or passcode. It is **critical** to correctly handle each one of these events by updating the `Storefront.Checkout` with appropriate mutations to keep the checkout state on the server up-to-date.

Let's take a look at each one:

- [Did update shipping address](#did-update-shipping-address-)
- [Did select shipping rate](#did-select-shipping-rate-)
- [Did authorize payment](#did-authorize-payment-)
- [Did finish payment](#did-finish-payment-)

#### Did update shipping address [⤴](#table-of-contents)

```swift
func paySession(_ paySession: PaySession, didRequestShippingRatesFor address: PayPostalAddress, checkout: PayCheckout, provide: @escaping  (PayCheckout?, [PayShippingRate]) -> Void) {

    self.updateCheckoutShippingAddress(id: checkout.id, with: address) { updatedCheckout in
        if let updatedCheckout = updatedCheckout {

            self.fetchShippingRates(for: address) { shippingRates in
                if let shippingRates = shippingRates {

                    /* Be sure to provide an up-to-date checkout that contains the
                     * shipping address that was used to fetch the shipping rates.
                     */
                    provide(updatedCheckout, shippingRates)

                } else {

                    /* By providing a nil checkout we inform the PaySession that
                     * we failed to obtain shipping rates with the provided address. An
                     * "invalid shipping address" error will be displayed to the customer.
                     */
                    provide(nil, [])
                }
            }

        } else {

            /* By providing a nil checkout we inform the PaySession that
             * we failed to obtain shipping rates with the provided address. An
             * "invalid shipping address" error will be displayed to the customer.
             */
            provide(nil, [])
        }
    }
}
```

Invoked when the customer has selected a shipping contact in the  Pay modal. The provided `PayPostalAddress` is a partial address that excludes the street address for added security. This is actually enforced by `PassKit` and not the `Pay` framework. Nevertheless, information contained in `PayPostalAddress` is sufficient to obtain an array of available shipping rates from `Storefront.Checkout`.

#### Did select shipping rate [⤴](#table-of-contents)

```swift
func paySession(_ paySession: PaySession, didSelectShippingRate shippingRate: PayShippingRate, checkout: PayCheckout, provide: @escaping  (PayCheckout?) -> Void) {

    self.updateCheckoutWithSelectedShippingRate(id: checkout.id, shippingRate: shippingRate) { updatedCheckout in
        if let updatedCheckout = updatedCheckout {

            /* Be sure to provide the update checkout that include the shipping
             * line selected by the customer.
             */
            provide(updatedCheckout)

        } else {

            /* By providing a nil checkout we inform the PaySession that we failed
             * to select the shipping rate for this checkout. The PaySession will
             * fail the current payment authorization process and a generic error
             * will be shown to the customer.
             */
            provide(nil)
        }
    }
}
```

Invoked every time the customer selects a different shipping **and** the first time shipping rates are updated as a result of the previous `delegate` callback.

#### Did authorize payment [⤴](#table-of-contents)

```swift
func paySession(_ paySession: PaySession, didAuthorizePayment authorization: PayAuthorization, checkout: PayCheckout, completeTransaction: @escaping (PaySession.TransactionStatus) -> Void) {

    /* 1. Update checkout with complete shipping address. Example:
     * self.updateCheckoutShippingAddress(id: checkout.id, shippingAddress: authorization.shippingAddress) { ... }
     *
     * 2. Update checkout with the customer's email. Example:
     * self.updateCheckoutEmail(id: checkout.id, email: authorization.shippingAddress.email) { ... }
     *
     * 3. Complete checkout with billing address and payment data
     */
     self.completeCheckout(id: checkout.id, billingAddress: billingAddress, token: authorization.token) { success in
         completeTransaction(success ? .success : .failure)
     }
}
```

Invoked when the customer authorizes the payment. At this point, the `delegate` will receive the encrypted `token` and other associated information that you'll need for the final `completeCheckout` mutation to complete the purchase. The state of the checkout on the server **must** be up-to-date before invoking the final checkout completion mutation. Make sure that all in-flight update mutations are finished before completing checkout.

#### Did finish payment [⤴](#table-of-contents)

```swift
func paySessionDidFinish(_ paySession: PaySession) {
    // Do something after the  Pay modal is dismissed   
}
```

Invoked when the  Pay modal is dismissed, regardless of whether the payment authorization was successful or not.

## Case studies [⤴](#table-of-contents)

Getting started with any SDK can be confusing. The purpose of this section is to explore all areas of the Buy SDK that might be necessary to build a custom storefront on iOS and provide a solid starting point for your own implementation.

In this section we're going to assume that you've [set up a client](#graph-client-) somewhere in your source code. Although it's possible to have multiple instance of `Graph.Client`, reusing a single instance offers many behind-the-scenes performance improvements:

```swift
let client: Graph.Client
```

### Fetch shop [⤴](#table-of-contents)

Before you display products to the user, you typically need to obtain various metadata about your shop. This can be anything from a currency code to your shop's name:

```swift
let query = Storefront.buildQuery { $0
    .shop { $0
        .name()
        .currencyCode()
        .refundPolicy { $0
            .title()
            .url()
        }
    }
}

client.queryGraphWith(query) { response, error in
    let name         = response?.shop.name
    let currencyCode = response?.shop.currencyCode
    let moneyFormat  = response?.shop.moneyFormat
}
```

The corresponding GraphQL query looks like this:

```graphql
query {
  shop {
    name
    currencyCode
    refundPolicy {
      title
      url
    }
  }
}
```

### Fetch collections and products [⤴](#table-of-contents)

In our sample custom storefront, we want to display a collection with a preview of several products. With a conventional RESTful service, this would require one network call for collections and another network call for each collection in that array. This is often referred to as the `n + 1` problem.

The Buy SDK is built on GraphQL, which solves the `n + 1` request problem. In the following example, a single query will retrieve 10 collection and 10 products for each collection with just one network request:

```swift
let query = Storefront.buildQuery { $0
    .shop { $0
        .collections(first: 10) { $0
            .edges { $0
                .node { $0
                    .id()
                    .title()
                    .products(first: 10) { $0
                        .edges { $0
                            .node { $0
                                .id()
                                .title()
                                .productType()
                                .description()
                            }
                        }
                    }
                }
            }
        }
    }
}

client.queryGraphWith(query) { response, error in
    let collections  = response?.shop.collections.edges.map { $0.node }
    collections?.forEach { collection in

        let products = collection.products.edges.map { $0.node }
    }
}
```

The corresponding GraphQL query looks like this:

```swift
{
  shop {
    collections(first: 10) {
      edges {
        node {
          id
          title
          products(first: 10) {
            edges {
              node {
                id
                title
                productType
                description
              }
            }
          }
        }
      }
    }
  }
}
```

Since it only retrieves a small subset of properties for each resource, this GraphQL call is also much more bandwidth-efficient than it would be to fetch 100 complete resources via conventional REST.

But what if you need to get more than 10 products in each collection?

### Pagination [⤴](#table-of-contents)

Although it might be convenient to assume that a single network request will suffice for loading all collections and products, that might be naive. The best practice is to paginate results. Since the Buy SDK is built on top of GraphQL, it inherits the concept of `edges` and `nodes`.

Learn more about [pagination in GraphQL](http://graphql.org/learn/pagination/).

Let's take a look at how we can paginate through products in a collection:

```swift
let query = Storefront.buildQuery { $0
    .node(id: collectionID) { $0
        .onCollection { $0
            .products(first: 10, after: productsCursor) { $0
                .pageInfo { $0
                    .hasNextPage()
                }
                .edges { $0
                    .cursor()
                    .node { $0
                        .id()
                        .title()
                        .productType()
                        .description()
                    }
                }
            }
        }
    }
}

client.queryGraphWith(query) { response, error in
    let collection    = response?.node as? Storefront.Collection
    let productCursor = collection?.products.edges.last?.cursor
}
```

The corresponding GraphQL query looks like this:

```graphql
query {
  node(id: "IjoxNDg4MTc3MzEsImxhc3R") {
    ... on Collection {
      products(first: 10, after: "sdWUiOiIxNDg4MTc3M") {
        pageInfo {
          hasNextPage
        }
        edges {
          cursor
        	node {
            id
            title
            productType
            description
          }
        }
      }
    }
  }
}
```

Since we know exactly what collection we want to fetch products for, we'll use the [`node` interface](#the-node-protocol) to query the collection by `id`. You might have also noticed that we're fetching a couple of additional fields and objects: `pageInfo` and `cursor`. We can then use a `cursor` of any product edge to fetch more products `before` it or `after` it. Likewise, the `pageInfo` object provides additional metadata about whether the next page (and potentially previous page) is available or not.

### Fetch product details [⤴](#table-of-contents)

In our sample app we likely want to have a detailed product page with images, variants, and descriptions. Conventionally, we'd need multiple REST calls to fetch all the required information. But with the Buy SDK, we can do it with a single query:

```swift
let query = Storefront.buildQuery { $0
    .node(id: productID) { $0
        .onProduct { $0
            .id()
            .title()
            .description()
            .images(first: 10) { $0
                .edges { $0
                    .node { $0
                        .id()
                        .src()
                    }
                }
            }
            .variants(first: 10) { $0
                .edges { $0
                    .node { $0
                        .id()
                        .price()
                        .title()
                        .available()
                    }
                }
            }
        }
    }
}

client.queryGraphWith(query) { response, error in
    let product  = response?.node as? Storefront.Product
    let images   = product?.images.edges.map { $0.node }
    let variants = product?.variants.edges.map { $0.node }
}
```

The corresponding GraphQL query looks like this:

```graphql
{
  node(id: "9Qcm9kdWN0LzMzMj") {
    ... on Product {
      id
      title
      description
      images(first: 10) {
        edges {
          node {
            id
            src
          }
        }
      }
      variants(first: 10) {
        edges {
          node {
            id
            price
            title
            available
          }
        }
      }
    }
  }
}
```

### Checkout [⤴](#table-of-contents)

After browsing products and collections, a customer might eventually want to purchase something. The Buy SDK does not provide support for a local shopping cart since the requirements can vary between applications. Instead, the implementation is left up to the custom storefront. Nevertheless, when a customer is ready to make a purchase you'll need to create a checkout.

Almost every `mutation` query requires an input object. This is the object that dictates what fields will be mutated for a particular resource. In this case, we'll need to create a `Storefront.CheckoutCreateInput`:

```swift
let input = Storefront.CheckoutCreateInput(
    lineItems: [
        Storefront.CheckoutLineItemInput(variantId: GraphQL.ID(rawValue: "mFyaWFu"), quantity: 5),
        Storefront.CheckoutLineItemInput(variantId: GraphQL.ID(rawValue: "8vc2hGl"), quantity: 3),
    ]
)
```

The checkout input object accepts other arguments like `email` and `shippingAddress`. In our example we don't have access to that information from the customer until a later time, so we won't include them in this mutation. Given the checkout input, we can execute the `checkoutCreate` mutation:

```swift
let mutation = Storefront.buildMutation { $0
    .checkoutCreate(input: checkout) { $0
        .checkout { $0
            .id()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}

client.mutateGraphWith(mutation) { result, error in
    guard error == nil else {
        // handle request error
    }

    guard let userError = result?.checkoutCreate?.userErrors else {
        // handle any user error
        return
    }

    let checkoutID = result?.checkoutCreate?.checkout?.id
}
```

**It is best practice to always include `userErrors` fields in your mutation payload query, where possible.** You should always validate user input before making mutation requests, but it's possible that a validated user input might cause a mismatch between the client and server. In this case, `userErrors` contains an error with a `field` and `message` for any invalid or missing fields.

Since we'll need to update the checkout with additional information later, all we need from a checkout in this mutation is an `id` so we can keep a reference to it. We can skip all other fields on `Storefront.Checkout` for efficiency and reduced bandwidth.

#### Updating a checkout [⤴](#table-of-contents)

A customer's information might not be available when a checkout is created. The Buy SDK provides mutations for updating the specific checkout fields that are required for completion: the `email` and `shippingAddress` fields.

###### Updating email [⤴](#table-of-contents)

```swift
let mutation = Storefront.buildMutation { $0
    .checkoutEmailUpdate(checkoutId: id, email: "john.smith@gmail.com") { $0
        .checkout { $0
            .id()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}
```

###### Updating shipping address [⤴](#table-of-contents)

```swift
let shippingAddress: Storefront.MailingAddressInput
let mutation = Storefront.buildMutation { $0
    .checkoutShippingAddressUpdate(shippingAddress: shippingAddress, checkoutId: id) {
        .checkout { $0
            .id()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}
```

#### Polling for shipping rates [⤴](#table-of-contents)

Available shipping rates are specific to a checkout since the cost to ship items depends on the quantity, weight, and other attributes of the items in the checkout. Shipping rates also require a checkout to have a valid `shippingAddress`, which can be updated using steps found in [updating a checkout](#updating-a-checkout). Available shipping rates are a field on `Storefront.Checkout`, so given a `checkoutID` (that we kept a reference to earlier) we can query for shipping rates:

```swift
let query = Storefront.buildQuery { $0
    .node(id: checkoutID) { $0
        .onCheckout { $0
            .id()
            .availableShippingRates { $0
                .ready()
                .shippingRates { $0
                    .handle()
                    .price()
                    .title()
                }
            }
        }
    }
}
```

The query above starts an asynchronous task on the server to fetch shipping rates from multiple shipping providers. Although the request might return immediately (network latency aside), it does not mean that the list of shipping rates is complete. This is indicated by the `ready` field in the query above. It is your application's responsibility to continue retrying this query until `ready == true`. The Buy SDK has [built-in support for retrying requests](#retry), so we'll create a retry handler and perform the query:

```swift
let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(10)) { (response, error) -> Bool in
    return (response?.node as? Storefront.Checkout)?.availableShippingRates?.ready ?? false == false
}

let task = self.client.queryGraphWith(query, retryHandler: retry) { response, error in
    let checkout      = (response?.node as? Storefront.Checkout)
    let shippingRates = checkout.availableShippingRates?.shippingRates
}
```

The completion will be called only if `availableShippingRates.ready == true` or the retry count reaches 10. Although you can specify `.infinite` for the retry handler's `endurance` property, we highly recommend you set a finite limit.

#### Completing a checkout [⤴](#table-of-contents)

After all required fields have been filled and the customer is ready to pay, you have three ways to complete the checkout and process the payment:

- [Web](#web-checkout-)
- [Credit card](#credit-card-checkout-)
- [ Pay](#apple-pay-checkout-)

###### Web checkout [⤴](#table-of-contents)

The simplest way to complete a checkout is by redirecting the customer to a web view where they will be presented with the same flow that they're familiar with on the web. The `Storefront.Checkout` resource provides a `webUrl` that you can use to present a web view. We highly recommend using `SFSafariViewController` instead of `WKWebView` or other alternatives.

**NOTE**: Although using web checkout is the simplest out of the 3 approaches, it presents some difficulty when it comes to observing the checkout state. Since the web view doesn't provide any callbacks for various checkout states, you still need to [poll for checkout completion](#poll-for-checkout-completion-).

###### Credit card checkout [⤴](#table-of-contents)

The native credit card checkout offers the most conventional user experience out of the three alternatives, but it also requires the most effort to implement. You'll be required to implement UI for gathering your customers' name, email, address, payment information and other fields required to complete checkout.

Assuming your custom storefront has all the information it needs, the first step to completing a credit card checkout is to vault the provided credit card and exchange it for a payment token that will be used to complete the payment. Please reference the instructions for [vaulting a credit card](#card-vaulting-).

After obtaining a credit card vault token, we can proceed to complete the checkout by creating a `CreditCardPaymentInput` and executing the mutation query:

```swift
// let paySession: PaySession
// let payCheckout: PayCheckout
// let payAuthorization: PayAuthorization

let payment = Storefront.CreditCardPaymentInput(
    amount:         payCheckout.paymentDue,
    idempotencyKey: paySession.identifier,
    billingAddress: self.mailingAddressInputFrom(payAuthorization.billingAddress,
    vaultId:        token
)

let mutation = Storefront.buildMutation { $0
    .checkoutCompleteWithCreditCard(checkoutId: checkoutID, payment: payment) { $0
        .payment { $0
            .id()
            .ready()
        }
        .checkout { $0
            .id()
            .ready()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}

client.mutateGraphWith(mutation) { result, error in
    guard error == nil else {
        // handle request error
    }

    guard let userError = result?.checkoutCompleteWithCreditCard?.userErrors else {
        // handle any user error
        return
    }

    let checkoutReady = result?.checkoutCompleteWithCreditCard?.checkout.ready ?? false
    let paymentReady  = result?.checkoutCompleteWithCreditCard?.payment?.ready ?? false

    // checkoutReady == false
    // paymentReady == false
}
```

###### Apple Pay checkout [⤴](#table-of-contents)

The Buy SDK makes  Pay integration easy with the provided `Pay.framework`. Please refer to the [ Pay](#apple-pay-) section on how to setup and use `PaySession` to obtain a payment token. After we have a payment token, we can complete the checkout:

```swift
// let paySession: PaySession
// let payCheckout: PayCheckout
// let payAuthorization: PayAuthorization

let payment = Storefront.TokenizedPaymentInput(
    amount:         payCheckout.paymentDue,
    idempotencyKey: paySession.identifier,
    billingAddress: self.mailingAddressInputFrom(payAuthorization.billingAddress), // <- perform the conversion
    type:           "apple_pay",
    paymentData:    payAuthorization.token
)

let mutation = Storefront.buildMutation { $0
    .checkoutCompleteWithTokenizedPayment(checkoutId: checkoutID, payment: payment) { $0
        .payment { $0
            .id()
            .ready()
        }
        .checkout { $0
            .id()
            .ready()
        }
        .userErrors { $0
            .field()
            .message()
        }
    }
}

client.mutateGraphWith(mutation) { result, error in
    guard error == nil else {
        // handle request error
    }

    guard let userError = result?.checkoutCompleteWithTokenizedPayment?.userErrors else {
        // handle any user error
        return
    }

    let checkoutReady = result?.checkoutCompleteWithTokenizedPayment?.checkout.ready ?? false
    let paymentReady  = result?.checkoutCompleteWithTokenizedPayment?.payment?.ready ?? false

    // checkoutReady == false
    // paymentReady == false
}
```

#### Polling for checkout completion [⤴](#table-of-contents)

After a successful `checkoutCompleteWith...` mutation, the checkout process has started. This process is usually short, but it isn't immediate. Because of this, polling is required to obtain an updated checkout in a `ready` state - with a `Storefront.Order`.

```swift
let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { (response, error) -> Bool in
    return (response?.node as? Storefront.Checkout)?.order == nil
}

let query = Storefront.buildQuery { $0
    .node(id: checkoutID) { $0
        .onCheckout { $0
            .order { $0
                .id()
                .createdAt()
                .orderNumber()
                .totalPrice()
            }
        }
    }
}

let task  = self.client.queryGraphWith(query, retryHandler: retry) { response, error in
    let checkout = (response?.node as? Storefront.Checkout)
    let orderID  = checkout?.order?.id
}
```

Again, just like when [polling for available shipping rates](#polling-for-shipping-rates-), we need to create a `RetryHandler` to provide a condition upon which to retry the request. In this case, we're asserting that the `Storefront.Order` is `nil`, and we'll continue to retry the request if it is.

#### Handling errors [⤴](#table-of-contents)

The `Graph.Client` can return a non-nil `Graph.QueryError`. **The error and the result are not mutually exclusive.** It is valid to have both an error and a result. However, the error `case`, in this instance, is **always** `.invalidQuery(let reasons)`. You should always evaluate the `error`, make sure that you don't have an invalid query, and then evaluate the result:

```swift
let task = self.client.queryGraphWith(query) { result, error in

    if let error = error, case .invalidQuery(let reasons) = error {
        reasons.forEach {
            print("Error on \($0.line):\($0.column) - \($0.message)")
        }
    }

    if let result = result {
        // Do something with the result
    } else {
        // Handle any other errors
    }
}
```

**IMPORTANT:** `Graph.QueryError` does not contain user-friendly information. Often, it describes the technical reason for the failure, and shouldn't be shown to the end-user. Handling errors is most useful for debugging.

## Sample application [⤴](#table-of-contents)

The Buy SDK includes a comprehensive sample application that covers the most common use cases of the SDK. It's built on best practices and our recommended `ViewModel` architecture. You can use it as a template, a starting point, or a place to cherrypick components as needed. Check out the [Storefront readme](/Sample%20Apps/Storefront/) for more details.

## Contributions [⤴](#table-of-contents)

We welcome contributions. Please follow the steps in our [contributing guidelines](CONTRIBUTING.md).

## Help [⤴](#table-of-contents)

For help with the Mobile Buy SDK, post questions on [our forum](https://ecommerce.shopify.com/c/shopify-apis-and-technology), in the `Shopify APIs & SDKs` section.

## License [⤴](#table-of-contents)

The Mobile Buy SDK is provided under an [MIT License](LICENSE).
