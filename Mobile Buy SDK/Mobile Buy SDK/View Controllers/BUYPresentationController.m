//
//  BUYPresentationController.m
//
//  Created by David Muzi on 2015-06-04.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "BUYPresentationController.h"

CGFloat const BUYPresentationControllerPartialHeight = 250.0;
CGFloat const BUYPresentationControllerPartialWidth = 250.0;

@interface BUYPresentationController ()
@property (nonatomic, strong) UIVisualEffectView *backgroundView;
@end


@implementation BUYPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
	
	if (self) {
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
		_backgroundView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		_backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
		_backgroundView.alpha = 0.0;
	}
	
    return self;
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
	
	[self.containerView insertSubview:self.backgroundView atIndex:0];
	[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
																   attribute:NSLayoutAttributeHeight
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.containerView
																   attribute:NSLayoutAttributeHeight
																  multiplier:1.0
																	constant:0.0]];
	[self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView
																   attribute:NSLayoutAttributeWidth
																   relatedBy:NSLayoutRelationEqual
																	  toItem:self.containerView
																   attribute:NSLayoutAttributeWidth
																  multiplier:1.0
																	constant:0.0]];
	
	[self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		self.backgroundView.alpha = 1.0;
	} completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    [super dismissalTransitionWillBegin];
	
	[self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		self.backgroundView.alpha = 0.0;
	} completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		[self.backgroundView removeFromSuperview];
	}];
}

- (CGRect)frameOfPresentedViewInContainerView {
	
	UIView *presentingView = self.presentingViewController.view;
	
    return CGRectMake((CGRectGetWidth(presentingView.bounds)-BUYPresentationControllerPartialWidth)/2,
					  (CGRectGetHeight(presentingView.bounds)-BUYPresentationControllerPartialHeight)/2,
					  BUYPresentationControllerPartialWidth,
					  BUYPresentationControllerPartialHeight);
}

@end
