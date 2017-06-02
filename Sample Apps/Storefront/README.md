![Mobile Buy SDK](https://cloud.githubusercontent.com/assets/5244861/26738020/885c12ac-479a-11e7-8914-2853ec09f89f.png)

# Storefront App

Mobile Buy SDK shipped with a sample application that demonstrates an example of how to build a custom storefront on iOS. Using this sample application a user can browse your shop's product collections, products, add merchandise to a cart and checkout using Apple Pay or web checkout.

## Setup

In order to run the sample application you will need to provide credentials to the shop the app will point to.

1. First, ensure that your have `Mobile App` channel enabled on your shop
2. Navigate to the `Mobile App` channel in your shop's admin and obtain an API key
3. Open the Sample Application project in `Sample App > Storefront > Storefront.xcodeproj`
4. Open `Client.swift` and insert your API key and shop domain

```swift
final class Client {
    
    static let shopDomain = "yourshophere.myshopify.com"
    static let apiKey     = "2dce9587e0f140ac84aaec25847e9d35"
    ...
}
```

## License

The Mobile Buy SDK is provided under an MIT Licence.  See the [LICENSE](../../LICENSE) file
