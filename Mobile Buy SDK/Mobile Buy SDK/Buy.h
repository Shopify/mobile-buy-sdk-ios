//
//  Buy.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

// Model types
#import <Buy/BUYAccountCredentials.h>
#import <Buy/BUYAddress.h>
#import <Buy/BUYCart.h>
#import <Buy/BUYCartLineItem.h>
#import <Buy/BUYCheckout.h>
#import <Buy/BUYCheckoutAttribute.h>
#import <Buy/BUYCollection.h>
#import <Buy/BUYCreditCard.h>
#import <Buy/BUYCustomer.h>
#import <Buy/BUYCustomerToken.h>
#import <Buy/BUYDiscount.h>
#import <Buy/BUYGiftCard.h>
#import <Buy/BUYImageLink.h>
#import <Buy/BUYLineItem.h>
#import <Buy/BUYMaskedCreditCard.h>
#import <Buy/BUYOption.h>
#import <Buy/BUYOptionValue.h>
#import <Buy/BUYOrder.h>
#import <Buy/BUYPaymentToken.h>
#import <Buy/BUYProduct.h>
#import <Buy/BUYProductVariant.h>
#import <Buy/BUYShippingRate.h>
#import <Buy/BUYShop.h>
#import <Buy/BUYTaxLine.h>

// Model support
#import <Buy/BUYError.h>
#import <Buy/BUYError+BUYAdditions.h>
#import <Buy/BUYManagedObject.h>
#import <Buy/BUYModelManager.h>
#import <Buy/BUYModelManagerProtocol.h>
#import <Buy/BUYObject.h>
#import <Buy/BUYObjectProtocol.h>
#import <Buy/BUYShopifyErrorCodes.h>

// Checkout support
#import <Buy/BUYApplePayAdditions.h>
#import <Buy/BUYApplePayAuthorizationDelegate.h>
#import <Buy/BUYApplePayPaymentProvider.h>
#import <Buy/BUYPaymentController.h>
#import <Buy/BUYPaymentProvider.h>
#import <Buy/BUYWebCheckoutPaymentProvider.h>

// Client API
#import <Buy/BUYClientTypes.h>
#import <Buy/BUYClient.h>
#import <Buy/BUYClient+Address.h>
#import <Buy/BUYClient+Customers.h>
#import <Buy/BUYClient+Checkout.h>
#import <Buy/BUYClient+Storefront.h>

// Foundation extensions
#import <Buy/NSArray+BUYAdditions.h>
#import <Buy/NSDate+BUYAdditions.h>
#import <Buy/NSDateFormatter+BUYAdditions.h>
#import <Buy/NSDecimalNumber+BUYAdditions.h>
#import <Buy/NSDictionary+BUYAdditions.h>
#import <Buy/NSException+BUYAdditions.h>
#import <Buy/NSString+BUYAdditions.h>
#import <Buy/NSURL+BUYAdditions.h>

// Core Data extensions
#import <Buy/NSEntityDescription+BUYAdditions.h>
#import <Buy/NSPropertyDescription+BUYAdditions.h>
#import <Buy/NSRegularExpression+BUYAdditions.h>
