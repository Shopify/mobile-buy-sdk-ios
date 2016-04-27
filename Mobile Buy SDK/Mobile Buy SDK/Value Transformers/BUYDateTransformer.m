//
//  BUYDateTransformer.m
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

#import "BUYDateTransformer.h"
#import "NSDateFormatter+BUYAdditions.h"

NSString * const BUYDateTransformerName = @"BUYDate";

@interface BUYDateTransformer ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation BUYDateTransformer

- (instancetype)init
{
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	return [self initWithDateFormatter:formatter];
}

- (instancetype)initWithDateFormatter:(NSDateFormatter *)formatter
{
	self = [super init];
	if (self) {
		self.dateFormatter = formatter;
	}
	return self;
}

- (NSString *)transformedValue:(NSDate *)value
{
	return [self.dateFormatter stringFromDate:value];
}

- (NSDate *)reverseTransformedValue:(NSString *)value
{
	return [self.dateFormatter dateFromString:value];
}

+ (instancetype)dateTransformerWithFormat:(NSString *)format
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:format];
	return [[self alloc] initWithDateFormatter:formatter];
}

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

+ (Class)transformedValueClass
{
	return [NSString class];
}

@end
