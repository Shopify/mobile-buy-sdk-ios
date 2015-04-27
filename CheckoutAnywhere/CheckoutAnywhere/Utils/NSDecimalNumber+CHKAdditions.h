//
//  NSDecimalNumber+CHKAdditions.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface NSDecimalNumber (CHKAdditions)

+ (NSDecimalNumber*)chk_decimalNumberOrZeroWithString:(NSString*)string;
+ (NSDecimalNumber*)chk_decimalNumberFromJSON:(id)valueFromJSON;

@end
