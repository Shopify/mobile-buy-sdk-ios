//
//  ProductImageCell.h
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

#import "ProductImageCell.h"
#import "AsyncImageView.h"

@implementation ProductImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.clipsToBounds = NO;
		self.contentView.clipsToBounds = NO;
		
		self.contentView.backgroundColor = [UIColor clearColor];
		
		_productImageView = [[AsyncImageView alloc] init];
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
	self.clipsToBounds = offset.y >= 0;
	self.productImageViewConstraintBottom.constant = offset.y >= 0 ? offset.y / 2 : 0;
	self.productImageViewConstraintHeight.constant = offset.y >= 0 ? CGRectGetHeight(self.bounds) : CGRectGetHeight(self.bounds) + -offset.y;
	
	self.productImageView.contentMode = UIViewContentModeScaleAspectFit;
	if (self.productImageView.image && [self.productImageView isPortraitOrSquare]) {
		CGFloat imageRatio = self.productImageView.image.size.height / self.productImageView.image.size.width;
		CGFloat imageViewRatio = CGRectGetHeight(self.productImageView.bounds) / CGRectGetWidth(self.productImageView.bounds);
		if (imageViewRatio >= imageRatio && isnan(imageViewRatio) == NO && isinf(imageViewRatio) == NO) {
			self.productImageView.contentMode = UIViewContentModeScaleAspectFill;
		}
	}
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	[self.productImageView cancelImageTask];
	self.productImageView.image = nil;
}

@end
