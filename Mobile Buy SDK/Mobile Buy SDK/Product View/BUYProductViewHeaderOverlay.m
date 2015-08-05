//
//  BUYProductViewHeaderOverlay.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-05.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewHeaderOverlay.h"
#import "BUYTheme.h"

@interface BUYProductViewHeaderOverlay ()

@property (nonatomic, strong) UIView *whiteOverlayView;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@end

@implementation BUYProductViewHeaderOverlay

- (instancetype)initWithTheme:(BUYTheme*)theme
{
	self = [super init];
	if (self) {
		self.userInteractionEnabled = NO;
		self.backgroundColor = [UIColor clearColor];
		
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(theme.style == BUYThemeStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight)];
		_visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		_visualEffectView.alpha = 0;
		_visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_visualEffectView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_visualEffectView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_visualEffectView)]];
		
		_whiteOverlayView = [[UIView alloc] init];
		_whiteOverlayView.alpha = 0;
		_whiteOverlayView.backgroundColor = (theme.style == BUYThemeStyleDark) ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
		_whiteOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_whiteOverlayView];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_whiteOverlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_whiteOverlayView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_whiteOverlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_whiteOverlayView)]];
	}
	return self;
}

static CGFloat visualEffectViewThreshold = 200.0f;
static CGFloat whiteOverlayViewThreshold = 100.0f;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView withNavigationBarHeight:(CGFloat)navigationBarHeight
{
	if (scrollView.contentOffset.y > 0) {
		CGFloat opaqueOffset = CGRectGetHeight(self.bounds) - navigationBarHeight;
		
		CGFloat whiteStartingOffset = opaqueOffset - whiteOverlayViewThreshold;
		_whiteOverlayView.alpha = (scrollView.contentOffset.y - whiteStartingOffset) / (opaqueOffset - whiteStartingOffset);
		
		CGFloat blurStartingOffset = opaqueOffset - visualEffectViewThreshold;
		_visualEffectView.alpha = (scrollView.contentOffset.y - blurStartingOffset) / (opaqueOffset - blurStartingOffset);
	} else {
		self.whiteOverlayView.alpha = 0;
		self.visualEffectView.alpha = 0;
	}
}

@end
