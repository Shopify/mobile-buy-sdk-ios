//
//  ViewController.m
//  Mobile Buy SDK TV Sample
//
//  Created by David Muzi on 2015-09-16.
//  Copyright © 2015 Shopfy. All rights reserved.
//

#import "ViewController.h"
//@import BuyTV;
#import <BuyTV/BuyTV.h>
@interface ViewController ()
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) NSArray *products;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.client = [[BUYClient alloc] initWithShopDomain:@"davidmuzi.myshopify.com"
                                                 apiKey:@"ad30d5343ef86e2b4babef12f1d90d13"
                                              channelId:@"237698"];
    
    [self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
        self.products = products;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = [self.products[indexPath.row] title];
    
    return cell;
}

@end
