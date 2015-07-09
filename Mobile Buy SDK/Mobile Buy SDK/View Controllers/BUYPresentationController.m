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
@property (nonatomic, strong) UIView *backgroundView;
@end


@implementation BUYPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
	
	if (self) {
		
		_backgroundView = [[UIView alloc] init];
		_backgroundView.backgroundColor = [UIColor blackColor];
		_backgroundView.alpha = 0.0;
	}
	
    return self;
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
	
	self.backgroundView.frame = self.containerView.bounds;
	[self.containerView insertSubview:self.backgroundView atIndex:0];
	
	[self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
		self.backgroundView.alpha = 0.5;
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
