//
//  PreCheckoutTableViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "PreCheckoutTableViewController.h"
@import Buy;

@interface PreCheckoutTableViewController ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@end

@implementation PreCheckoutTableViewController

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
    
    self.title = @"Apply Discounts";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *discountButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [discountButton setTitle:@"Apply Discount" forState:UIControlStateNormal];
    discountButton.translatesAutoresizingMaskIntoConstraints = NO;
    [discountButton addTarget:self action:@selector(applyDiscount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:discountButton];
    
    UIButton *giftCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [giftCardButton setTitle:@"Apply Gift Card" forState:UIControlStateNormal];
    giftCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [giftCardButton addTarget:self action:@selector(applyGiftCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:giftCardButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(discountButton, giftCardButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[discountButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[giftCardButton]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[discountButton]-[giftCardButton]" options:0 metrics:nil views:views]];

}

- (void)applyDiscount
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Discount Code" message:nil preferredStyle:UIAlertControllerStyleAlert];;

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.placeholder = @"Discount Code";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          NSLog(@"Cancel action");
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          BUYDiscount *discount = [[BUYDiscount alloc] initWithCode:[alertController.textFields[0] text]];
                                                          self.checkout.discount = discount;
                                                          [self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                                                              
                                                              if (error == nil && checkout) {
                                                                  
                                                                  PreCheckoutTableViewController *preCheckoutController = [[PreCheckoutTableViewController alloc] initWithClient:self.client checkout:checkout];
                                                                  [self.navigationController pushViewController:preCheckoutController animated:YES];
                                                              }
                                                              else {
                                                                  NSLog(@"Error applying checkout: %@", error);
                                                              }
                                                          }];
                                                          
                                                          
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)applyGiftCard
{
    
}

@end
