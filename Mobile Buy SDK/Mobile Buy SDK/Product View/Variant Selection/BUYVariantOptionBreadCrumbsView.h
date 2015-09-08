//
//  BUYVariantOptionBreadCrumbsView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-03.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
#import "BUYTheme.h"

@interface BUYVariantOptionBreadCrumbsView : UIView <BUYThemeable>

@property (nonatomic, strong) NSLayoutConstraint *hiddenConstraint;
@property (nonatomic, strong) NSLayoutConstraint *visibleConstraint;

- (void)setSelectedBuyOptionValues:(NSArray*)optionValues;

@end
