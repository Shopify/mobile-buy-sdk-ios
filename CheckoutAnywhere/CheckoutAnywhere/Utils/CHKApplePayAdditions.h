//
//  CHKApplePayAdditions.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKCheckout.h"

@interface CHKCheckout (ApplePay)

/**
 *  Returns an array of summary items for all ApplePay requests
 */
- (NSArray *)chk_summaryItems;

@end

@interface CHKShippingRate (ApplePay)

/**
*  Returns an array of `PKShippingMethod` objects, based on Shopify's shipping rates.
*
*  @param rates Shipping rates
*
*  @return An array of PKShippingMethods
*/
+ (NSArray *)chk_convertShippingRatesToShippingMethods:(NSArray *)rates;

@end

@interface CHKAddress (ApplePay)

+ (NSString *)chk_emailFromRecord:(ABRecordRef)record;

/**
 *  Creates a CHKAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a CHKAddress from
 *
 *  @return The CHKAddress created from an ABRecordRef
 */
+ (CHKAddress *)chk_addressFromRecord:(ABRecordRef)record;

@end