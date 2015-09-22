//
//  ShippingRatesTableViewController.m
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

#import "ShippingRatesTableViewController.h"
#import "GetShippingRatesOperation.h"
#import "PreCheckoutViewController.h"
#import "GetShopOperation.h"
#import "ShippingRateTableViewCell.h"

@import Buy;

@interface ShippingRatesTableViewController () <GetShippingRatesOperationDelegate, GetShopOperationDelegate>
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property (nonatomic, strong) NSArray *shippingRates;
@property (nonatomic, strong) NSArray *allOperations;
@end

@implementation ShippingRatesTableViewController

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout;
{
    NSParameterAssert(client);
    NSParameterAssert(checkout);
    
    self = [super init];
    
    if (self) {
        self.checkout = checkout;
        self.client = client;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Shipping Rates";
    
    [self.tableView registerClass:[ShippingRateTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Setup both operations to run
    GetShopOperation *shopOperation = [[GetShopOperation alloc] initWithClient:self.client];
    shopOperation.delegate = self;
    [[NSOperationQueue mainQueue] addOperation:shopOperation];
    
    GetShippingRatesOperation *shippingOperation = [[GetShippingRatesOperation alloc] initWithClient:self.client withCheckout:self.checkout];
    shippingOperation.delegate = self;
    [[NSOperationQueue mainQueue] addOperation:shippingOperation];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Ensure both operations are completed before we reload the table view
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self.tableView reloadData];
    }];
    [blockOperation addDependency:shopOperation];
    [blockOperation addDependency:shippingOperation];
    [[NSOperationQueue mainQueue] addOperation:blockOperation];
    
    self.allOperations = @[blockOperation, shopOperation, shippingOperation];
}

- (void)dealloc
{
    [self.allOperations makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shippingRates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BUYShippingRate *shippingRate = self.shippingRates[indexPath.row];
    cell.textLabel.text = shippingRate.title;
    cell.detailTextLabel.text = [self.currencyFormatter stringFromNumber:shippingRate.price];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUYShippingRate *shippingRate = self.shippingRates[indexPath.row];

    self.checkout.shippingRate = shippingRate;
    
    [self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
        if (error == nil && checkout) {
            PreCheckoutViewController *preCheckoutController = [[PreCheckoutViewController alloc] initWithClient:self.client checkout:checkout];
            preCheckoutController.currencyFormatter = self.currencyFormatter;
            [self.navigationController pushViewController:preCheckoutController animated:YES];
        }
        else {
            NSLog(@"Error applying checkout: %@", error);
        }
        
    }];
}

#pragma mark - Shop delegate methods

-(void)operation:(GetShopOperation *)operation didReceiveShop:(BUYShop *)shop
{
    self.currencyFormatter = [[NSNumberFormatter alloc] init];
    self.currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    self.currencyFormatter.currencyCode = shop.currency;
}

-(void)operation:(GetShopOperation *)operation failedToReceiveShop:(NSError *)error
{
    NSLog(@"Failed to retrieve shop: %@", error);
}

#pragma mark - Shipping Rates delegate methods

-(void)operation:(GetShippingRatesOperation *)operation didReceiveShippingRates:(NSArray *)shippingRates
{
    self.shippingRates = shippingRates;
}

-(void)operation:(GetShippingRatesOperation *)operation failedToReceiveShippingRates:(NSError *)error
{
    NSLog(@"Failed to retrieve shipping rates: %@", error);
}

@end
