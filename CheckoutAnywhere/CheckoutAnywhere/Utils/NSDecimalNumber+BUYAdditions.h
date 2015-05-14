//
//  NSDecimalNumber+BUYAdditions.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface NSDecimalNumber (BUYAdditions)

+ (NSDecimalNumber*)buy_decimalNumberOrZeroWithString:(NSString*)string;
+ (NSDecimalNumber*)buy_decimalNumberFromJSON:(id)valueFromJSON;

@end
