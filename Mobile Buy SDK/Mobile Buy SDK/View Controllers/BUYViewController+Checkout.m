//
//  BUYViewController+Checkout.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-08-20.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "BUYViewController+Checkout.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
@import SafariServices;

@interface BUYViewController () <SFSafariViewControllerDelegate>

@end

#endif

@implementation BUYViewController (Checkout)


- (void)openWebCheckout:(BUYCheckout *)checkout
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
	if ([SFSafariViewController class]) {
		
		SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:checkout.webCheckoutURL];
		safariViewController.delegate = self;
		
		[self presentViewController:safariViewController animated:YES completion:nil];
	}
	else{
		[[UIApplication sharedApplication] openURL:checkout.webCheckoutURL];
	}
#else
	[[UIApplication sharedApplication] openURL:checkout.webCheckoutURL];
#endif
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000


- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller;
{
	
}

#endif

@end
