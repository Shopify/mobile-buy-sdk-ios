//
//  NSDecimalNumber+CHKAdditions.h
//  Checkout
//
//  Created by Shopify on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface NSDecimalNumber (CHKAdditions)

+ (NSDecimalNumber*)chk_decimalNumberOrZeroWithString:(NSString*)string;
+ (NSDecimalNumber*)chk_decimalNumberFromJSON:(id)valueFromJSON;

@end
