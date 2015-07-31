//
//  BUYProductImageCollectionViewCell.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-31.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductImageCollectionViewCell.h"
#import "BUYImageView.h"

@implementation BUYProductImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.clipsToBounds = NO;
		self.contentView.clipsToBounds = NO;
		
		self.contentView.backgroundColor = [UIColor clearColor];
		
		_productImageView = [[BUYImageView alloc] init];
		_productImageView.clipsToBounds = YES;
		_productImageView.translatesAutoresizingMaskIntoConstraints = NO;
		_productImageView.backgroundColor = [UIColor clearColor];
		_productImageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:_productImageView];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productImageView]|"
																				 options:0
																				 metrics:nil
																				   views:NSDictionaryOfVariableBindings(_productImageView)]];
		
		_productImageViewConstraintBottom = [NSLayoutConstraint constraintWithItem:_productImageView
																		 attribute:NSLayoutAttributeBottom
																		 relatedBy:NSLayoutRelationEqual
																			toItem:self.contentView
																		 attribute:NSLayoutAttributeBottom
																		multiplier:1.0
																		  constant:0.0];
		[self.contentView addConstraint:_productImageViewConstraintBottom];
		
		_productImageViewConstraintHeight = [NSLayoutConstraint constraintWithItem:_productImageView
																		 attribute:NSLayoutAttributeHeight
																		 relatedBy:NSLayoutRelationEqual
																			toItem:nil
																		 attribute:NSLayoutAttributeNotAnAttribute
																		multiplier:1.0
																		  constant:CGRectGetHeight(frame)];
		[self.contentView addConstraint:_productImageViewConstraintHeight];
		
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
