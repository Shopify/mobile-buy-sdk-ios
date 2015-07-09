//
//  BUYProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeader.h"
#import "BUYImageView.h"

@interface BUYProductViewHeader ()

@property (nonatomic, strong) BUYImageView *backgroundImageView;
@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewConstraintBottom;
@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint *productImageViewConstraintBottom;


@end

@implementation BUYProductViewHeader

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor redColor];
		
		self.backgroundImageView = [[BUYImageView alloc] init];
		self.backgroundImageView.clipsToBounds = YES;
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
		self.backgroundImageView.backgroundColor = [UIColor clearColor];
		self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:self.backgroundImageView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundImageView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_backgroundImageView)]];
		
		self.backgroundImageViewConstraintBottom = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
																				attribute:NSLayoutAttributeBottom
																				relatedBy:NSLayoutRelationEqual
																				   toItem:self
																				attribute:NSLayoutAttributeBottom
																			   multiplier:1.0
																				 constant:0.0];
		[self addConstraint:self.backgroundImageViewConstraintBottom];
		
		self.backgroundImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.backgroundImageView
																		  attribute:NSLayoutAttributeHeight
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:nil
																		  attribute:NSLayoutAttributeNotAnAttribute
																		 multiplier:1.0
																		   constant:0.0];
		[self addConstraint:self.backgroundImageViewConstraint];
		
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
		
	}
	return self;
}

- (void)setContentOffset:(CGPoint)offset
{
	if (offset.y <= 0) {
		self.clipsToBounds = NO;
		if (self.backgroundImageViewConstraintBottom.constant != 0.0) {
			self.backgroundImageViewConstraintBottom.constant = 0.0;
			self.productImageViewConstraintBottom.constant = self.backgroundImageViewConstraintBottom.constant;
		}
		self.backgroundImageViewConstraint.constant = CGRectGetHeight(self.bounds) + -offset.y;
		self.productImageViewConstraint.constant = self.backgroundImageViewConstraint.constant;
	} else {
		self.clipsToBounds = YES;
		if (self.backgroundImageViewConstraint.constant != CGRectGetHeight(self.bounds)) {
			self.backgroundImageViewConstraint.constant = CGRectGetHeight(self.bounds);
			self.productImageViewConstraintBottom.constant = self.backgroundImageViewConstraintBottom.constant;
		}
		self.backgroundImageViewConstraintBottom.constant = offset.y / 2;
		self.productImageViewConstraintBottom.constant = self.backgroundImageViewConstraintBottom.constant;
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
	}
}

@end
