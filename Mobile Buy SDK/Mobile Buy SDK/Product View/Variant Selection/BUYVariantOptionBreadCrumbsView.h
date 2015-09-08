//
//  BUYVariantOptionBreadCrumbsView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-03.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUYVariantOptionBreadCrumbsView : UIView

@property (nonatomic, strong) NSLayoutConstraint *breadcrumbsHiddenConstraint;
@property (nonatomic, strong) NSLayoutConstraint *breadcrumbsVisibleConstraint;

- (void)setSelectedBuyOptionValues:(NSArray*)optionValues;

@end
