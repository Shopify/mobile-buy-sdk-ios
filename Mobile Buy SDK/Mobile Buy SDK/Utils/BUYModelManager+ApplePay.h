//
//  BUYModelManager+ApplePay.h
//  Mobile Buy SDK
//
//  Created by Gabriel O'Flaherty-Chan on 2016-05-20.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <Buy/BUYModelManager.h>
@import PassKit;

@class BUYAddress;

@interface BUYModelManager (ApplePay)

/**
 *  Creates a BUYAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a BUYAddress from
 *
 *  @return The BUYAddress created from an ABRecordRef
 */
- (BUYAddress *)buyAddressWithABRecord:(ABRecordRef)addressRecord NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `buyAddressWithContact:` instead");

/**
 *  Creates a BUYAddress from a PKContact
 *
 *  @param contact PKContact to create a BUYAddress from
 *
 *  @return The BUYAddress created from a PKContact
 */
- (BUYAddress *)buyAddressWithContact:(PKContact *)contact NS_AVAILABLE_IOS(9_0);

@end