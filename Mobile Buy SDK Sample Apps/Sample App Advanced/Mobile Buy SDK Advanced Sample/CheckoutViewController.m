//
//  CheckoutViewController.m
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "CheckoutViewController.h"
#import "GetCompletionStatusOperation.h"

@import Buy;

NSString * const CheckoutCallbackNotification = @"CheckoutCallbackNotification";
NSString * const MerchantId = @"";

@interface CheckoutViewController () <PKPaymentAuthorizationViewControllerDelegate, GetCompletionStatusOperationDelegate>

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, strong) BUYApplePayHelpers *applePayHelper;

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
    
    UIButton *applePayButton = [BUYPaymentButton buttonWithType:BUYPaymentButtonTypeBuy style:BUYPaymentButtonStyleBlack];
    applePayButton.translatesAutoresizingMaskIntoConstraints = NO;
    [applePayButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applePayButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(creditCardButton, webCheckoutButton, applePayButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[creditCardButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webCheckoutButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[applePayButton]-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(100)-[creditCardButton]-[webCheckoutButton]-[applePayButton]" options:0 metrics:nil views:views]];
}

- (void)addCreditCardToCheckout:(void (^)(BOOL success))callback
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self.client storeCreditCard:[self creditCard] checkout:self.checkout completion:^(BUYCheckout *checkout, NSString *paymentSessionId, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

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

#pragma mark Native Checkout

- (void)checkoutWithCreditCard
{
    __weak CheckoutViewController *welf = self;
    
    // First, the credit card must be stored on the checkout
    [self addCreditCardToCheckout:^(BOOL success) {
        
        if (success) {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

            // upon successfully adding the credit card to the checkout, complete checkout must be called
            [welf.client completeCheckout:welf.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                
                if (error == nil && checkout) {
                    
                    NSLog(@"Successfully completed checkout");
                    welf.checkout = checkout;
                    
                    GetCompletionStatusOperation *completionOperation = [[GetCompletionStatusOperation alloc] initWithClient:welf.client withCheckout:welf.checkout];
                    completionOperation.delegate = welf;

                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                    [[NSOperationQueue mainQueue] addOperation:completionOperation];
                }
                else {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    NSLog(@"Error completing checkout: %@", error);
                }
            }];
        }
    }];
}

- (void)operation:(GetCompletionStatusOperation *)operation didReceiveCompletionStatus:(BUYStatus)completionStatus
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSLog(@"Successfully got completion status: %lu", (unsigned long)completionStatus);
    
    [self showCheckoutConfirmation];
}

- (void)operation:(GetCompletionStatusOperation *)operation failedToReceiveCompletionStatus:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSLog(@"Error getting completion status: %@", error);
}

#pragma mark - Apple Pay Checkout

- (void)checkoutWithApplePay
{
    PKPaymentRequest *request = [self paymentRequest];
    
    PKPaymentAuthorizationViewController *paymentController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
 
    self.applePayHelper = [[BUYApplePayHelpers alloc] initWithClient:self.client checkout:self.checkout];
    paymentController.delegate = self.applePayHelper;
    
    [self presentViewController:paymentController animated:YES completion:nil];
}

- (PKPaymentRequest *)paymentRequest
{
    PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
    
    [paymentRequest setMerchantIdentifier:MerchantId];
    [paymentRequest setRequiredBillingAddressFields:PKAddressFieldAll];
    [paymentRequest setRequiredShippingAddressFields:self.checkout.requiresShipping ? PKAddressFieldAll : PKAddressFieldEmail|PKAddressFieldPhone];
    [paymentRequest setSupportedNetworks:@[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard]];
    [paymentRequest setMerchantCapabilities:PKMerchantCapability3DS];
    [paymentRequest setCountryCode:@"US"];
    [paymentRequest setCurrencyCode:@"USD"];
    
    [paymentRequest setPaymentSummaryItems: [self.checkout buy_summaryItems]];

    
    return paymentRequest;
}

# pragma mark - Web checkout

- (void)checkoutOnWeb
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCallbackURLNotification:) name:CheckoutCallbackNotification object:nil];

    
    [[UIApplication sharedApplication] openURL:self.checkout.webCheckoutURL];
}

- (void)didReceiveCallbackURLNotification:(NSNotification *)notification
{
    NSURL *url = notification.userInfo[@"url"];
    
    __weak CheckoutViewController *welf = self;

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

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
