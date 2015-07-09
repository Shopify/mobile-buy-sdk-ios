//
//  BUYProduct+Options.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYProduct (Options)

- (NSArray *)valuesForOption:(BUYOption *)option;

- (BUYProductVariant *)variantWithOptions:(NSArray *)options;

- (BUYImage *)imageForVariant:(BUYProductVariant *)variant;

@end
