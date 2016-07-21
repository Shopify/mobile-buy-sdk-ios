//
//  HeaderOverlayView.m
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

#import "HeaderOverlayView.h"
#import "VisualEffectView.h"

@interface HeaderOverlayView ()

@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) UIView *visualEffectContainerView;

@end

@implementation HeaderOverlayView

- (instancetype)init
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
		
		VisualEffectView *visualEffectView = [[VisualEffectView alloc] init];
		visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[_visualEffectContainerView addSubview:visualEffectView];
		
		[_visualEffectContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(visualEffectView)]];
		[_visualEffectContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visualEffectView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(visualEffectView)]];
		
		_overlayView = [[UIView alloc] init];
		_overlayView.alpha = 0;
		_overlayView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:_overlayView];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_overlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_overlayView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
	}
	return self;
}

-(void)setOverlayBackgroundColor:(UIColor *)overlayBackgroundColor
{
	_overlayView.backgroundColor = overlayBackgroundColor;
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
