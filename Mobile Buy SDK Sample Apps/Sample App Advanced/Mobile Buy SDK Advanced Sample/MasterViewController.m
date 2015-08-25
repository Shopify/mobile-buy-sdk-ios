//
//  MasterViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-25.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "GetShippingRatesOperations.h"

@import Buy;

@interface MasterViewController () <GetShippingRatesOperationsDelegate>
@property BUYClient *client;
@property NSArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose Product";
    
    self.client = [[BUYClient alloc] initWithShopDomain:@""
                                                 apiKey:@""
                                              channelId:@""];

    
    [self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        
        if (error == nil && products) {
            self.objects = products;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error fetching products: %@", error);
        }
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
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
    
    checkout.shippingAddress = [self shippingAddress];
    
    [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
        
        GetShippingRatesOperations *shippingOperation = [[GetShippingRatesOperations alloc] initWithClient:self.client withCheckout:checkout];
        shippingOperation.delegate = self;
        [[NSOperationQueue mainQueue] addOperation:shippingOperation];
    }];
    
}

- (BUYAddress *)shippingAddress
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

#pragma mark - Shipping Rates delegate methods

-(void)operation:(GetShippingRatesOperations *)operation didReceiveShippingRates:(NSArray *)shippingRates
{
    NSLog(@"Got shipping rates: %@", shippingRates);
}

-(void)operation:(GetShippingRatesOperations *)operation failedToReceiveShippingRates:(NSError *)error
{
    NSLog(@"Failed to retrieve shipping rates: %@", error);
}

@end
