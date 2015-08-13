//
//  BUYProductViewErrorView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-13.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUYProductViewErrorView : UIView

@property (nonatomic, strong) UILabel *errorLabel;
@property (nonatomic, strong) NSLayoutConstraint *hiddenConstraint;
@property (nonatomic, strong) NSLayoutConstraint *visibleConstraint;

@end
