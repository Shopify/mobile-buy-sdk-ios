//
//  BUYCheckout+Additions.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-01.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCheckout+Additions.h"
#import "BUYAddress+Additions.h"

@implementation BUYCheckout (Additions)

- (NSDictionary *)jsonDictionaryForUpdatingCheckout
{
	NSMutableDictionary *json = [[self jsonDictionaryForCheckout] mutableCopy];
	
	if ([self.shippingAddress isPartialAddress]) {
		json[@"checkout"][@"partial_addresses"] = @YES;
	}
	
	return json;
}

@end
