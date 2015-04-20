//
//  CHKApplePayAdditions.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2015-02-11.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKCheckout.h"

@interface CHKCheckout (ApplePay)

/**
 * Returns an array of summary items for all ApplePay requests
 */
- (NSArray *)chk_summaryItems;

@end

@interface CHKShippingRate (ApplePay)

/**
 * Returns an array of `PKShippingMethod` objects, based on Shopify's shipping rates.
 */
+ (NSArray *)chk_convertShippingRatesToShippingMethods:(NSArray *)rates;

@end

@interface CHKAddress (ApplePay)

+ (NSString *)chk_emailFromRecord:(ABRecordRef)record;

/**
 * Creates a CHKAddress, usable with the Shopify Checkout API
 */
+ (CHKAddress *)chk_addressFromRecord:(ABRecordRef)record;

@end