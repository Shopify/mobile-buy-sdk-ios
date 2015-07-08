//
//  BUYProductViewHeader.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeader.h"

@interface BUYProductViewHeader ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSArray *backgroundImageViewConstraints;
@property (nonatomic, strong) UIImageView *productImageView;

@end

@implementation BUYProductViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor redColor];
		
		self.backgroundImageView = [[UIImageView alloc] init];
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
		self.backgroundImageView.backgroundColor = [UIColor blueColor];
		self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:self.backgroundImageView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundImageView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_backgroundImageView)]];
	}
	return self;
}

- (void)setContentOffset:(CGPoint)offset
{
	NSLog(@"%@", NSStringFromCGPoint(offset));
	
	[self removeConstraints:self.backgroundImageViewConstraints];
	self.backgroundImageViewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_backgroundImageView(backgroundImageViewHeight)]|"
																				  options:0
																				  metrics:@{ @"backgroundImageViewHeight" : @(CGRectGetHeight(self.bounds) + -offset.y) }
																					views:NSDictionaryOfVariableBindings(_backgroundImageView)];
	[self addConstraints:self.backgroundImageViewConstraints];
	
}

@end
