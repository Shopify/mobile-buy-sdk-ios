//
//  BUYNavigationController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYNavigationController.h"

@interface BUYNavigationController ()

@end

@implementation BUYNavigationController

-(UIViewController *)childViewControllerForStatusBarStyle {
	return self.visibleViewController;
}

-(UIViewController *)childViewControllerForStatusBarHidden {
	return self.visibleViewController;
}

@end
