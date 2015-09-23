//
//  MasterViewController.m
//  Mobile Buy SDK Advanced Sample
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

#import "ProductListViewController.h"
#import "ShippingRatesTableViewController.h"
#import "ProductViewControllerToggleTableViewCell.h"
#import "ProductViewControllerThemeStyleTableViewCell.h"

@import Buy;

#warning - Enter your shop domain and API Key
#define SHOP_DOMAIN @""
#define API_KEY @""
#define CHANNEL_ID @""

@interface ProductListViewController ()

@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) NSArray *objects;

@property (nonatomic, assign) BOOL demoProductViewController;
@property (nonatomic, assign) BUYThemeStyle themeStyle;

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ProductViewControllerToggleTableViewCell class] forCellReuseIdentifier:@"ProductViewControllerToggleCell"];
    [self.tableView registerClass:[ProductViewControllerThemeStyleTableViewCell class] forCellReuseIdentifier:@"ThemeStyleCell"];
    
    self.title = @"Choose Product";
    
    self.client = [[BUYClient alloc] initWithShopDomain:SHOP_DOMAIN apiKey:API_KEY channelId:CHANNEL_ID];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error == nil && products) {
            self.objects = products;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error fetching products: %@", error);
        }
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.demoProductViewController ? 2 : 1;
            break;
        case 1:
            return self.objects.count;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: {
                    ProductViewControllerToggleTableViewCell *toggleCell = (ProductViewControllerToggleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ProductViewControllerToggleCell" forIndexPath:indexPath];
                    [toggleCell.toggleSwitch setOn:self.demoProductViewController];
                    [toggleCell.toggleSwitch addTarget:self action:@selector(toggleProductViewControllerDemo:) forControlEvents:UIControlEventValueChanged];
                    cell = toggleCell;
                }
                    break;
                case 1: {
                    ProductViewControllerThemeStyleTableViewCell *themeCell = (ProductViewControllerThemeStyleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ThemeStyleCell" forIndexPath:indexPath];
                    themeCell.segmentedControl.selectedSegmentIndex = self.themeStyle;
                    [themeCell.segmentedControl addTarget:self action:@selector(toggleProductViewControllerThemeStyle:) forControlEvents:UIControlEventValueChanged];
                    cell = themeCell;
                }
                default:
                    break;
            }
            break;
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            BUYProduct *product = self.objects[indexPath.row];
            cell.textLabel.text = product.title;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUYProduct *product = self.objects[indexPath.row];
    if (self.demoProductViewController) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self demoProductViewControllerWithProduct:product];
    } else {
        [self demoNativeFlowWithProduct:product];
    }
}

- (void)demoNativeFlowWithProduct:(BUYProduct*)product
{
    BUYCart *cart = [[BUYCart alloc] init];
    [cart addVariant:product.variants.firstObject];
    
    BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:cart];
    
    // Apply billing and shipping address, as well as email to the checkout
    checkout.shippingAddress = [self address];
    checkout.billingAddress = [self address];
    checkout.email = @"banana@testasaurus.com";
    
    self.client.urlScheme = @"advancedsample://";
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error == nil && checkout) {
            
            ShippingRatesTableViewController *shippingController = [[ShippingRatesTableViewController alloc] initWithClient:self.client checkout:checkout];
            [self.navigationController pushViewController:shippingController animated:YES];
        }
        else {
            NSLog(@"Error creating checkout: %@", error);
        }
    }];
}

- (void)demoProductViewControllerWithProduct:(BUYProduct*)product
{
    BUYTheme *theme = [BUYTheme new];
    theme.style = self.themeStyle;
    BUYProductViewController *productViewController = [[BUYProductViewController alloc] initWithClient:self.client theme:theme];
    [productViewController loadWithProduct:product completion:^(BOOL success, NSError *error) {
        if (error == nil) {
            [productViewController presentPortraitInViewController:self];
        }
    }];
}

- (void)toggleProductViewControllerDemo:(UISwitch*)toggleSwitch
{
    self.demoProductViewController = toggleSwitch.on;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)toggleProductViewControllerThemeStyle:(UISegmentedControl*)segmentedControl
{
    self.themeStyle = segmentedControl.selectedSegmentIndex;
}

- (BUYAddress *)address
{
    BUYAddress *address = [[BUYAddress alloc] init];
    address.address1 = @"150 Elgin Street";
    address.address2 = @"8th Floor";
    address.city = @"Ottawa";
    address.company = @"Shopify Inc.";
    address.firstName = @"Egon";
    address.lastName = @"Spengler";
    address.phone = @"1-555-555-5555";
    address.countryCode = @"CA";
    address.provinceCode = @"ON";
    address.zip = @"K1N5T5";
    return address;
}

@end
