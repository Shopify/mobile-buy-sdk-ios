//
//  _BUYProduct.m
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

#import "BUYProduct.h"
#import "BUYModelManager.h"
#import "BUYOption.h"
#import "BUYOptionValue.h"
#import "BUYProductVariant.h"
#import "NSString+BUYAdditions.h"

@implementation BUYProduct

@synthesize stringDescription=_stringDescription;

- (NSDate *)createdAtDate
{
	return self.createdAt;
}

- (NSDate *)updatedAtDate
{
	return self.updatedAt;
}

- (NSDate *)publishedAtDate
{
	return self.publishedAt;
}

- (NSString *)stringDescription
{
	if (nil == _stringDescription) {
		_stringDescription = [self.htmlDescription buy_stringByStrippingHTML];
	}
	return _stringDescription;
}

- (NSArray<BUYImageLink *> *)imagesArray
{
	return self.images.array ?: @[];
}

- (NSArray<BUYOption *> *)optionsArray
{
	return self.options.array ?: @[];
}

- (NSArray<BUYProductVariant *> *)variantsArray
{
	return self.variants.array ?: @[];
}

@end

@implementation BUYProduct (Options)

- (NSArray *)valuesForOption:(BUYOption *)option variants:(NSArray *)variants
{
	NSMutableOrderedSet *set = [NSMutableOrderedSet new];
	
	for (BUYProductVariant *variant in variants) {
		BUYOptionValue *optionValue = [variant optionValueForName:option.name];
		[set addObject:optionValue];
	}
	
	return [set array];
}

- (BUYProductVariant *)variantWithOptions:(NSArray *)options
{
	BUYProductVariant *variant = nil;
	
	for (BUYProductVariant *aVariant in self.variants) {
		
		BOOL match = YES;
		
		for (BUYOptionValue *value in options) {
			
			BUYOptionValue *optionValue = [aVariant optionValueForName:value.name];
			if (![optionValue isEqual:value]) {
				match = NO;
				break;
			}
		}
		
		if (match) {
			variant = aVariant;
		}
	}
	
	return variant;
}

- (BOOL)isDefaultVariant
{
	if ([self.variants count] == 1) {
		BUYProductVariant *productVariant = [self.variants firstObject];
		BUYOptionValue *optionValue = [productVariant.options anyObject];
		NSString *defaultTitleString = @"Default Title";
		NSString *defaultString = @"Default";
		if ([productVariant.title isEqualToString:defaultTitleString] &&
			([optionValue.value isEqualToString:defaultTitleString] || [optionValue.value isEqualToString:defaultString])) {
			return YES;
		}
	}
	return NO;
}

@end
