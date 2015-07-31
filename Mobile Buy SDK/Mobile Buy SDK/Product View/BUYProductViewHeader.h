//
//  BUYProductViewHeader.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYImageView;

@interface BUYProductViewHeader : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

- (CGFloat)imageHeightWithContentOffset:(CGPoint)offset;
- (void)setNumberOfPages:(NSInteger)numberOfPages;
- (void)setCurrentPage:(NSInteger)currentPage;

@end
