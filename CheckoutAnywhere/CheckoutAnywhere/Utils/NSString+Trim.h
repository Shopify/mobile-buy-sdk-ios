//
//  NSString+Trim.h
//  Checkout
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface NSString (Trim)

/**
 * Equivalent to `[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]`
 */
- (NSString*)chk_trim;

@end
