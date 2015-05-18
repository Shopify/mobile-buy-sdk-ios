//
//  NSString+Trim.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "NSString+Trim.h"

@implementation NSString (Trim)

- (NSString*)buy_trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
