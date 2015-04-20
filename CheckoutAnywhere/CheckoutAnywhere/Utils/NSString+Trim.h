//
//  NSString+Trim.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Trim)

/**
 * Equivalent to `[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]`
 */
- (NSString*)chk_trim;

@end
