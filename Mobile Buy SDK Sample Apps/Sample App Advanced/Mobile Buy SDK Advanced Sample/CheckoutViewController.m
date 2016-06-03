//
//  CheckoutViewController.m
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

@import Buy;

#import "CheckoutViewController.h"
#import "SummaryItemsTableViewCell.h"
#import "UIButton+PaymentButton.h"

NSString * const CheckoutCallbackNotification = @"CheckoutCallbackNotification";
NSString * const MerchantId = @"";

@interface CheckoutViewController () <SFSafariViewControllerDelegate, PKPaymentAuthorizationViewControllerDelegate>

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) BUYShop *shop;
@property (nonatomic, strong) NSArray *summaryItems;
@property (nonatomic, strong) BUYApplePayAuthorizationDelegate *applePayHelper;

@end

@implementation CheckoutViewController

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout;
{
    NSParameterAssert(client);
    NSParameterAssert(checkout);
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        self.checkout = checkout;
        self.client = client;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Checkout";
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 164)];
    
    UIButton *creditCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creditCardButton setTitle:@"Checkout with Credit Card" forState:UIControlStateNormal];
    creditCardButton.backgroundColor = [UIColor colorWithRed:0.48f green:0.71f blue:0.36f alpha:1.0f];
    creditCardButton.layer.cornerRadius = 6;
    [creditCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    creditCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [creditCardButton addTarget:self action:@selector(checkoutWithCreditCard) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:creditCardButton];
    
    UIButton *webCheckoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [webCheckoutButton setTitle:@"Web Checkout" forState:UIControlStateNormal];
    webCheckoutButton.backgroundColor = [UIColor colorWithRed:0.48f green:0.71f blue:0.36f alpha:1.0f];
    webCheckoutButton.layer.cornerRadius = 6;
    [webCheckoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    webCheckoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [webCheckoutButton addTarget:self action:@selector(checkoutOnWeb) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:webCheckoutButton];
    
    UIButton *applePayButton = [UIButton paymentButtonWithType:PaymentButtonTypeBuy style:PaymentButtonStyleBlack];
    applePayButton.translatesAutoresizingMaskIntoConstraints = NO;
    [applePayButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:applePayButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(creditCardButton, webCheckoutButton, applePayButton);
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[creditCardButton]-|" options:0 metrics:nil views:views]];
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[webCheckoutButton]-|" options:0 metrics:nil views:views]];
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[applePayButton]-|" options:0 metrics:nil views:views]];
    
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[creditCardButton(44)]-[webCheckoutButton(==creditCardButton)]-[applePayButton(==creditCardButton)]-|" options:0 metrics:nil views:views]];
    
    self.tableView.tableFooterView = footerView;
    
    [self.tableView registerClass:[SummaryItemsTableViewCell class] forCellReuseIdentifier:@"SummaryCell"];
    
    // Prefetch the shop object for Apple Pay
    [self.client getShop:^(BUYShop *shop, NSError *error) {
        _shop = shop;
    }];
}

- (void)setCheckout:(BUYCheckout *)checkout
{
    _checkout = checkout;
    self.summaryItems = [checkout buy_summaryItems];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.summaryItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell" forIndexPath:indexPath];
    PKPaymentSummaryItem *summaryItem = self.summaryItems[indexPath.row];
    cell.textLabel.text = summaryItem.label;
    cell.detailTextLabel.text = [self.currencyFormatter stringFromNumber:summaryItem.amount];
    // Only show a line above the last cell
    if (indexPath.row != [self.summaryItems count] - 2) {
        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
    }
    
    return cell;
}

- (void)addCreditCardToCheckout:(void (^)(BOOL success, id<BUYPaymentToken> token))callback
{
    [self.client storeCreditCard:[self creditCard] checkout:self.checkout completion:^(id<BUYPaymentToken> token, NSError *error) {
        if (error == nil && token) {
            NSLog(@"Successfully added credit card to checkout");
        }
        else {
            NSLog(@"Error applying credit card: %@", error);
        }
        
        callback(error == nil && token, token);
    }];
}

- (BUYCreditCard *)creditCard
{
    BUYCreditCard *creditCard = [[BUYCreditCard alloc] init];
    creditCard.number = @"4242424242424242";
    creditCard.expiryMonth = @"12";
    creditCard.expiryYear = @"2020";
    creditCard.cvv = @"123";
    creditCard.nameOnCard = @"John Smith";
    
    return creditCard;
}

- (void)showCheckoutConfirmation
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Checkout complete" message:nil preferredStyle:UIAlertControllerStyleAlert];;
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Start over"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Show order status page"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:self.checkout.order.statusURL];
                                                          safariViewController.delegate = self;
                                                          [self presentViewController:safariViewController animated:YES completion:NULL];
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - SafariViewControllerDelegate

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [self getCompletedCheckout:^{
        if (self.checkout.order) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showCheckoutConfirmation];
            });
        }
    }];
}

#pragma mark - Native Checkout

- (void)checkoutWithCreditCard
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    __weak CheckoutViewController *welf = self;
    
    // First, the credit card must be stored on the checkout
    [self addCreditCardToCheckout:^(BOOL success, id<BUYPaymentToken> token) {
        
        if (success) {
            [welf.client completeCheckoutWithToken:welf.checkout.token paymentToken:token completion:^(BUYCheckout *checkout, NSError *error) {
                
                if (error == nil && checkout) {
                    NSLog(@"Successfully completed checkout");
                    welf.checkout = checkout;
                }
                else {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    NSLog(@"Error completing checkout: %@", error);
                }
            }];
        }
    }];
}

#pragma mark - Apple Pay Checkout

- (void)checkoutWithApplePay
{
    PKPaymentRequest *request = [self paymentRequest];
    
    PKPaymentAuthorizationViewController *paymentController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
    
    self.applePayHelper = [[BUYApplePayAuthorizationDelegate alloc] initWithClient:self.client checkout:self.checkout shopName:self.shop.name];
    paymentController.delegate = self;
    
    /**
     *  Alternatively we can set the delegate to self.applePayHelper.
     *  If you do not care about any PKPaymentAuthorizationViewControllerDelegate callbacks
     *  uncomment the code below to let BUYApplePayHelpers take care of them automatically.
     *  You can then also safely remove the PKPaymentAuthorizationViewControllerDelegate
     *  methods below.
     *
     *  // paymentController.delegate = self.applePayHelper
     *
     *  If you keep self as the delegate, you have a chance to intercept the
     *  PKPaymentAuthorizationViewControllerDelegate callbacks and add any additional logging
     *  and method calls as you need. Ensure that you forward them to the BUYApplePayHelpers
     *  class by calling the delegate methods on BUYApplePayHelpers which already implements
     *  the PKPaymentAuthorizationViewControllerDelegate protocol.
     *
     */
    
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
    [paymentRequest setCountryCode:self.shop.country ?: @"US"];
    [paymentRequest setCurrencyCode:self.shop.currency ?: @"USD"];
    
    [paymentRequest setPaymentSummaryItems:[self.checkout buy_summaryItemsWithShopName:self.shop.name]];
    
    return paymentRequest;
}

#pragma mark - PKPaymentAuthorizationViewControllerDelegate

- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion
{
    // Add additional methods if needed and forward the callback to BUYApplePayHelpers
    [self.applePayHelper paymentAuthorizationViewController:controller didAuthorizePayment:payment completion:completion];
    
    self.checkout = self.applePayHelper.checkout;
    [self getCompletedCheckout:NULL];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    // Add additional methods if needed and forward the callback to BUYApplePayHelpers
    [self.applePayHelper paymentAuthorizationViewControllerDidFinish:controller];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingAddress:(ABRecordRef)address completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    // Add additional methods if needed and forward the callback to BUYApplePayHelpers
    [self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingAddress:address completion:completion];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingContact:(PKContact *)contact completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKShippingMethod *> * _Nonnull, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    // Add additional methods if needed and forward the callback to BUYApplePayHelpers
    [self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingContact:contact completion:completion];
}

-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didSelectShippingMethod:(PKShippingMethod *)shippingMethod completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    // Add additional methods if needed and forward the callback to BUYApplePayHelpers
    [self.applePayHelper paymentAuthorizationViewController:controller didSelectShippingMethod:shippingMethod completion:completion];
}

# pragma mark - Web checkout

- (void)checkoutOnWeb
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCallbackURLNotification:) name:CheckoutCallbackNotification object:nil];
    
    // On iOS 9+ we should use the SafariViewController to display the checkout in-app
    if ([SFSafariViewController class]) {
        
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:self.checkout.webCheckoutURL];
        safariViewController.delegate = self;
        
        [self presentViewController:safariViewController animated:YES completion:nil];
    }
    else {
        [[UIApplication sharedApplication] openURL:self.checkout.webCheckoutURL];
    }
}

- (void)didReceiveCallbackURLNotification:(NSNotification *)notification
{
    NSURL *url = notification.userInfo[@"url"];
    
    if ([self.presentedViewController isKindOfClass:[SFSafariViewController class]]) {
        [self dismissViewControllerAnimated:self.presentedViewController completion:^{
            [self getCompletionStatusAndCompletedCheckoutWithURL:url];
        }];
    } else {
        [self getCompletionStatusAndCompletedCheckoutWithURL:url];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CheckoutCallbackNotification object:nil];
}

- (void)getCompletionStatusAndCompletedCheckoutWithURL:(NSURL*)url
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __weak CheckoutViewController *welf = self;
    
    [self.client getCompletionStatusOfCheckoutURL:url completion:^(BUYStatus status, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error == nil && status == BUYStatusComplete) {
            NSLog(@"Successfully completed checkout");
            [welf getCompletedCheckout:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showCheckoutConfirmation];
                });
            }];
        }
        else {
            NSLog(@"Error completing checkout: %@", error);
        }
    }];
}

- (void)getCompletedCheckout:(void (^)(void))completionBlock
{
    __weak CheckoutViewController *welf = self;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self.client getCheckoutWithToken:self.checkout.token completion:^(BUYCheckout *checkout, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            NSLog(@"Unable to get completed checkout");
            NSLog(@"%@", error);
        }
        if (checkout) {
            welf.checkout = checkout;
            NSLog(@"%@", checkout);
        }
        
        if (completionBlock) {
            completionBlock();
        }
    }];
}

@end
