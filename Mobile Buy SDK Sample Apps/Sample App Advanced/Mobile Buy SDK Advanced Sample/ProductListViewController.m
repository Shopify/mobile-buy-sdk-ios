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

@import Buy;

@interface ProductListViewController ()
@property BUYClient *client;
@property NSArray *objects;
@end

@implementation ProductListViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose Product";
    
    self.client = [[BUYClient alloc] initWithShopDomain:@""
                                                 apiKey:@""
                                              channelId:@""];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    BUYProduct *product = self.objects[indexPath.row];
    cell.textLabel.text = product.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUYProduct *product = self.objects[indexPath.row];

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

- (BUYAddress *)address
{
    BUYAddress *address = [[BUYAddress alloc] init];
    address.address1 = @"126 York Street";
    address.address2 = @"2nd Floor";
    address.city = @"Ottawa";
    address.company = @"Shopify Inc.";
    address.firstName = @"Tobi";
    address.lastName = @"Lütke";
    address.phone = @"1-555-555-5555";
    address.countryCode = @"CA";
    address.provinceCode = @"ON";
    address.zip = @"K1N5T5";
    return address;
}

@end
