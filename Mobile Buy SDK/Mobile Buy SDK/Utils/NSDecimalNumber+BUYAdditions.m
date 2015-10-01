//
//  NSDecimalNumber+BUYAdditions.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSDecimalNumber+BUYAdditions.h"

@implementation NSDecimalNumber (BUYAdditions)

+ (NSDecimalNumber*)buy_decimalNumberOrZeroWithString:(NSString*)string
{
	NSDecimalNumber *decimalNumber = nil;
	if (string) {
		decimalNumber = [NSDecimalNumber decimalNumberWithString:string];
	}
	
	if (decimalNumber == nil || decimalNumber == [NSDecimalNumber notANumber]) {
		decimalNumber = [NSDecimalNumber zero];
	}
	return decimalNumber;
}

+ (NSDecimalNumber*)buy_decimalNumberFromJSON:(id)valueFromJSON
{
	static NSDecimalNumberHandler *numberHandler;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		numberHandler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:12 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
	});
	
	NSDecimalNumber *decimalNumber = nil;
	if (valueFromJSON == nil || [valueFromJSON isKindOfClass:[NSNull class]]) {
		decimalNumber = nil;
	}
	else if ([valueFromJSON isKindOfClass:[NSString class]]) {
		decimalNumber = [NSDecimalNumber buy_decimalNumberOrZeroWithString:valueFromJSON];
	}
	else if ([valueFromJSON isKindOfClass:[NSDecimalNumber class]]) {
		decimalNumber = valueFromJSON;
	}
	else if ([valueFromJSON isKindOfClass:[NSNumber class]]) {
		NSDecimal decimal = [(NSNumber*)valueFromJSON decimalValue];
		decimalNumber = [NSDecimalNumber decimalNumberWithDecimal:decimal];
	}
	else {
		decimalNumber = nil;
		NSLog(@"Could not create decimal value: %@", valueFromJSON);
	}
	
	return [decimalNumber decimalNumberByRoundingAccordingToBehavior:numberHandler];
}

- (NSDecimalNumber*)buy_decimalNumberAsNegative
{
	return [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES]];
}

@end
