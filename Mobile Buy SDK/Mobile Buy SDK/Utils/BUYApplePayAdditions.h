//
//  BUYApplePayAdditions.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

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
+ (BUYAddress *)buy_addressFromRecord:(ABRecordRef)record;

@end
