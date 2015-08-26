//
//  ShippingRatesTableViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "ShippingRatesTableViewController.h"
#import "GetShippingRatesOperation.h"
#import "PreCheckoutViewController.h"

@import Buy;

@interface ShippingRatesTableViewController () <GetShippingRatesOperationDelegate>
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, strong) NSArray *shippingRates;
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
    
    self.title = @"Choose Shipping Rate";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    GetShippingRatesOperation *shippingOperation = [[GetShippingRatesOperation alloc] initWithClient:self.client withCheckout:self.checkout];
    shippingOperation.delegate = self;
    [[NSOperationQueue mainQueue] addOperation:shippingOperation];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.shippingRates.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BUYShippingRate *shippingRate = self.shippingRates[indexPath.row];
    cell.textLabel.text = shippingRate.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BUYShippingRate *shippingRate = self.shippingRates[indexPath.row];

    self.checkout.shippingRate = shippingRate;
    
    [self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
        
        if (error == nil && checkout) {
            
            PreCheckoutViewController *preCheckoutController = [[PreCheckoutViewController alloc] initWithClient:self.client checkout:checkout];
            [self.navigationController pushViewController:preCheckoutController animated:YES];
        }
        else {
            NSLog(@"Error applying checkout: %@", error);
        }
        
    }];
}

#pragma mark - Shipping Rates delegate methods

-(void)operation:(GetShippingRatesOperation *)operation didReceiveShippingRates:(NSArray *)shippingRates
{    
    self.shippingRates = shippingRates;
    [self.tableView reloadData];
}

-(void)operation:(GetShippingRatesOperation *)operation failedToReceiveShippingRates:(NSError *)error
{
    NSLog(@"Failed to retrieve shipping rates: %@", error);
}

@end
