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
- (NSArray *)summaryItems;

@end

@interface CHKShippingRate (ApplePay)

/**
 * Returns an array of `PKShippingMethod` objects, based on Shopify's shipping rates.
 */
+ (NSArray *)convertShippingRatesToShippingMethods:(NSArray *)rates;

@end

@interface CHKAddress (ApplePay)

+ (NSString *)emailFromRecord:(ABRecordRef)record;

/**
 * Creates a CHKAddress, usable with the Shopify Checkout API
 */
+ (CHKAddress *)addressFromRecord:(ABRecordRef)record;

@end