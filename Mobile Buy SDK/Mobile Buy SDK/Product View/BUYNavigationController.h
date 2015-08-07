//
//  BUYNavigationController.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

@interface BUYNavigationController : UINavigationController <BUYThemeable>

- (void)updateCloseButtonImageWithDarkStyle:(BOOL)darkStyle;

@end
