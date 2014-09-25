What is this?
=====================

This is a client implementation of Checkout Anywhere for iOS that supports ApplePay.

Here is what a 'synchronous' view of checkout would look like: (stolen from the integration tests)
```
  //=======================================
  //1) Create the base cart
  //=======================================
  CHKCart *cart = [[CHKCart alloc] init];
  [cart addVariant:[_products[0] variants][0]];
  ...
  
  //=======================================
  //2) Create the checkout with Shopify
  //=======================================
  __block CHKCheckout *checkout;
  dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
  NSURLSessionDataTask *task = [_checkoutDataProvider createCheckoutWithCart:cart completion:^(CHKCheckout *returnedCheckout, NSError *error) {
    checkout = returnedCheckout;
    dispatch_semaphore_signal(semaphore);
  }];
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  
  //=======================================
  //3) Add some information to it
  //=======================================
  checkout.email = @"banana@testasaurus.com";
  checkout.shippingAddress = [self testShippingAddress];
  checkout.billingAddress = [self testBillingAddress];
  
  task = [_checkoutDataProvider updateCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
    checkout = returnedCheckout;
    dispatch_semaphore_signal(semaphore);
  }];
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  
  //=======================================
  //4) Store a credit card on the secure server
  //=======================================
  CHKCreditCard *creditCard = [[CHKCreditCard alloc] init];
  creditCard.number = @"4242424242424242";
  creditCard.expiryMonth = @"12";
  creditCard.expiryYear = @"20";
  creditCard.cvv = @"123";
  creditCard.nameOnCard = @"Dinosaur Banana";
  task = [_checkoutDataProvider storeCreditCard:creditCard checkout:checkout completion:^(CHKCheckout *returnedCheckout, NSString *paymentSessionId, NSError *error) {
    checkout = returnedCheckout;
    dispatch_semaphore_signal(semaphore);
  }];
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  
  //=======================================
  //5) Complete the checkout
  //=======================================
  task = [_checkoutDataProvider completeCheckout:checkout block:^(CHKCheckout *returnedCheckout, NSError *error) {
    checkout = returnedCheckout;
    dispatch_semaphore_signal(semaphore);
  }];
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  
  //=======================================
  //6) Poll for job status
  //=======================================
  __block CHKStatus status = CHKStatusUnknown;
  while (status != CHKStatusFailed && status != CHKStatusComplete) {
    task = [_checkoutDataProvider getCompletionStatusOfCheckout:checkout block:^(CHKCheckout *returnedCheckout, CHKStatus returnedStatus, NSError *error) {
      if (error) {
        status = CHKStatusFailed;
      }
      else {
        status = returnedStatus;
      }
      dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  }
  
  //=======================================
  //7) Fetch the checkout again
  //=======================================
  task = [_checkoutDataProvider getCheckout:checkout completion:^(CHKCheckout *returnedCheckout, NSError *error) {
    checkout = returnedCheckout;
    dispatch_semaphore_signal(semaphore);
  }];
  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
  
  // DONE!
```

Here's a view without all of the semaphores (this won't work, but it shows you the concise flow)

```
  //=======================================
  //1) Create the base cart
  //=======================================
  CHKCart *cart = [[CHKCart alloc] init];
  [cart addVariant:[_products[0] variants][0]];
  ...
  
  //=======================================
  //2) Create the checkout with Shopify
  //=======================================
  [_checkoutDataProvider createCheckoutWithCart:cart completion:...];
  
  //=======================================
  //3) Add some information to it
  //=======================================
  checkout.email = @"banana@testasaurus.com";
  checkout.shippingAddress = [self testShippingAddress];
  checkout.billingAddress = [self testBillingAddress];
  
  [_checkoutDataProvider updateCheckout:checkout completion:...];
  
  //=======================================
  //4) Store a credit card on the secure server
  //=======================================
  CHKCreditCard *creditCard = [[CHKCreditCard alloc] init];
  creditCard.number = @"4242424242424242";
  creditCard.expiryMonth = @"12";
  creditCard.expiryYear = @"20";
  creditCard.cvv = @"123";
  creditCard.nameOnCard = @"Dinosaur Banana";
  [_checkoutDataProvider storeCreditCard:creditCard checkout:checkout completion:...];
  
  //=======================================
  //5) Complete the checkout
  //=======================================
  [_checkoutDataProvider completeCheckout:checkout block:...];
  
  //=======================================
  //6) Poll for job status
  //=======================================
  __block CHKStatus status = CHKStatusUnknown;
  while (status != CHKStatusFailed && status != CHKStatusComplete) {
    [_checkoutDataProvider getCompletionStatusOfCheckout:checkout block:...];
  }
  
  //=======================================
  //7) Fetch the checkout again
  //=======================================
  [_checkoutDataProvider getCheckout:checkout completion:...];
  
  // DONE!
```

Pods
====
This repo is also a (private) CocoaPod.

Make sure to run `pod spec lint ShopifyCheckoutAnywhere.podspec` before publishing, and update this README.md to be public facing.
