//
//  NSString+Trim.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface NSString (Trim)

/**
 * Equivalent to `[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]`
 */
- (NSString*)chk_trim;

@end
