//
//  BUYPresentationControllerWithNavigationController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYPresentationControllerWithNavigationController.h"
#import "BUYNavigationController.h"

@implementation BUYPresentationControllerWithNavigationController

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
	BUYNavigationController *navigationController = [[BUYNavigationController alloc] initWithRootViewController:controller.presentedViewController];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPopover)];
	navigationController.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	return navigationController;
}

- (void)dismissPopover
{
	[self.presentedViewController dismissViewControllerAnimated:YES completion:^{
		// TODO: call a delegate so we can notify the presenting view controller of dismissal
	}];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
	return UIModalPresentationFullScreen;
}

@end
