//
//  CheckoutSelectionController.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "CheckoutSelectionController.h"
#import "CheckoutSelectionView.h"

#define kCheckoutAnimationTime 0.3f

@interface CheckoutSelectionController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@end

@implementation CheckoutSelectionController {
	CheckoutSelectionView *_selectionView;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
	}
	return self;
}

- (void)loadView
{
	UIView *background = [[UIView alloc] init];
	background.backgroundColor = [UIColor clearColor];
	self.view = background;
	
	PAYButton *applePayButton = [PAYButton buttonWithType:UIButtonTypeCustom];
	applePayButton.paymentImageView.image = [UIImage imageNamed:@"ApplePayMark"];
	applePayButton.paymentLabel.text = @"Complete with Apple Pay";
	
	PAYButton *checkoutButton = [PAYButton buttonWithType:UIButtonTypeCustom];
	checkoutButton.paymentImageView.image = [UIImage imageNamed:@"credit"];
	checkoutButton.paymentLabel.text = @"Continue Checkout";
	
	PAYButton *cancelButton = [PAYButton buttonWithType:UIButtonTypeCustom];
	cancelButton.paymentImageView.image = [UIImage imageNamed:@"cancel"];
	cancelButton.paymentLabel.text = @"Cancel";
	
	_selectionView = [[CheckoutSelectionView alloc] initWithFrame:self.view.bounds buttons:@[applePayButton, checkoutButton, cancelButton]];
	_selectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:_selectionView];
	
	[applePayButton addTarget:self action:@selector(applePayPressed:) forControlEvents:UIControlEventTouchUpInside];
	[checkoutButton addTarget:self action:@selector(checkoutPressed:) forControlEvents:UIControlEventTouchUpInside];
	[cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Presses

- (void)applePayPressed:(id)sender
{
	[_delegate checkoutSelectionController:self selectedCheckoutType:CheckoutTypeApplePay];
}

- (void)checkoutPressed:(id)sender
{
	[_delegate checkoutSelectionController:self selectedCheckoutType:CheckoutTypeNormal];
}

- (void)cancelPressed:(id)sender
{
	[_delegate checkoutSelectionControllerCancelled:self];
}

#pragma mark - Transitioning Delegate Methods

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
	return kCheckoutAnimationTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	BOOL appearing = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] == self;
	BOOL animated = [transitionContext isAnimated];
	UIView *containerView = [transitionContext containerView];
	
	self.view.frame = [containerView bounds];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	
	if (appearing) {
		[containerView addSubview:self.view];
		
		[_selectionView showButtons:animated ? kCheckoutAnimationTime : 0.0f completion:^(BOOL complete) {
			[transitionContext completeTransition:YES];
		}];
	}
	else {
		[_selectionView hideButtons:animated ? kCheckoutAnimationTime : 0.0f completion:^(BOOL complete) {
			[self.view removeFromSuperview];
			[transitionContext completeTransition:YES];
		}];
	}
}

@end
