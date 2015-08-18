//
//  BUYNavigationTitleView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-18.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
#import "BUYTheme.h"
#import "BUYOption.h"

@interface BUYNavigationTitleView : UIView <BUYThemeable>

- (void)setTitleWithBuyOption:(BUYOption*)buyOption selectedBuyOptionValues:(NSArray*)selectedBuyOptions;

@end
