What is this?
=====================

This is a client implementation of Checkout Anywhere for iOS that supports ApplePay.

## Prereqs

1. Fetch products in one way or another. You can use the provided SDK or just have the data and create the models.
2. [ApplePay only] Get your Stripe Publishable Key.

## Flow

1. Create a cart.
2. Transform cart into a Checkout.
3. Add information to the Checkout.
4. Post a credit card OR a **Stripe** token to our card store (which you can obtain via an **ApplePay** token).
5. Complete the checkout.
6. Poll until the payment job completes.
7. Bask in the glory of a created order.

## Flow Examples

For a view of what a 'synchronous' view of checkout would look like: see the [integration tests](https://github.com/Shopify/checkout-anywhere-ios/blob/master/CheckoutAnywhere/CheckoutAnywhereTests/CHKAnywhereIntegrationTest.m)

Here is a simplistic view:

```
Create the checkout
[_checkoutDataProvider createCheckout:checkout completion:...]

Update the checkout
[_checkoutDataProvider updateCheckout:checkout completion:...] (if necessary)

Add a payment method
[_checkoutDataProvider storeCreditCard:creditCard checkout:checkout completion:...] (or storeStripeToken:)

Complete the checkout
[_checkoutDataProvider completeCheckout:checkout block:...]

Poll for completion
[_checkoutDataProvider getCompletionStatusOfCheckout:checkout block:...]

Update the checkout to obtain the final information
[_checkoutDataProvider getCheckout:checkout completion:...]
```

Pods
====
This repo is also a (private) CocoaPod.

Make sure to run `pod spec lint ShopifyCheckoutAnywhere.podspec` before publishing, and update this README.md to be public facing.
