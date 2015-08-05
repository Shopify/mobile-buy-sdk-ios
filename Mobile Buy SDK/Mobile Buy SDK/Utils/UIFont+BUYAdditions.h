//
//  BUYFont.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-04.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;

@interface UIFont (BUYAdditions)

+ (UIFont *)preferredFontForTextStyle:(NSString *)style increasedPointSize:(CGFloat)size;

@end
