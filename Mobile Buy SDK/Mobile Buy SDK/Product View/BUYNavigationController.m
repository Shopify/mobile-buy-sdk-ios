//
//  BUYNavigationController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYNavigationController.h"
#import "BUYImageKit.h"

@interface BUYNavigationController ()
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
	self = [super initWithRootViewController:rootViewController];
	
	UIImage *closeButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:[UIColor whiteColor] hasShadow:YES];
	UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeButton addTarget:self action:@selector(dismissPopover) forControlEvents:UIControlEventTouchUpInside];
	[closeButton setImage:closeButtonImage forState:UIControlStateNormal];
	UIImage *highlightedImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:self.theme.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191) hasShadow:YES];
	[closeButton setImage:highlightedImage forState:UIControlStateHighlighted];
	closeButton.frame = CGRectMake(0, 0, 22, 22);
	UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
	self.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
	self.navigationBar.barStyle = (self.theme.style == BUYThemeStyleDark) ? UIBarStyleBlack : UIBarStyleDefault;
	
	return self;
}

- (void)updateCloseButtonImageWithDarkStyle:(BOOL)darkStyle
{
	UIButton *button = (UIButton*)self.topViewController.navigationItem.leftBarButtonItem.customView;
	UIImage *oldButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:darkStyle ? [UIColor whiteColor] : self.theme.tintColor hasShadow:darkStyle == NO];
	UIImage *newButtonImage = [BUYImageKit imageOfProductViewCloseImageWithFrame:CGRectMake(0, 0, 22, 22) color:darkStyle ? self.theme.tintColor : [UIColor whiteColor] hasShadow:darkStyle == NO];
	CABasicAnimation *crossFade = [CABasicAnimation animationWithKeyPath:@"contents"];
	crossFade.duration = 0.25f;
	crossFade.fromValue = (id)oldButtonImage.CGImage;
	crossFade.toValue = (id)newButtonImage.CGImage;
	crossFade.removedOnCompletion = YES;
	crossFade.fillMode = kCAFillModeForwards;
	[button.imageView.layer addAnimation:crossFade forKey:@"contents"];
	[button setImage:newButtonImage forState:UIControlStateNormal];
	if (self.theme.style == BUYThemeStyleLight) {
	}
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

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	BUYNavigationController *navigationController = (BUYNavigationController*)self.presentedViewController;
	navigationController.navigationBar.barStyle = (_theme.style == BUYThemeStyleDark) ? UIBarStyleBlack : UIBarStyleDefault;
	[[UINavigationBar appearanceWhenContainedIn:[BUYNavigationController class], nil] setTitleTextAttributes:@{ NSForegroundColorAttributeName:BUY_RGB(127, 127, 127) }];
}

-(UIViewController *)childViewControllerForStatusBarStyle {
	return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
	return self.visibleViewController;
}

@end
