//
//  BUYError.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYError.h"

NSString * const BUYShopifyError = @"BUYShopifyError";

@implementation BUYError

- (NSString *)description
{
	return [[self userInfo] description];
}

@end
