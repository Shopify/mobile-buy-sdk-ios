//
//  BUYProduct+Options.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYProduct (Options)

/**
 *  Get the option values available for the given option
 *
 *  @param option the option
 *
 *  @return array of BUYOptionValues
 */
- (NSArray *)valuesForOption:(BUYOption *)option variants:(NSArray *)variants;

/**
 *  Determine the variant given an array of options
 *
 *  @param options array of option values
 *
 *  @return the product variant matching the set of options
 */
- (BUYProductVariant *)variantWithOptions:(NSArray *)options;

/**
 *  Get the image for the given variant
 *
 *  @param variant the variant
 *
 *  @return the image for the variant
 */
- (BUYImage *)imageForVariant:(BUYProductVariant *)variant;

/**
 *  Determine if the variant is a default variant automatically created by Shopify
 *
 *  @return YES if its a default variant
 */
- (BOOL)isDefaultVariant;

@end
