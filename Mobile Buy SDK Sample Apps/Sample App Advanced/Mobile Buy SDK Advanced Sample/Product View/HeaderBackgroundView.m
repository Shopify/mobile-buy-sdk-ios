//
//  HeaderBackgroundView.h
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

#import "AsyncImageView.h"
#import "HeaderBackgroundView.h"
#import "VisualEffectView.h"

@interface HeaderBackgroundView ()

@property (nonatomic, strong) AsyncImageView *productImageView;

@end

@implementation HeaderBackgroundView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.productImageView = [[AsyncImageView alloc] init];
		self.productImageView.clipsToBounds = YES;
		self.productImageView.translatesAutoresizingMaskIntoConstraints = NO;
		self.productImageView.backgroundColor = [UIColor clearColor];
		self.productImageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:self.productImageView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.productImageView
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeHeight
														multiplier:1.0
														  constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.productImageView
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
		
		VisualEffectView *visualEffectView = [[VisualEffectView alloc] init];
		visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:visualEffectView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
														 attribute:NSLayoutAttributeHeight
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeHeight
														multiplier:1.0
														  constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
														 attribute:NSLayoutAttributeWidth
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeWidth
														multiplier:1.0
														  constant:0.0]];
	}
	return self;
}

- (void)setBackgroundProductImage:(BUYImageLink *)image
{
	NSURL *url = [image imageURLWithSize:BUYImageURLSize100x100];
	[self.productImageView loadImageWithURL:url animateChange:YES completion:NULL];
}

@end
