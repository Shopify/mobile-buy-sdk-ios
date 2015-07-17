//
//  BUYNavigationController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-08.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerForVariantSelection.h"

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
	}
	
	return self;
}

- (void)setTheme:(BUYTheme *)theme
{
	switch (theme.style) {
		case BUYThemeStyleDark:
			[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor lightGrayColor] }];
			self.navigationBar.barTintColor = [UIColor blackColor];
			self.navigationBar.tintColor = [UIColor lightGrayColor];
			break;
		case BUYThemeStyleLight:
			[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithWhite:152.0/255.0 alpha:1.0] }];
			self.navigationBar.tintColor = [UIColor colorWithWhite:242.0/255.0 alpha:1.0];
			break;
	}
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
	UIViewController *presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
	if (presentedController == self) {
		UIView *presentedView = presentedController.view;
		CGRect finalRect = [transitionContext finalFrameForViewController:presentedController];
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
		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			CGRect frame = dismissedView.frame;
			frame.origin.y += 50;
			dismissedView.frame = frame;
			dismissedView.alpha = 0.0;
		} completion:^(BOOL finished) {
			[dismissedView removeFromSuperview];
			[transitionContext completeTransition:finished];
		}];
	}
}

@end
