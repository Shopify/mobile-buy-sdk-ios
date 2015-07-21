//
//  ViewController.m
//  Mobile Buy SDK Product View Sample
//
//  Created by David Muzi on 2015-07-16.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "ViewController.h"

@import Buy;

#warning - Enter your shop domain and API Key
#define SHOP_DOMAIN @""
#define API_KEY @""
#define CHANNEL_ID @""

#warning Optionally, to support Apple Pay, enter your merchant ID
#define MERCHANT_ID @"com.merchant.shopify.applepay"

@interface ViewController ()
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, strong) BUYProductViewController *productViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Products";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Initialize the Buy SDK
    self.client = [[BUYClient alloc] initWithShopDomain:SHOP_DOMAIN apiKey:API_KEY channelId:CHANNEL_ID];
    self.client.urlScheme = @"sampleapp://";
    
    // Get the list of products
    [self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        
        if (error) {
            NSLog(@"Error retrieving products: %@", error.userInfo);
        }
        else {
            self.products = products;
            [self.tableView reloadData];
        }
    }];
}

- (BUYProductViewController *)productViewController
{
    // reusing the same productViewController will prevent unnecessary network calls in subsequent uses
    if (_productViewController == nil) {
        _productViewController = [[BUYProductViewController alloc] initWithClient:self.client];
        _productViewController.merchantId = MERCHANT_ID;
    }
    
    return _productViewController;
}

#pragma TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    BUYProduct *product = self.products[indexPath.row];
    
    cell.textLabel.text = product.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUYProduct *product = self.products[indexPath.row];
    
    if (self.productViewController.isLoading == NO) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        [self.productViewController loadWithProduct:product completion:^(BOOL success, NSError *error) {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            if (success) {
                [self presentViewController:self.productViewController animated:YES completion:nil];
            }
            else {
                NSLog(@"Error: %@", error.userInfo);
            }
        }];
    }
}

@end
