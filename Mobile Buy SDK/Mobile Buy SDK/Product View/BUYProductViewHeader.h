//
//  BUYProductViewHeader.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYImageView;
@class BUYProductVariant;
@class BUYTheme;
@class BUYProductViewHeaderOverlay;

@interface BUYProductViewHeader : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BUYProductViewHeaderOverlay *productViewHeaderOverlay;

- (instancetype)initWithFrame:(CGRect)frame theme:(BUYTheme*)theme;
- (CGFloat)imageHeightWithScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)setCurrentPage:(NSInteger)currentPage;
- (void)setImageForSelectedVariant:(BUYProductVariant*)productVariant withImages:(NSArray*)images;

@end
