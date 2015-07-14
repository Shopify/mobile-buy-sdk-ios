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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"the-app-boutique.myshopify.com"
														   apiKey:@"506ede8b60f86fbf86109a762fe8093d"
														channelId:@"9060547"];
		client.urlScheme = @"playground://";
		BUYProductViewController *productViewController = [[BUYProductViewController alloc] initWithClient:client];
//		BUYTheme *theme = [[BUYTheme alloc] init];
//		theme.tintColor = [UIColor colorWithRed:0.48 green:0.71 blue:0.36 alpha:1];
//		theme.style = BUYThemeStyleDark;
//		productViewController.theme = theme;
		[productViewController loadProduct:@"595444547" completion:^(BOOL success, NSError *error) {
			[self presentViewController:productViewController animated:YES completion:NULL];
		}];
	});
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
