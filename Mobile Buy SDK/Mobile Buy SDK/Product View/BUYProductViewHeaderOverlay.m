//
//  BUYProductViewHeaderOverlay.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-05.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeaderOverlay.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"

@interface BUYProductViewHeaderOverlay ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIView *visualEffectContainerView;

@end

@implementation BUYProductViewHeaderOverlay

- (instancetype)initWithTheme:(BUYTheme*)theme
{
	self = [super init];
	if (self) {
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		
		_visualEffectContainerView = [[UIView alloc] init];
		_visualEffectContainerView.translatesAutoresizingMaskIntoConstraints = NO;
		_visualEffectContainerView.alpha = 0;
		[self addSubview:_visualEffectContainerView];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_visualEffectContainerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_visualEffectContainerView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_visualEffectContainerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_visualEffectContainerView)]];
		
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(theme.style == BUYThemeStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight)];
		UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[_visualEffectContainerView addSubview:visualEffectView];
		
		[_visualEffectContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(visualEffectView)]];
		[_visualEffectContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(visualEffectView)]];
		
		_overlayView = [[UIView alloc] init];
		_overlayView.alpha = 0;
		_overlayView.backgroundColor = (theme.style == BUYThemeStyleDark) ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
		_overlayView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_overlayView];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_overlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_overlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
	}
	return self;
}

static CGFloat visualEffectViewThreshold = 200.0f;
static CGFloat overlayViewThreshold = 100.0f;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView withNavigationBarHeight:(CGFloat)navigationBarHeight
{
	if (scrollView.contentOffset.y > 0) {
		CGFloat opaqueOffset = CGRectGetHeight(self.bounds) - navigationBarHeight;
		
		CGFloat overlayStartingOffset = opaqueOffset - overlayViewThreshold;
		self.overlayView.alpha = (scrollView.contentOffset.y - overlayStartingOffset) / (opaqueOffset - overlayStartingOffset);
		
		CGFloat blurStartingOffset = opaqueOffset - visualEffectViewThreshold;
		self.visualEffectContainerView.alpha = (scrollView.contentOffset.y - blurStartingOffset) / (opaqueOffset - blurStartingOffset);
	} else {
		self.overlayView.alpha = 0;
		self.visualEffectContainerView.alpha = 0;
	}
}

@end
