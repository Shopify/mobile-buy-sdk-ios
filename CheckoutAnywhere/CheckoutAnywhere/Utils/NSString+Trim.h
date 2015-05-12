//
//  NSString+Trim.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

/**
 *  Convenience method for easier white space and newline character trimming
 */
@interface NSString (Trim)

/**
*  Equivalent to `[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]`
*
*  @return NSString without white space and newline characters
*/
- (NSString*)chk_trim;

@end
