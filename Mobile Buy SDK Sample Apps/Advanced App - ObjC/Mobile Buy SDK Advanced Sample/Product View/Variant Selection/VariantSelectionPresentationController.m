//
//  VariantSelectionPresentationController.m
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

#import "VariantSelectionPresentationController.h"

@implementation VariantSelectionPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
	
	if (self) {
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		self.backgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
	}
	
    return self;
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
	
	// Place the blur view inside a container view so it can be animated without warning
	UIView *blurContainer = [[UIView alloc] init];
	blurContainer.translatesAutoresizingMaskIntoConstraints = NO;
	blurContainer.alpha = 0.0;
	[blurContainer addSubview:self.backgroundView];
	[self.containerView insertSubview:blurContainer atIndex:0];

	NSDictionary *views = NSDictionaryOfVariableBindings(blurContainer, _backgroundView);
	
	[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[blurContainer]|" options:0 metrics:nil views:views]];
	[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[blurContainer]|" options:0 metrics:nil views:views]];
	[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backgroundView]|" options:0 metrics:nil views:views]];
	[self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backgroundView]|" options:0 metrics:nil views:views]];
	
	[self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		blurContainer.alpha = 1.0;
	} completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    [super dismissalTransitionWillBegin];
	
	[self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		self.backgroundView.superview.alpha = 0.0;
	} completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[self.backgroundView removeFromSuperview];
	}];
}

CGFloat const BUYPresentationControllerPartialHeight = 350.0f;
CGFloat const BUYPresentationControllerPartialWidth = 350.0f;

- (CGRect)frameOfPresentedViewInContainerView
{
	CGFloat height = MIN((CGRectGetHeight(self.containerView.bounds) / 2.0f), BUYPresentationControllerPartialHeight);
	CGFloat width = MIN((CGRectGetWidth(self.containerView.bounds) / 1.3f), BUYPresentationControllerPartialWidth);
	return CGRectIntegral(CGRectMake(CGRectGetMidX(self.containerView.bounds) - (width / 2.0f), CGRectGetMidY(self.containerView.bounds) - (height / 2.0f), width, height));
}

@end
