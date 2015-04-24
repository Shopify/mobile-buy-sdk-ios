//
//  NSString+Trim.m
//  Checkout
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString*)chk_trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
