//
//  ProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ProductViewHeader.h"
#import "AsyncImageView.h"
#import "GradientView.h"
#import "ProductImageCell.h"
#import "Theme+Additions.h"
#import "HeaderOverlayView.h"

@interface ProductViewHeader ()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *bottomGradientContainerView;
@property (nonatomic, strong) GradientView *bottomGradientView;
@property (nonatomic, strong) NSLayoutConstraint *bottomGradientViewLayoutConstraintHeight;
@property (nonatomic, strong) NSLayoutConstraint *bottomGradientViewBottomContraint;

@end

@implementation ProductViewHeader

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
		[_collectionView registerClass:[ProductImageCell class] forCellWithReuseIdentifier:@"Cell"];
		[self addSubview:_collectionView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_collectionView)]];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_collectionView)]];
		
		_bottomGradientContainerView = [[UIView alloc] init];
		_bottomGradientContainerView.backgroundColor = [UIColor clearColor];
		_bottomGradientContainerView.translatesAutoresizingMaskIntoConstraints = NO;
		_bottomGradientContainerView.clipsToBounds = YES;
		[self addSubview:_bottomGradientContainerView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomGradientContainerView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_bottomGradientContainerView)]];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomGradientContainerView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_bottomGradientContainerView)]];
		
		_bottomGradientViewLayoutConstraintHeight = [NSLayoutConstraint constraintWithItem:_bottomGradientContainerView
																				 attribute:NSLayoutAttributeHeight
																				 relatedBy:NSLayoutRelationEqual
																					toItem:nil
																				 attribute:NSLayoutAttributeNotAnAttribute
																				multiplier:1.0
																				  constant:kBuyBottomGradientHeightWithoutPageControl];
		[self addConstraint:_bottomGradientViewLayoutConstraintHeight];
		
		_bottomGradientView = [[GradientView alloc] init];
		_bottomGradientView.userInteractionEnabled = NO;
		_bottomGradientView.topColor = [UIColor clearColor];
		_bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.05f];
		_bottomGradientView.translatesAutoresizingMaskIntoConstraints = NO;
		[_bottomGradientContainerView addSubview:_bottomGradientView];
		
		[_bottomGradientContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomGradientView]|"
																							 options:0
																							 metrics:nil
																							   views:NSDictionaryOfVariableBindings(_bottomGradientView)]];
		
		[_bottomGradientContainerView addConstraint:[NSLayoutConstraint constraintWithItem:_bottomGradientView
																				 attribute:NSLayoutAttributeHeight
																				 relatedBy:NSLayoutRelationEqual
																					toItem:_bottomGradientContainerView
																				 attribute:NSLayoutAttributeHeight
																				multiplier:1.0
																				  constant:0.0]];
		
		_bottomGradientViewBottomContraint = [NSLayoutConstraint constraintWithItem:_bottomGradientView
																		  attribute:NSLayoutAttributeBottom
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:_bottomGradientContainerView
																		  attribute:NSLayoutAttributeBottom
																		 multiplier:1.0
																		   constant:0.0];
		[_bottomGradientContainerView addConstraint:_bottomGradientViewBottomContraint];
		
		_pageControl = [[UIPageControl alloc] init];
		_pageControl.hidesForSinglePage = YES;
		_pageControl.translatesAutoresizingMaskIntoConstraints = NO;
		_pageControl.userInteractionEnabled = NO;
		[_bottomGradientView addSubview:_pageControl];
		
		[_bottomGradientView addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
																   attribute:NSLayoutAttributeBottom
																   relatedBy:NSLayoutRelationEqual
																	  toItem:_bottomGradientView
																   attribute:NSLayoutAttributeBottom
																  multiplier:1.0
																	constant:0.0]];
		
		[_bottomGradientView addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
																		attribute:NSLayoutAttributeWidth
																		relatedBy:NSLayoutRelationEqual
																		   toItem:_bottomGradientView
																		attribute:NSLayoutAttributeWidth
																	   multiplier:1.0
																		 constant:0.0]];
		
		[_bottomGradientView addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
																		attribute:NSLayoutAttributeHeight
																		relatedBy:NSLayoutRelationEqual
																		   toItem:nil
																		attribute:NSLayoutAttributeNotAnAttribute
																	   multiplier:1.0
																		 constant:kBuyPageControlHeight]];
		
		_productViewHeaderOverlay = [[HeaderOverlayView alloc] init];
		_productViewHeaderOverlay.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_productViewHeaderOverlay];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_productViewHeaderOverlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productViewHeaderOverlay)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewHeaderOverlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productViewHeaderOverlay)]];
	}
	return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
	self.pageControl.numberOfPages = numberOfPages;
	if (self.pageControl.numberOfPages == 0) {
		self.bottomGradientViewLayoutConstraintHeight.constant = kBuyBottomGradientHeightWithoutPageControl;
		self.bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.05f];
	} else {
		self.bottomGradientViewLayoutConstraintHeight.constant = kBuyBottomGradientHeightWithPageControl;
		self.bottomGradientView.bottomColor = [UIColor colorWithWhite:0 alpha:0.15f];
	}
}

- (void)setCurrentPage:(NSInteger)currentPage
{
	self.pageControl.currentPage = currentPage;
}

- (CGFloat)imageHeightWithScrollViewDidScroll:(UIScrollView *)scrollView
{
	self.bottomGradientViewBottomContraint.constant = MAX(scrollView.contentOffset.y / 4, 0);
	CGRect visibleRect = (CGRect){.origin = self.collectionView.contentOffset, .size = self.collectionView.bounds.size};
	CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
	NSIndexPath *visibleIndexPath = [self.collectionView indexPathForItemAtPoint:visiblePoint];
	ProductImageCell *cell = (ProductImageCell*)[self.collectionView cellForItemAtIndexPath:visibleIndexPath];
	if (cell) {
		[cell setContentOffset:scrollView.contentOffset];
		return cell.productImageViewConstraintHeight.constant;
	} else {
		cell = [self.collectionView.visibleCells firstObject];
		return cell.productImageViewConstraintHeight.constant;
	}
}

- (void)setImageForSelectedVariant:(BUYProductVariant*)productVariant withImages:(NSArray*)images
{
	[self setNumberOfPages:[images count]];
	if (CGSizeEqualToSize(self.collectionView.contentSize, CGSizeZero) == NO) {
		[images enumerateObjectsUsingBlock:^(BUYImageLink *image, NSUInteger i, BOOL *stop) {
			for (NSNumber *variantId in image.variantIds) {
				if ([variantId isEqualToNumber:productVariant.identifier]) {
					[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
					self.pageControl.currentPage = i;
					*stop = YES;
					break;
				}
			}
		}];
	}
}

@end
