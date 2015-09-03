//
//  ViewController.m
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

#import "ViewController.h"

@import Buy;

#warning - Enter your shop domain and API Key
#define SHOP_DOMAIN @""
#define API_KEY @""
#define CHANNEL_ID @""

#warning Optionally, to support Apple Pay, enter your merchant ID
#define MERCHANT_ID @""

@interface ViewController () <BUYViewControllerDelegate>
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
        _productViewController.delegate = self;
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

#pragma mark - BUYViewController delegate methods

- (void)controllerWillCheckoutViaWeb:(BUYViewController *)viewController
{
    NSLog(@"Started web checkout");
}

- (void)controller:(BUYViewController *)controller didDismissWebCheckout:(BUYCheckout *)checkout
{
    NSLog(@"web view controller dismissed");
}

- (void)controller:(BUYViewController *)controller didCompleteCheckout:(BUYCheckout *)checkout status:(BUYStatus)status
{
    NSLog(@"web checkout complete: %lu", (unsigned long)status);
}

- (void)didDismissViewController:(BUYViewController *)viewController
{
    NSLog(@"product view controller dismissed");
}

@end
