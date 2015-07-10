//
//  BUYProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYImageView.h"
#import "BUYProductViewHeader.h"

@interface BUYProductViewHeader ()

@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraintBottom;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BUYProductViewHeader

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
				
		self.productImageView = [[BUYImageView alloc] init];
		self.productImageView.clipsToBounds = YES;
		self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
		self.productImageView.backgroundColor = [UIColor clearColor];
		self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.productImageView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productImageView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_productImageView)]];
		
		self.productImageViewConstraintBottom = [NSLayoutConstraint constraintWithItem:self.productImageView
																			 attribute:NSLayoutAttributeBottom
																			 relatedBy:NSLayoutRelationEqual
																				toItem:self
																			 attribute:NSLayoutAttributeBottom
																			multiplier:1.0
																			  constant:0.0];
		[self addConstraint:self.productImageViewConstraintBottom];
		
		self.productImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.productImageView
																	   attribute:NSLayoutAttributeHeight
																	   relatedBy:NSLayoutRelationEqual
																		  toItem:nil
																	   attribute:NSLayoutAttributeNotAnAttribute
																	  multiplier:1.0
																		constant:0.0];
		[self addConstraint:self.productImageViewConstraint];
		
		self.pageControl = [[UIPageControl alloc] init];
		self.pageControl.numberOfPages = 10;
		self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.pageControl];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
														 attribute:NSLayoutAttributeBottom
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeBottom
														multiplier:1.0
														  constant:0.0]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
		
		
	}
	return self;
}

- (void)setContentOffset:(CGPoint)offset
{
	if (offset.y <= 0) {
		self.clipsToBounds = NO;
		if (self.productImageViewConstraintBottom.constant != 0.0) {
			self.productImageViewConstraintBottom.constant = 0.0;
		}
		self.productImageViewConstraint.constant = CGRectGetHeight(self.bounds) + -offset.y;
	} else {
		self.clipsToBounds = YES;
		if (self.productImageViewConstraint.constant != CGRectGetHeight(self.bounds)) {
			self.productImageViewConstraint.constant = CGRectGetHeight(self.bounds);
		}
		self.productImageViewConstraintBottom.constant = offset.y / 2;
	}
	
	// change the image content mode on portrait (or 1:1) images so they zoom-scale on scrollview over-pulls
	if (self.productImageView.image.size.height >= self.productImageView.image.size.width) {
		CGFloat imageRatio = self.productImageView.image.size.height / self.productImageView.image.size.width;
		CGFloat imageViewRatio = CGRectGetHeight(self.productImageView.bounds) / CGRectGetWidth(self.productImageView.bounds);
		if (imageViewRatio >= imageRatio || isnan(imageViewRatio)) {
			self.productImageView.contentMode = UIViewContentModeScaleAspectFill;
		} else {
			self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
		}
	} else {
		self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
	}
}

@end
