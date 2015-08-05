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
#import "BUYImageKit.h"

@interface BUYPresentationControllerWithNavigationController ()

@property (nonatomic, strong) BUYTheme *theme;

@end

@implementation BUYPresentationControllerWithNavigationController

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
	BUYNavigationController *navigationController = [[BUYNavigationController alloc] initWithRootViewController:controller.presentedViewController];
	UIImage *closeButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:[UIColor whiteColor]];
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
	[closeButton setImage:closeButtonImage forState:UIControlStateNormal];
	UIImage *highlightedImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:self.theme.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191)];
	[closeButton setImage:highlightedImage forState:UIControlStateHighlighted];
	closeButton.frame = CGRectMake(0, 0, 22, 22);
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
	navigationController.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	navigationController.navigationBar.barStyle = (self.theme.style == BUYThemeStyleDark) ? UIBarStyleBlack : UIBarStyleDefault;
	return navigationController;
}

- (void)updateCloseButtonImageWithDarkStyle:(BOOL)darkStyle
{
	if (self.theme.style == BUYThemeStyleLight) {
		UINavigationController *navigationController = (UINavigationController*)self.presentedViewController;
		UIButton *button = (UIButton*)navigationController.navigationItem.leftBarButtonItem.customView;
		UIImage *oldButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:darkStyle ? [UIColor whiteColor] : [UIColor blackColor]];
		UIImage *newButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:darkStyle ? [UIColor blackColor] : [UIColor whiteColor]];
		CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"animateContents"];
		crossFade.duration = 0.25f;
		crossFade.fromValue = (id)oldButtonImage.CGImage;
		crossFade.toValue = (id)newButtonImage.CGImage;
		crossFade.removedOnCompletion = NO;
		crossFade.fillMode = kCAFillModeForwards;
		[button.imageView.layer addAnimation:crossFade forKey:@"animateContents"];
		[button setImage:newButtonImage forState:UIControlStateNormal];
	}
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

- (UIModalPresentationStyle)adaptivePresentationStyle
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForTraitCollection:(UITraitCollection *)traitCollection NS_AVAILABLE_IOS(8_3)
{
	return (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
}

@end
