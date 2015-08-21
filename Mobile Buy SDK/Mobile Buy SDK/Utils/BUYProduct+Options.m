//
//  BUYProduct+Options.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProduct+Options.h"
#import "BUYProductVariant+Options.h"

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
		if ([productVariant.title isEqualToString:@"Default Title"]) {
			return YES;
		}
	}
	return NO;
}

@end
