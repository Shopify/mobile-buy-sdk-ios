//
//  BUYProduct+Options.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProduct+Options.h"

@implementation BUYProduct (Options)

- (NSArray *)valuesForOption:(BUYOption *)option
{
	NSMutableOrderedSet *set = [NSMutableOrderedSet new];
	
	for (BUYProductVariant *variant in self.variants) {
		
		BUYOptionValue *optionValue = variant.options[option.name];
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
			
			if (![aVariant.options[value.name] isEqual:value]) {
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

- (BUYImage *)imageForVariant:(BUYProductVariant *)variant
{
	BUYImage *image = nil;
	
	for (BUYImage *anImage in self.images) {
		if ([anImage.variantIds containsObject:variant.identifier]) {
			image = anImage;
		}
	}
	
	return image;
}


@end
