//
//  BUYAddress+Additions.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-28.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

extern NSString * const BUYPartialAddressPlaceholder;

@interface BUYAddress (Additions)

- (BOOL)isPartialAddress;

- (BOOL)isValidAddressForShippingRates;

@end
