# Mobile Buy SDK Sample Swift App

The Swift sample app demonstrates how to use the SDK within a Swift app. The app includes an Objective-C bridging header.

### Getting started

First, add your shop domain, API key and App ID to the `Config.swift`.

```swift
let shopDomain = ""
let apiKey = ""
let appId = ""
let productId = ""
```

### Overview

The sample app also demonstrates how to use the `BUYClient` to obtain a product by calling `getProductById()`.

```swift
client.getProductById(productId) { (product, error) -> Void in
}
```
