# Mobile Buy SDK Integration Guide

Shopify's Mobile Buy SDK for iOS enables merchants to easily sell products in iOS apps and allows their customers to checkout using the Shopify Checkout API or Apple Pay.

## Getting Started

### Requirements

- iOS 8.0 or greater
- Xcode 6.2 or greater
- *Mobile App* Channel on your shop
- Apple Pay Guide: [Getting Started with Apple Pay](https://developer.apple.com/apple-pay/Getting-Started-with-Apple-Pay.pdf)

### Installation

1. In the project editor, select the target to which you want to add `Buy.framework`.
<center><img src="sdk_integration_embedding_framework_1.png" width="100%" alt="Mobile Buy SDK integration Xcode 1"/></center>

2. In the **General** tab, drag the `Buy.framework` onto the **Embedded Binaries** section. Check **Copy items if needed** so the framework is copied to your project.
<center><img src="sdk_integration_embedding_framework_2.png" width="100%" alt="Mobile Buy SDK integration Xcode 2"/></center>

### Initialize the framework

Import the Buy header

	@import Buy;

Initialize the client
 
	BUYClient *client = [[BUYClient alloc] initWithShopDomain:SHOP_DOMAIN
													   apiKey:API_KEY
												    channelId:CHANNEL_ID];

Optionally, enable Apple Pay (you must enable Apple Pay in the *Mobile App* Channel)

	[client enableApplePayWithMerchantId:MERCHANT_ID];
	
Test the integration

	// FOR DEBUG PURPOSES ONLY. DO NOT USE IN RELEASE.
	[client testIntegration]
	
This method call should only be made once to ensure your integration works. Once you have confirmed that the integration works on the Mobile App Channel, remove this method.

## Using the Mobile Buy SDK
The easiest way to use the Mobile Buy SDK is to leverage the `BUYViewController`. This view controller handles most of the checkout process for you, and makes it easy to support Apple Pay.

We provide two sample apps that integrate this view controller:

- The `Sample App Native` demonstrates a native checkout using Apple Pay
- The `Sample App Web` displays a shop's responsive website and supports both Apple Pay and web checkout

To implement a fully custom checkout experience in your app, use the **Mobile Buy SDK** to obtain product details, build a cart, and complete a checkout. The `BUYClient` provides methods to perform these tasks.

### Overview

- [Getting Products](#getting-products)
- [Building a cart](#building-a-cart)
- [Creating a Checkout](#creating-a-checkout)
- [Adding information to the Checkout](#adding-information-to-the-checkout)
- [Completing the Checkout](#completing-the-checkout)
- [Checking for Checkout Completion](#checking-for-checkout-completion)
- [Error Handling](#error-handling)

### Getting Products<div id="getting-products"></div>

Get products from a shop and display the products in your app.

	[client getProductsPage:0 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
	    if (error == nil) {
	        self.products = products;
			// display list of products
	    } else {
	        // Handle errors here
	    }
	}];

### Building a Cart<div id="building-a-cart"></div>

`BUYCart` consists of one or more line items from product variants retrieved in the product list. 

	// Create a cart
	BUYCart *cart = [[BUYCart alloc] init];
	
	// Add a product variant to the cart
	// In this case, we're adding the first product and its first variant
	BUYProduct *product = [self.products firstObject];
	BUYProductVariant *variant = [product.variants firstObject];
	[cart addVariant:variant];

### Creating a Checkout<div id="creating-a-checkout"></div>

When the customer is ready to make a purchase, a `BUYCheckout` must be created from the `BUYCart` object.

	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];

	// Sync the checkout with Shopify
	[client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
	    if (error == nil) {
	        self.checkout = checkout;
	    } else {
	        // Handle errors here
	    }
	}];

### Adding information to the Checkout<div id="adding-information-to-the-checkout"></div>

Before completing the checkout, additional shipping and payment information must be added to the `BUYCheckout` object. The customer's shipping information is required to obtain shipping rates. This is an opportunity to prompt the customer for their shipping address. 

If you want to support Apple Pay, familiarize yourself with the [Apple Pay Programming Guide](https://developer.apple.com/library/ios/ApplePay_Guide/). The shipping address is provided from the `PKPaymentAuthorizationViewControllerDelegate` method `paymentAuthorizationViewController:didSelectShippingAddress:completion:`

	// Get the customer's shipping address
	BUYAddress *shippingAddress = [[BUYAddress alloc] init];
	shippingAddress.address1 = @"421 8th Ave";
	shippingAddress.city = @"New York";
	shippingAddress.province = @"NY";
	shippingAddress.zip = @"10001";
	shippingAddress.countryCode = @"US";
	
	// Add the shipping information to the checkout
	self.checkout.shippingAddress = shippingAddress;
	
	// Update the checkout with the shipping address
	[client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
	    if (error == nil) {
	        self.checkout = checkout;
	    } else {
	        // Handle errors here
	    }
	}];

Once the checkout has been updated with the shipping address, the shipping rates can be retreived.

	// Obtain shipping rates
	[client getShippingRatesForCheckout:self.checkout completion:^(NSArray *shippingRates, NSError *error) {
	    if (error == nil) {
	        // prompt the customer to select the desired shipping method
	        self.shippingRates = shippingRates;
	    } else {
	        // Handle errors here
	    }
	}];

Add the selected shipping method to the `BUYCheckout` object.

	BUYShippingRate *selectedShippingRate;
	self.checkout.shippingRate = selectedShippingRate;

### Completing the Checkout<div id="completing-the-checkout"></div>

At this point you are ready to collect the payment information from the customer. If using a credit card payment, prompt the customer to enter the credit card information. If [using Apple Pay](#Option-2-Using-Apple-Pay), keep a reference to the `PKPaymentToken`.

Although the SDK supports payment by credit card, we highly recommend that you use Apple Pay as the only source of payment within your app. Familiarize yourself with the [Mobile PCI Standards](https://www.pcisecuritystandards.org/documents/Mobile_Payment_Security_Guidelines_Developers_v1.pdf) before including a full credit card checkout flow in your app.

#### Option 1: Using Credit Card

	BUYCreditCard *creditCard = [[BUYCreditCard alloc] init];
	creditCard.number = @"4242424242424242";
	creditCard.expiryMonth = @"12";
	creditCard.expiryYear = @"20";
	creditCard.cvv = @"123";
	creditCard.nameOnCard = @"Dinosaur Banana";
	
	// Associate the credit card with the checkout
	[client storeCreditCard:creditCard checkout:self.checkout completion:^(BUYCheckout *returnedCheckout, NSString *paymentSessionId, NSError *error) {
		if (error == nil) {
	        self.checkout = returnedCheckout;
	    } else {
	        // Handle errors here
	    }
	}];

Once the credit card has been stored on the checkout on Shopify, the checkout can be completed.

	[client completeCheckout:self.checkout completion:^(BUYCheckout *returnedCheckout, NSError *error) {
		if (error == nil) {
	        self.checkout = returnedCheckout;
	    } else {
	        // Handle errors here
	    }
	}];

#### Option 2: Using Apple Pay 

Obtain a `PKPaymentToken` from the `PKPayment` object provided through the `PKPaymentAuthorizationViewControllerDelegate` method `updateAndCompleteCheckoutWithPayment:completion:`

The `PKPaymentToken` enables Shopify Payments to process the payment.

	// After obtaining a PKPayment using Apple Pay, complete checkout on Shopify
	[client completeCheckout:checkout withApplePayToken:payment.token completion:^(BUYCheckout *checkout, NSError *error) {
		if (error == nil) {
			self.checkout = checkout;
			// check for checkout completion
		} else {
			// Handle errors here
		}
	}];

### Checking for Checkout Completion<div id="checking-for-checkout-completion"></div>

`completeCheckout:completion:` and `completeCheckout:withApplePayToken:completion:` returns immediately. You are required to poll the status of a checkout until the checkout is complete (either sucessful or failed).

	__block BUYStatus buyStatus = BUYStatusUnknown;
	__block BUYCheckout *completedCheckout = self.checkout;
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	do {
		[client getCompletionStatusOfCheckout:self.checkout completion:^(BUYCheckout *checkout, BUYStatus status, NSError *error) {
			completedCheckout = checkout;
			buyStatus = status;
			dispatch_semaphore_signal(semaphore);
		}];
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		
		if (buyStatus == BUYStatusProcessing) {
			[NSThread sleepForTimeInterval:0.5];
		} else {
			// Handle success/error
		} 
	} while (completedCheckout.token && buyStatus != BUYStatusFailed && buyStatus != BUYStatusComplete)

## Error Handling<div id="error-handling"></div>

It's essential to verify the `error` object returned with every completion block.

For example, if you were to complete a checkout **without an email**, the `error.userInfo` will be:

	{
	  "errors" = {
	    "checkout" = {
	      "email" = [ 				// One error associated with a "blank" (or missing) email.
	        {
	          "code" = "blank",
	          "message" = "can't be blank"
	        }],
	       "line_items" = [],      // No errors associated with this
	       "shipping_rate_id" = [] // No errors associated with this
	  }
	}
