//
//  BUYProductView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYProductViewHeader;
@class BUYProductViewHeaderBackgroundImageView;
@class BUYProductViewFooter;
@class BUYGradientView;
@class BUYTheme;
@class BUYImage;

@interface BUYProductView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *stickyFooterView;
@property (nonatomic, strong) NSLayoutConstraint *footerHeightLayoutConstraint;
@property (nonatomic, strong) NSLayoutConstraint *footerOffsetLayoutConstraint;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewHeaderBackgroundImageView *backgroundImageView;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;
@property (nonatomic, strong) BUYGradientView *topGradientView;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, assign) BOOL hasSetVariantOnCollectionView;

- (instancetype)initWithFrame:(CGRect)rect theme:(BUYTheme*)theme;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
