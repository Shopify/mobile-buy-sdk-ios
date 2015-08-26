//
//  CheckoutViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "CheckoutViewController.h"
@import Buy;

@interface CheckoutViewController ()
@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@end

@implementation CheckoutViewController

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
    // Do any additional setup after loading the view.
    
    self.title = @"Checkout";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
