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

@interface BUYProductViewHeader ()

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) BUYGradientView *bottomGradientView;
@property (nonatomic, strong) NSLayoutConstraint *bottomGradientViewLayoutConstraintHeight;

@end

@implementation BUYProductViewHeader

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
		_productImageView = [[BUYImageView alloc] init];
		_productImageView.clipsToBounds = YES;
		_productImageView.translatesAutoresizingMaskIntoConstraints = NO;
		_productImageView.backgroundColor = [UIColor clearColor];
		_productImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_productImageView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productImageView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_productImageView)]];
		
		self.productImageViewConstraintBottom = [NSLayoutConstraint constraintWithItem:_productImageView
																			 attribute:NSLayoutAttributeBottom
																			 relatedBy:NSLayoutRelationEqual
																				toItem:self
																			 attribute:NSLayoutAttributeBottom
																			multiplier:1.0
																			  constant:0.0];
		[self addConstraint:self.productImageViewConstraintBottom];
		
		_productImageViewConstraintHeight = [NSLayoutConstraint constraintWithItem:_productImageView
																		 attribute:NSLayoutAttributeHeight
																		 relatedBy:NSLayoutRelationEqual
																			toItem:nil
																		 attribute:NSLayoutAttributeNotAnAttribute
																		multiplier:1.0
																		  constant:0.0];
		[self addConstraint:_productImageViewConstraintHeight];
		
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

- (void)setContentOffset:(CGPoint)offset
{
	if (offset.y <= 0) {
		self.clipsToBounds = NO;
		if (self.productImageViewConstraintBottom.constant != 0.0) {
			self.productImageViewConstraintBottom.constant = 0.0;
		}
		self.productImageViewConstraintHeight.constant = CGRectGetHeight(self.bounds) + -offset.y;
	} else {
		self.clipsToBounds = YES;
		if (self.productImageViewConstraintHeight.constant != CGRectGetHeight(self.bounds)) {
			self.productImageViewConstraintHeight.constant = CGRectGetHeight(self.bounds);
		}
		self.productImageViewConstraintBottom.constant = offset.y / 2;
	}
	
	// change the image content mode on portrait (or 1:1) images so they zoom-scale on scrollview over-pulls
	if (self.productImageView.image && self.productImageView.image.size.height >= self.productImageView.image.size.width) {
		CGFloat imageRatio = self.productImageView.image.size.height / self.productImageView.image.size.width;
		CGFloat imageViewRatio = CGRectGetHeight(self.productImageView.bounds) / CGRectGetWidth(self.productImageView.bounds);
		if (imageViewRatio >= imageRatio && isnan(imageViewRatio) == NO && isinf(imageViewRatio) == NO) {
			self.productImageView.contentMode = UIViewContentModeScaleAspectFill;
		} else {
			self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
		}
	} else {
		self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
	}
}

@end
