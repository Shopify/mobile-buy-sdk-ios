//
//  BUYProductViewHeaderOverlay.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-05.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
@class BUYTheme;

@interface BUYProductViewHeaderOverlay : UIView

- (instancetype)initWithTheme:(BUYTheme*)theme;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView withNavigationBarHeight:(CGFloat)navigationBarHeight;

@end
