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
#import "BUYAccountCredentials.h"
#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCartLineItem.h"
#import "BUYCheckout.h"
#import "BUYCheckoutAttribute.h"
#import "BUYCollection.h"
#import "BUYCreditCard.h"
#import "BUYCustomer.h"
#import "BUYCustomerToken.h"
#import "BUYDiscount.h"
#import "BUYGiftCard.h"
#import "BUYImageLink.h"
#import "BUYLineItem.h"
#import "BUYMaskedCreditCard.h"
#import "BUYOption.h"
#import "BUYOptionValue.h"
#import "BUYOrder.h"
#import "BUYPaymentToken.h"
#import "BUYProduct.h"
#import "BUYProductVariant.h"
#import "BUYShippingRate.h"
#import "BUYShop.h"
#import "BUYTaxLine.h"

// Model support
#import "BUYError.h"
#import "BUYError+BUYAdditions.h"
#import "BUYManagedObject.h"
#import "BUYModelManager.h"
#import "BUYModelManagerProtocol.h"
#import "BUYObject.h"
#import "BUYObjectProtocol.h"
#import "BUYShopifyErrorCodes.h"

// Checkout support
#import "BUYPaymentController.h"
#import "BUYPaymentProvider.h"

#if !TARGET_OS_TV
#import "BUYApplePayAdditions.h"
#import "BUYApplePayAuthorizationDelegate.h"
#import "BUYApplePayPaymentProvider.h"
#endif

#if TARGET_OS_IOS
#import "BUYWebCheckoutPaymentProvider.h"
#endif

// Client API
#import "BUYClientTypes.h"
#import "BUYClient.h"
#import "BUYClient+Address.h"
#import "BUYClient+Customers.h"
#import "BUYClient+Checkout.h"
#import "BUYClient+Storefront.h"

// Foundation extensions
#import "NSArray+BUYAdditions.h"
#import "NSDate+BUYAdditions.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSDictionary+BUYAdditions.h"
#import "NSException+BUYAdditions.h"
#import "NSString+BUYAdditions.h"
#import "NSURL+BUYAdditions.h"

// Core Data extensions
#import "NSEntityDescription+BUYAdditions.h"
#import "NSPropertyDescription+BUYAdditions.h"
#import "NSRegularExpression+BUYAdditions.h"
