//
//  BUYPresentationController.m
//
//  Created by David Muzi on 2015-06-04.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "BUYPresentationControllerForVariantSelection.h"

@implementation BUYPresentationControllerForVariantSelection

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

CGFloat const BUYPresentationControllerPartialHeight = 350.0;
CGFloat const BUYPresentationControllerPartialWidth = 350.0;

- (CGRect)frameOfPresentedViewInContainerView
{
	CGRect containerBounds = self.containerView.bounds;
	CGFloat height = MIN(floor(containerBounds.size.height / 2), BUYPresentationControllerPartialHeight);
	CGFloat width = MIN(floor(containerBounds.size.width / 1.3), BUYPresentationControllerPartialWidth);
    return CGRectMake(CGRectGetMidX(containerBounds) - (width / 2), CGRectGetMidY(containerBounds) - (height / 2), width, height);
}

@end
