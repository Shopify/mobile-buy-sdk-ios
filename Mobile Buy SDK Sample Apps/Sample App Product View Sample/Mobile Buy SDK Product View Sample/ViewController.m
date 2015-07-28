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
#define MERCHANT_ID @""

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
    
    // Initialize the Buy SDK
    self.client = [[BUYClient alloc] initWithShopDomain:@"davidmuzi.myshopify.com"
                                                 apiKey:@"ad30d5343ef86e2b4babef12f1d90d13"
                                              channelId:@"237698"];
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
    
    BUYTheme *theme = [[BUYTheme alloc] init];
    switch (indexPath.row) {
        case 0: {
//            theme.style = BUYThemeStyleDark;
            theme.tintColor = [UIColor colorWithRed:0.349 green:0.627 blue:0.847 alpha:1.000];
        }
            break;
        case 1: {
            theme.tintColor = [UIColor colorWithRed:0.055 green:0.502 blue:0.129 alpha:1.000];
        }
            break;
        case 2: {
            theme.showsProductImageBackground = NO;
        }
            break;
        case 3: {
            theme.style = BUYThemeStyleDark;
            theme.tintColor = [UIColor colorWithRed:0.855 green:0.678 blue:0.463 alpha:1.000];
        }
            break;
        case 4: {
            theme.tintColor = [UIColor colorWithRed:0.894 green:0.275 blue:0.290 alpha:1.000];
        }
            break;
        case 6: {
            theme.showsProductImageBackground = NO;
            theme.tintColor = [UIColor colorWithRed:0.227 green:0.651 blue:0.996 alpha:1.000];
        }
            break;
        case 7: {
            theme.style = BUYThemeStyleDark;
            theme.showsProductImageBackground = NO;
            theme.tintColor = [UIColor colorWithRed:0.745 green:0.749 blue:0.000 alpha:1.000];
        }
            break;
        default:
            break;
    }
    self.productViewController.theme = theme;
    
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
