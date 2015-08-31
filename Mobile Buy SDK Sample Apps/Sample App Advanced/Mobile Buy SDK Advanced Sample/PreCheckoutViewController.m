//
//  PreCheckoutTableViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "PreCheckoutViewController.h"
#import "CheckoutViewController.h"

@import Buy;

@interface PreCheckoutViewController ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@end

@implementation PreCheckoutViewController

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
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
    checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [checkoutButton addTarget:self action:@selector(proceedToCheckout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkoutButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(discountButton, giftCardButton, checkoutButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[discountButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[giftCardButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[checkoutButton]-|" options:0 metrics:nil views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[discountButton]-[giftCardButton]-(>=100)-[checkoutButton]-(100)-|" options:0 metrics:nil views:views]];

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
                                                          
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

                                                          [self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                                                              
                                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                                              if (error == nil && checkout) {
                                                                  
                                                                  NSLog(@"Successfully added discount");
                                                                  self.checkout = checkout;
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Gift Card Code" message:nil preferredStyle:UIAlertControllerStyleAlert];;
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Gift Card Code";
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          NSLog(@"Cancel action");
                                                      }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

                                                          [self.client applyGiftCardWithCode:[alertController.textFields[0] text] toCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                                                              
                                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                                              if (error == nil && checkout) {
                                                                  
                                                                  NSLog(@"Successfully added gift card");
                                                                  self.checkout = checkout;
                                                              }
                                                              else {
                                                                  NSLog(@"Error applying gift card: %@", error);
                                                              }
                                                          }];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)proceedToCheckout
{
    CheckoutViewController *checkoutController = [[CheckoutViewController alloc] initWithClient:self.client checkout:self.checkout];
    [self.navigationController pushViewController:checkoutController animated:YES];
}

@end
