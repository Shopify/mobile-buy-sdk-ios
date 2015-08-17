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
	navigationController.navigationDelegate = self.navigationDelegate;
	[navigationController setTheme:self.theme];
	return navigationController;
}

- (UIModalPresentationStyle)adaptivePresentationStyle
{
	return [self.class adaptivePresentationStyle];
}

+ (UIModalPresentationStyle)adaptivePresentationStyle
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForTraitCollection:(UITraitCollection *)traitCollection
{
	return (traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) ? UIModalPresentationFullScreen : UIModalPresentationFormSheet;
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	BUYNavigationController *navigationController = (BUYNavigationController*)self.presentedViewController;
	navigationController.navigationBar.barStyle = (_theme.style == BUYThemeStyleDark) ? UIBarStyleBlack : UIBarStyleDefault;
	[[UINavigationBar appearanceWhenContainedIn:[BUYNavigationController class], nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName:BUY_RGB(127, 127, 127) }];
	[[UINavigationBar appearanceWhenContainedIn:[BUYNavigationController class], nil] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

@end
