![Mobile Buy SDK](https://cloud.githubusercontent.com/assets/5244861/26738020/885c12ac-479a-11e7-8914-2853ec09f89f.png)

# Storefront App

The Mobile Buy SDK ships with a sample application that demonstrates how to build a custom storefront on iOS. Using this sample application, a user can browse your shop's products and collections, add merchandise to a cart, and then checkout using Apple Pay or a web checkout.

## Setup

The sample application is pre-configured with credentials to a test shop and requires no setup to build and run. You can also run the sample application with your own shop by following the steps below:

1. Ensure that all submodules of `Buy SDK` have also been updated by running:
```
git submodule update --init --recursive
```
2. Make sure that you have the **Mobile App** channel installed in your Shopify admin.
3. From your Shopify admin, navigate to the **Mobile App** channel, and then copy your API key.
4. Open the Sample Application project in `Sample App > Storefront > Storefront.xcodeproj`
5. Open `Client.swift`, and then insert your API key and shop domain:

```swift
final class Client {

    static let shopDomain = "yourshophere.myshopify.com"
    static let apiKey     = "2dce9587e0f140ac84aaec25847e9d35"
    ...
}
```

## License

The Mobile Buy SDK is provided under an MIT License.  See the [LICENSE](../../LICENSE) file
