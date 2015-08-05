//
//  FirstViewController.m
//  Playground
//
//  Created by Rune Madsen on 2015-05-20.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "FirstViewController.h"

@import Buy;

@interface FirstViewController ()

@end

@implementation FirstViewController

- (IBAction)buttonAction:(id)sender {
	BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"davidmuzi.myshopify.com"
													   apiKey:@"ad30d5343ef86e2b4babef12f1d90d13"
													channelId:@"237698"];
	
	client.urlScheme = @"playground://";
	BUYProductViewController *productViewController = [[BUYProductViewController alloc] initWithClient:client];
	productViewController.merchantId = @"merchant.com.shopify.applepay";
	
//			BUYTheme *theme = [[BUYTheme alloc] init];
	//		theme.tintColor = [UIColor colorWithRed:0.48 green:0.71 blue:0.36 alpha:1];
//			theme.style = BUYThemeStyleDark;
//			productViewController.theme = theme;
	[productViewController loadProduct:@"470952706" completion:^(BOOL success, NSError *error) {
		[self presentViewController:productViewController animated:YES completion:NULL];
	}];
}

@end
