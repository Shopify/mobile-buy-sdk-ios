//
//  BUYProductViewHeaderBackgroundImageView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-10.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeaderBackgroundImageView.h"
#import "BUYTheme.h"
#import "BUYImageView.h"
#import "BUYImage.h"

@implementation BUYProductViewHeaderBackgroundImageView

- (instancetype)initWithTheme:(BUYTheme*)theme
{
	self = [super init];
	if (self) {
		self.productImageView = [[BUYImageView alloc] init];
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
		
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:theme.style == BUYThemeStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
		UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
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

- (void)setBackgroundProductImage:(BUYImage *)image
{
	NSString *string = [image.src stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", [image.src pathExtension]] withString:[NSString stringWithFormat:@"_small.%@", [image.src pathExtension]]];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", string]];
	[self.productImageView loadImageWithURL:url animateChange:YES completion:NULL];
}

@end
