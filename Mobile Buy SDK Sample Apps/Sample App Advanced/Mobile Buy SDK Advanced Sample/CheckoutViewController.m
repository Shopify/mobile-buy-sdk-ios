//
//  CheckoutViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "CheckoutViewController.h"
@import Buy;

NSString * const CheckoutCallbackNotification = @"CheckoutCallbackNotification";


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
    
    UIButton *creditCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creditCardButton setTitle:@"Checkout with Credit Card" forState:UIControlStateNormal];
    creditCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [creditCardButton addTarget:self action:@selector(checkoutWithCreditCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creditCardButton];
    
    UIButton *webCheckoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [webCheckoutButton setTitle:@"Web Checkout" forState:UIControlStateNormal];
    webCheckoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [webCheckoutButton addTarget:self action:@selector(checkoutOnWeb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webCheckoutButton];
    
    UIButton *checkoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
    checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [checkoutButton addTarget:self action:@selector(proceedToCheckout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkoutButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(creditCardButton, webCheckoutButton, checkoutButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[creditCardButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webCheckoutButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[checkoutButton]-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[creditCardButton]-[webCheckoutButton]-(>=100)-[checkoutButton]-(100)-|" options:0 metrics:nil views:views]];
}

- (void)addCreditCardToCheckout:(void (^)(BOOL success))callback
{
    [self.client storeCreditCard:[self creditCard] checkout:self.checkout completion:^(BUYCheckout *checkout, NSString *paymentSessionId, NSError *error) {
        
        if (error == nil && checkout) {
            
            NSLog(@"Successfully added credit card to checkout");
            self.checkout = checkout;
        }
        else {
            NSLog(@"Error applying credit card: %@", error);
        }
        
        callback(error == nil && checkout);
    }];
}

- (BUYCreditCard *)creditCard
{
    BUYCreditCard *creditCard = [[BUYCreditCard alloc] init];
    creditCard.number = @"4242424242424242";
    creditCard.expiryMonth = @"12";
    creditCard.expiryYear = @"20";
    creditCard.cvv = @"123";
    creditCard.nameOnCard = @"Dinosaur Banana";
    
    return creditCard;
}

- (void)showCheckoutConfirmation
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Checkout complete" message:nil preferredStyle:UIAlertControllerStyleAlert];;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                          
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)checkoutWithCreditCard
{
    __weak CheckoutViewController *welf = self;
    
    [self addCreditCardToCheckout:^(BOOL success) {
        
        if (success) {
            
            [welf.client completeCheckout:welf.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                
                if (error == nil && checkout) {
                    
                    NSLog(@"Successfully completed checkout");
                    welf.checkout = checkout;
                    
                    [welf showCheckoutConfirmation];
                }
                else {
                    NSLog(@"Error completing checkout: %@", error);
                }
            }];
        }
    }];
}

- (void)checkoutWithApplePay
{
    
}

- (void)checkoutOnWeb
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCallbackURLNotification:) name:CheckoutCallbackNotification object:nil];

    
    [[UIApplication sharedApplication] openURL:self.checkout.webCheckoutURL];
}

- (void)didReceiveCallbackURLNotification:(NSNotification *)notification
{
    NSURL *url = notification.userInfo[@"url"];
    
    __weak CheckoutViewController *welf = self;

    [self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
        
        if (error == nil && status == BUYStatusComplete) {
            
            NSLog(@"Successfully completed checkout");
            [welf showCheckoutConfirmation];
        }
        else {
            NSLog(@"Error completing checkout: %@", error);
        }
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CheckoutCallbackNotification object:nil];
}
@end
