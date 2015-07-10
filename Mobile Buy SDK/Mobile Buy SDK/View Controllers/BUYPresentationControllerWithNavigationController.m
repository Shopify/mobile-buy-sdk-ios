//
//  BUYPresentationControllerWithNavigationController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYNavigationController.h"
#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerWithNavigationController.h"

@implementation BUYPresentationControllerWithNavigationController

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
	BUYNavigationController *navigationController = [[BUYNavigationController alloc] initWithRootViewController:controller.presentedViewController];
	[navigationController setNavigationBarHidden:YES];
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPopover)];
	navigationController.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	return navigationController;
}

- (void)dismissPopover
{
	if ([self.presentationDelegate respondsToSelector:@selector(presentationControllerWillDismiss:)]) {
		[self.presentationDelegate presentationControllerWillDismiss:self];
	}
	[self.presentedViewController dismissViewControllerAnimated:YES completion:^{
		if ([self.presentationDelegate respondsToSelector:@selector(presentationControllerDidDismiss:)]) {
			[self.presentationDelegate presentationControllerDidDismiss:self];
		}
	}];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
	return UIModalPresentationFullScreen;
}

@end
