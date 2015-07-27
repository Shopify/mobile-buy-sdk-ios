//
//  BUYNavigationController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-08.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerForVariantSelection.h"
#import "BUYImageKit.h"

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
		UIImage *buttonImage = [BUYImageKit imageOfVariantBackImageWithFrame:CGRectMake(0, 0, 12, 18)];
		[[UIBarButtonItem appearanceWhenContainedIn:[BUYNavigationController class], nil] setBackButtonBackgroundImage:[buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 0)]
																											  forState:UIControlStateNormal
																											barMetrics:UIBarMetricsDefault];
		
	}
	
	return self;
}

- (void)setTheme:(BUYTheme *)theme
{
	switch (theme.style) {
		case BUYThemeStyleDark:
			[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor lightGrayColor] }];
			self.navigationBar.barStyle = UIBarStyleBlack;
			break;
		case BUYThemeStyleLight:
			[self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithWhite:(float)(152.0/255.0) alpha:1.0] }];
			self.navigationBar.barStyle = UIBarStyleDefault;
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
