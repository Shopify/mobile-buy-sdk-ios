//
//  BUYFont.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-04.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "UIFont+BUYAdditions.h"

@implementation UIFont (BUYAdditions)

+ (UIFont *)preferredFontForTextStyle:(NSString *)style increasedPointSize:(CGFloat)size
{
	UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
	return [UIFont fontWithDescriptor:descriptor size:descriptor.pointSize + size];
}

@end
