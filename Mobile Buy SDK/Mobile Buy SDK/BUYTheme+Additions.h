//
//  BUYTheme+Additions.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-18.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYTheme.h"

#define BUY_RGB(r, g, b) BUY_RGBA(r, g, b, 1)
#define BUY_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface BUYTheme (Additions)

+ (CGFloat)paddingRed;
+ (CGFloat)paddingPurple;
+ (CGFloat)paddingBlue;

@end
