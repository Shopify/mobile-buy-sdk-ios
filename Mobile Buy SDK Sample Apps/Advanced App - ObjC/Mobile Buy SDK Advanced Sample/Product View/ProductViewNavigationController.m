//
//  ProductViewNavigationController.m
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

#import "ProductViewNavigationController.h"
#import "ImageKit.h"
#import "Theme+Additions.h"
#import "ProductViewController.h"

@implementation ProductViewNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
	closeButton.frame = CGRectMake(0, 0, 22, 22);
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
	self.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	if ([[UINavigationBar class] respondsToSelector:@selector(appearanceWhenContainedInInstancesOfClasses:)]) {
		[[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ProductViewNavigationController class]]] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
	} else {
		[[UINavigationBar appearanceWhenContainedIn:[ProductViewNavigationController class], nil] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
	}
	
	[self updateCloseButtonImageWithTintColor:YES duration:0];
	
	return self;
}

- (void)updateCloseButtonImageWithTintColor:(BOOL)tintColor duration:(CGFloat)duration
{
	UIButton *button = (UIButton*)self.topViewController.navigationItem.leftBarButtonItem.customView;
	UIImage *newButtonImage = [ImageKit imageOfProductViewCloseImageWithFrame:button.bounds color:[UIColor whiteColor] hasShadow:tintColor == NO];
	if (tintColor) {
		newButtonImage = [newButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	}
	[UIView transitionWithView:button.imageView
					  duration:duration
					   options:(UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionBeginFromCurrentState)
					animations:^{
						[button setImage:newButtonImage forState:UIControlStateNormal];
					}
					completion:NULL];
}

- (void)dismissPopover
{
	if ([self.navigationDelegate respondsToSelector:@selector(presentationControllerWillDismiss:)]) {
		[self.navigationDelegate presentationControllerWillDismiss:nil];
	}
	[self dismissViewControllerAnimated:YES completion:^{
		if ([self.navigationDelegate respondsToSelector:@selector(presentationControllerDidDismiss:)]) {
			[self.navigationDelegate presentationControllerDidDismiss:nil];
		}
	}];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return self.topViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)shouldAutorotate {
	return self.topViewController.shouldAutorotate;
}

-(UIViewController *)childViewControllerForStatusBarStyle
{
	return [self childViewController];
}

-(UIViewController *)childViewControllerForStatusBarHidden
{
	return [self childViewController];
}

-(UIViewController*)childViewController
{
	if ([self.visibleViewController isKindOfClass:[ProductViewController class]] == NO) {
		return self.viewControllers[0];
	}
	return self.visibleViewController;
}

@end
