//
//  BUYModelManager+ApplePay.m
//  Mobile Buy SDK
//
//  Created by Gabriel O'Flaherty-Chan on 2016-05-20.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYAddress.h"
#import "BUYApplePayAdditions.h"
#import "BUYModelManager+ApplePay.h"

@implementation BUYModelManager (ApplePay)

- (BUYAddress *)buyAddressWithABRecord:(ABRecordRef)addressRecord
{
	BUYAddress *address = [self insertAddressWithJSONDictionary:nil];
	[address updateWithRecord:addressRecord];
	return address;
}

- (BUYAddress *)buyAddressWithContact:(PKContact *)contact
{
	BUYAddress *address = [self insertAddressWithJSONDictionary:nil];
	[address updateWithContact:contact];
	return address;
}

@end
