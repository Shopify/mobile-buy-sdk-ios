//
//  BUYProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeader.h"
#import "BUYImageView.h"
#import "BUYGradientView.h"
#import "BUYProductImageCollectionViewCell.h"
#import "BUYImage.h"
#import "BUYProductVariant.h"

@interface BUYProductViewHeader ()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) BUYGradientView *bottomGradientView;
@property (nonatomic, strong) NSLayoutConstraint *bottomGradientViewLayoutConstraintHeight;

@end

@implementation BUYProductViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
		UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
		collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero;
		collectionViewFlowLayout.minimumLineSpacing = 0;
		collectionViewFlowLayout.itemSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
		collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewFlowLayout];
		_collectionView.backgroundColor = [UIColor clearColor];
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.pagingEnabled = YES;
		_collectionView.clipsToBounds = NO;
		_collectionView.translatesAutoresizingMaskIntoConstraints = NO;
		[_collectionView registerClass:[BUYProductImageCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
		[self addSubview:_collectionView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_collectionView)]];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_collectionView)]];
		
		_bottomGradientView = [[BUYGradientView alloc] init];
		_bottomGradientView.topColor = [UIColor clearColor];
		_bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.05f];
		_bottomGradientView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_bottomGradientView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomGradientView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_bottomGradientView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomGradientView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_bottomGradientView)]];
		
		_bottomGradientViewLayoutConstraintHeight = [NSLayoutConstraint constraintWithItem:_bottomGradientView
																				 attribute:NSLayoutAttributeHeight
																				 relatedBy:NSLayoutRelationEqual
																					toItem:nil
																				 attribute:NSLayoutAttributeNotAnAttribute
																				multiplier:1.0
																				  constant:20];
		[self addConstraint:_bottomGradientViewLayoutConstraintHeight];
		
		_pageControl = [[UIPageControl alloc] init];
		_pageControl.hidesForSinglePage = YES;
		_pageControl.translatesAutoresizingMaskIntoConstraints = NO;
		_pageControl.userInteractionEnabled = NO;
		[self addSubview:_pageControl];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
														 attribute:NSLayoutAttributeBottom
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeBottom
														multiplier:1.0
														  constant:0.0]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:nil
														 attribute:NSLayoutAttributeNotAnAttribute
														multiplier:1.0
														  constant:20.0]];
	}
	return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
	self.pageControl.numberOfPages = numberOfPages;
	if (self.pageControl.numberOfPages == 0) {
		self.bottomGradientViewLayoutConstraintHeight.constant = 20;
		self.bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.05f];
	} else {
		self.bottomGradientViewLayoutConstraintHeight.constant = 42;
		self.bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.15f];
	}
}

- (void)setCurrentPage:(NSInteger)currentPage
{
	self.pageControl.currentPage = currentPage;
}

- (CGFloat)imageHeightWithContentOffset:(CGPoint)offset
{
	CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
	CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
	NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
	BUYProductImageCollectionViewCell *cell = (BUYProductImageCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:visibleIndexPath];
	[cell setContentOffset:offset];
	return cell.productImageViewConstraintHeight.constant;
}

- (void)setImageForSelectedVariant:(BUYProductVariant*)productVariant withImages:(NSArray*)images
{
	for (int i = 0; i < [images count]; i++) {
		BUYImage *image = (BUYImage*)images[i];
		for (NSNumber *variantId in image.variantIds) {
			if ([variantId isEqualToNumber:productVariant.identifier]) {
				[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
				[self setCurrentPage:i];
				return;
			}
		}
	}
}

@end
