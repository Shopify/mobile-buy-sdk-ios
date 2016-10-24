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
#import <BuyTV/BUYAccountCredentials.h>
#import <BuyTV/BUYAddress.h>
#import <BuyTV/BUYCart.h>
#import <BuyTV/BUYCartLineItem.h>
#import <BuyTV/BUYCheckout.h>
#import <BuyTV/BUYCheckoutAttribute.h>
#import <BuyTV/BUYCollection.h>
#import <BuyTV/BUYCreditCard.h>
#import <BuyTV/BUYCustomer.h>
#import <BuyTV/BUYCustomerToken.h>
#import <BuyTV/BUYDiscount.h>
#import <BuyTV/BUYGiftCard.h>
#import <BuyTV/BUYImageLink.h>
#import <BuyTV/BUYLineItem.h>
#import <BuyTV/BUYMaskedCreditCard.h>
#import <BuyTV/BUYOption.h>
#import <BuyTV/BUYOptionValue.h>
#import <BuyTV/BUYOrder.h>
#import <BuyTV/BUYPaymentToken.h>
#import <BuyTV/BUYProduct.h>
#import <BuyTV/BUYProductVariant.h>
#import <BuyTV/BUYShippingRate.h>
#import <BuyTV/BUYShop.h>
#import <BuyTV/BUYTaxLine.h>

// Model support
#import <BuyTV/BUYError.h>
#import <BuyTV/BUYError+BUYAdditions.h>
#import <BuyTV/BUYManagedObject.h>
#import <BuyTV/BUYModelManager.h>
#import <BuyTV/BUYModelManagerProtocol.h>
#import <BuyTV/BUYObject.h>
#import <BuyTV/BUYObjectProtocol.h>
#import <BuyTV/BUYShopifyErrorCodes.h>

// Checkout support
#import <BuyTV/BUYPaymentController.h>
#import <BuyTV/BUYPaymentProvider.h>

// Client API
#import <BuyTV/BUYClientTypes.h>
#import <BuyTV/BUYClient.h>
#import <BuyTV/BUYClient+Address.h>
#import <BuyTV/BUYClient+Customers.h>
#import <BuyTV/BUYClient+Checkout.h>
#import <BuyTV/BUYClient+Storefront.h>

// Foundation extensions
#import <BuyTV/NSArray+BUYAdditions.h>
#import <BuyTV/NSDate+BUYAdditions.h>
#import <BuyTV/NSDateFormatter+BUYAdditions.h>
#import <BuyTV/NSDecimalNumber+BUYAdditions.h>
#import <BuyTV/NSDictionary+BUYAdditions.h>
#import <BuyTV/NSException+BUYAdditions.h>
#import <BuyTV/NSString+BUYAdditions.h>
#import <BuyTV/NSURL+BUYAdditions.h>

// Core Data extensions
#import <BuyTV/NSEntityDescription+BUYAdditions.h>
#import <BuyTV/NSPropertyDescription+BUYAdditions.h>
#import <BuyTV/NSRegularExpression+BUYAdditions.h>
