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
 *  Returns an array of summary items for all ApplePay requests
 */
- (NSArray *)buy_summaryItems;

@end

@interface BUYShippingRate (ApplePay)

/**
*  Returns an array of `PKShippingMethod` objects, based on Shopify's shipping rates.
*
*  @param rates Shipping rates
*
*  @return An array of PKShippingMethods
*/
+ (NSArray *)buy_convertShippingRatesToShippingMethods:(NSArray *)rates;

@end

@interface BUYAddress (ApplePay)

+ (NSString *)buy_emailFromRecord:(ABRecordRef)record;

/**
 *  Creates a BUYAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a BUYAddress from
 *
 *  @return The BUYAddress created from an ABRecordRef
 */
+ (BUYAddress *)buy_addressFromRecord:(ABRecordRef)record NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `buy_addressFromContact:` instead");

/**
 *  Creates a BUYAddress from a PKContact
 *
 *  @param contact PKContact to create a BUYAddress from
 *
 *  @return The BUYAddress created from a PKContact
 */
+ (BUYAddress *)buy_addressFromContact:(PKContact*)contact NS_AVAILABLE_IOS(9_0);

@end
