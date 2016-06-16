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

@interface NSObject (BUYDecimalCreating)
@property (nonatomic, readonly, getter=buy_decimalNumber) NSDecimalNumber *decimalNumber;
@end

@implementation NSDecimalNumber (BUYAdditions)

+ (NSDecimalNumber*)buy_decimalNumberFromJSON:(id)valueFromJSON
{
	static NSDecimalNumberHandler *numberHandler;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		numberHandler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundBankers scale:12 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
	});
	
	return [[valueFromJSON buy_decimalNumber] decimalNumberByRoundingAccordingToBehavior:numberHandler];
}

- (NSDecimalNumber*)buy_decimalNumberAsNegative
{
	return [self decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:YES]];
}

@end

#pragma mark -

@implementation NSObject (BUYDecimalCreating)

- (NSDecimalNumber *)buy_decimalNumber
{
	return nil;
}

@end

@implementation NSString (BUYDecimalCreating)

- (NSDecimalNumber *)buy_decimalNumber
{
	return [NSDecimalNumber decimalNumberWithString:self];
}

@end

@implementation NSNumber (BUYDecimalCreating)

- (NSDecimalNumber *)buy_decimalNumber
{
	return [NSDecimalNumber decimalNumberWithDecimal:[self decimalValue]];
}

@end

@implementation NSDecimalNumber (BUYDecimalCreating)

- (NSDecimalNumber *)buy_decimalNumber
{
	return self;
}

@end
