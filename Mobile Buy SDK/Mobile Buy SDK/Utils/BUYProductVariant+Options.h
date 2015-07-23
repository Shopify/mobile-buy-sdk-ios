//
//  BUYProductVariant+Options.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYProductVariant (Options)

/**
 *  Returns the option value for the given name
 *
 *  @param optionName name of the option
 *
 *  @return the option value
 */
- (BUYOptionValue *)optionValueForName:(NSString *)optionName;

@end
