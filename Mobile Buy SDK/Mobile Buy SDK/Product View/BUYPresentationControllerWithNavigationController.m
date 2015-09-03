//
//  BUYPresentationControllerWithNavigationController.m
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
	[navigationController setTheme:theme];
}

@end
