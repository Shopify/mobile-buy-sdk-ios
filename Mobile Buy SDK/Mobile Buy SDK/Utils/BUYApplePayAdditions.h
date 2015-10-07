//
//  BUYApplePayAdditions.h
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

@import Foundation;
@import PassKit;

#import "BUYCheckout.h"
#import "BUYShippingRate.h"
#import "BUYAddress.h"

@interface BUYCheckout (ApplePay)

/**
 *  Returns an array of summary items for all Apple Pay requests.  Will use 'PAY TOTAL' as the summary label.  Apple recommends
 *  including the business name in the summary label, so it is recommended to use `buy_summaryItemsWithShopName` instead.
 */
- (nonnull NSArray<PKPaymentSummaryItem *> *)buy_summaryItems;

/**
 *  Returns an array of summary items for all Apple Pay requests using the shop name in the "PAY" section
 *
 *  @param shopName the shops name
 *
 *  @return An array of PKPaymentSummaryItems
 */
- (nonnull NSArray<PKPaymentSummaryItem *> *)buy_summaryItemsWithShopName:(nullable NSString *)shopName;

@end

@interface BUYShippingRate (ApplePay)

/**
*  Returns an array of `PKShippingMethod` objects, based on Shopify's shipping rates.
*
*  @param rates Shipping rates
*
*  @return An array of PKShippingMethods
*/
+ (nonnull NSArray<PKShippingMethod *> *)buy_convertShippingRatesToShippingMethods:(nonnull NSArray<BUYShippingRate *> *)rates;

@end

@interface BUYAddress (ApplePay)

+ (nullable NSString *)buy_emailFromRecord:(nullable ABRecordRef)record;

/**
 *  Creates a BUYAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a BUYAddress from
 *
 *  @return The BUYAddress created from an ABRecordRef
 */
+ (nonnull BUYAddress *)buy_addressFromRecord:(nullable ABRecordRef)record NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `buy_addressFromContact:` instead");

/**
 *  Creates a BUYAddress from a PKContact
 *
 *  @param contact PKContact to create a BUYAddress from
 *
 *  @return The BUYAddress created from a PKContact
 */
+ (nonnull BUYAddress *)buy_addressFromContact:(nullable PKContact*)contact NS_AVAILABLE_IOS(9_0);

@end
