//
//  BUYNavigationController.m
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

#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerForVariantSelection.h"
#import "BUYImageKit.h"
#import "BUYTheme+Additions.h"

@interface BUYOptionSelectionNavigationController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation BUYOptionSelectionNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	if (self) {
		
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
		self.view.layer.cornerRadius = 4.0;
		self.view.clipsToBounds = YES;
		
		// Add custom back button
		UIImage *buttonImage = [[BUYImageKit imageOfVariantBackImageWithFrame:CGRectMake(0, 0, 12, 18)] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		if ([[UIBarButtonItem class] respondsToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)]) {
			[[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[BUYNavigationController class]]] setBackButtonBackgroundImage:[buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 0)]
																																  forState:UIControlStateNormal
																																barMetrics:UIBarMetricsDefault];
		} else {
			[[UIBarButtonItem appearanceWhenContainedIn:[BUYNavigationController class], nil] setBackButtonBackgroundImage:[buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 0)]
																												  forState:UIControlStateNormal
																												barMetrics:UIBarMetricsDefault];
		}
		
		_breadsCrumbsView = [BUYVariantOptionBreadCrumbsView new];
		_breadsCrumbsView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:_breadsCrumbsView];
		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_breadsCrumbsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
		_breadsCrumbsView.visibleConstraint = [NSLayoutConstraint constraintWithItem:_breadsCrumbsView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
		_breadsCrumbsView.hiddenConstraint = [NSLayoutConstraint constraintWithItem:_breadsCrumbsView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
		[NSLayoutConstraint activateConstraints:@[_breadsCrumbsView.hiddenConstraint]];
		
		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_breadsCrumbsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navigationBar attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
	}
	
	return self;
}

- (void)setTheme:(BUYTheme *)theme
{
	[self.breadsCrumbsView setTheme:theme];
	self.navigationBar.barStyle = [theme navigationBarStyle];
	[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [theme navigationBarTitleVariantSelectionColor] }];
	self.navigationBar.tintColor = theme.tintColor;
}

#pragma mark - Transitioning Delegate Methods

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
	BUYPresentationControllerForVariantSelection *presentationController = [[BUYPresentationControllerForVariantSelection alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
	return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
	return self;
}

#pragma mark - Animated Transitioning Methods

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
	return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	if (toViewController == self) {
		UIView *presentedView = toViewController.view;
		CGRect finalRect = [transitionContext finalFrameForViewController:toViewController];
		presentedView.frame = finalRect;
		presentedView.alpha = 0.0;
		
		[[transitionContext containerView] addSubview:presentedView];
		
		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			presentedView.alpha = 1.0;
		} completion:^(BOOL finished) {
			[transitionContext completeTransition:finished];
		}];
	}
	else {
		UIView *dismissedView = [transitionContext viewForKey:UITransitionContextFromViewKey];
		CGRect frame = dismissedView.frame;
		CGAffineTransform transform;
		BUYOptionSelectionNavigationController *optionSelectionNavigationController = (BUYOptionSelectionNavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
		if (optionSelectionNavigationController.dismissWithCancelAnimation) {
			frame.origin.y += 150;
			int angle = arc4random_uniform(20) - 10;
			double rotation = (angle / 180.0f) * M_PI;
			transform = CGAffineTransformMakeRotation((CGFloat)rotation);
		} else {
			transform = CGAffineTransformMakeScale(2, 2);
		}
		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			dismissedView.frame = frame;
			dismissedView.transform = transform;
			dismissedView.alpha = 0.0;
		} completion:^(BOOL finished) {
			[dismissedView removeFromSuperview];
			[transitionContext completeTransition:finished];
		}];
	}
}

@end
