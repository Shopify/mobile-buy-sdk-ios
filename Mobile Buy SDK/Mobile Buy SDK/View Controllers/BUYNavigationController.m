//
//  BUYNavigationController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-08.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYNavigationController.h"
#import "BUYPresentationController.h"

@interface BUYNavigationController () <UIViewControllerTransitioningDelegate>

@end

@implementation BUYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	
	if (self) {
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
		self.view.layer.cornerRadius = 4.0;
		self.view.clipsToBounds = YES;
		
		[self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
		self.navigationBar.tintColor = [UIColor grayColor];
	}
	
	return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
	UIPresentationController *presentationController = [[BUYPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	return presentationController;
}

@end
