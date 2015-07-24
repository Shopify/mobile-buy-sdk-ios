//
//  BUYProductViewHeaderBackgroundImageView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-10.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYImageView;
@class BUYTheme;

@interface BUYProductViewHeaderBackgroundImageView : UIView

@property (nonatomic, strong) BUYImageView *productImageView;

- (instancetype)initWithTheme:(BUYTheme*)theme;

@end
