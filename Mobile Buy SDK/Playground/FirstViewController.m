//
//  FirstViewController.m
//  Playground
//
//  Created by Rune Madsen on 2015-05-20.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "FirstViewController.h"
#import <Buy/Buy.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	BUYClient *client = [[BUYClient alloc] initWithShopDomain:@"the-app-boutique.myshopify.com"
													   apiKey:@"506ede8b60f86fbf86109a762fe8093d"
													channelId:@"9060547"];
	BUYProductViewController *productViewController = [[BUYProductViewController alloc] initWithClient:client];
	[productViewController loadProduct:@"595444547" completion:^(BOOL success, NSError *error) {
		[self presentViewController:productViewController animated:YES completion:NULL];
	}];
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
