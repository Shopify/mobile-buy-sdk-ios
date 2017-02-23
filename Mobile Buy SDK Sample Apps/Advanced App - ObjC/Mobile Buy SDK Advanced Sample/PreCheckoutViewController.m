//
//  PreCheckoutTableViewController.m
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
#import "AppDelegate.h"
#import "PreCheckoutViewController.h"
#import "CheckoutViewController.h"
#import "SummaryItemsTableViewCell.h"
@import Buy;
@import PassKit;

typedef NS_ENUM(NSInteger, UITableViewSections) {
    UITableViewSectionSummaryItems,
    UITableViewSectionDiscountGiftCard,
    UITableViewSectionContinue,
    UITableViewSectionCount
};

typedef NS_ENUM(NSInteger, UITableViewDiscountGiftCardSection) {
    UITableViewDiscountGiftCardSectionDiscount,
    UITableViewDiscountGiftCardSectionGiftCard,
    UITableViewDiscountGiftCardSectionCount
};

@interface PreCheckoutViewController ()

@property (nonatomic, strong) BUYCheckout *checkout;
@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) NSArray *summaryItems;

@end

@implementation PreCheckoutViewController

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Discount or Gift Card(s)";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[SummaryItemsTableViewCell class] forCellReuseIdentifier:@"SummaryCell"];
}

- (void)setCheckout:(BUYCheckout *)checkout
{
    _checkout = checkout;
    // We can take advantage of the PKPaymentSummaryItems used for Apple Pay to display summary items natively in our own checkout
    self.summaryItems = [checkout buy_summaryItems];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return UITableViewSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case UITableViewSectionSummaryItems:
            return [self.summaryItems count];
        case UITableViewSectionDiscountGiftCard:
            return UITableViewDiscountGiftCardSectionCount;
            break;
        default:
            return 1;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case UITableViewSectionSummaryItems: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SummaryCell" forIndexPath:indexPath];
            PKPaymentSummaryItem *summaryItem = self.summaryItems[indexPath.row];
            cell.textLabel.text = summaryItem.label;
            cell.detailTextLabel.text = [self.currencyFormatter stringFromNumber:summaryItem.amount];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            // Only show a line above the last cell
            if (indexPath.row != [self.summaryItems count] - 2) {
                cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
            }
        }
            break;
        case UITableViewSectionDiscountGiftCard:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsZero;
            switch (indexPath.row) {
                case UITableViewDiscountGiftCardSectionDiscount:
                    cell.textLabel.text = @"Add Discount";
                    break;
                case UITableViewDiscountGiftCardSectionGiftCard:
                    cell.textLabel.text = @"Apply Gift Card";
                    break;
                default:
                    break;
            }
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;
        case UITableViewSectionContinue:
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.textLabel.text = [self getCartCTA];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.accessibilityIdentifier = @"button_checkout_continue";
            break;
        default:
            break;
    }
    
    cell.preservesSuperviewLayoutMargins = NO;
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case UITableViewSectionDiscountGiftCard:
            switch (indexPath.row) {
                case UITableViewDiscountGiftCardSectionDiscount:
                    [self addDiscount];
                    break;
                case UITableViewDiscountGiftCardSectionGiftCard:
                    [self applyGiftCard];
                    break;
                default:
                    break;
            }
            break;
        case UITableViewSectionContinue:
            [self proceedToCheckout];
            break;
        default:
            break;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addDiscount
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
                                                          
                                                          BUYDiscount *discount = [self.client.modelManager discountWithCode:[alertController.textFields[0] text]];
                                                          self.checkout.discount = discount;
                                                          
                                                          [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

                                                          [self.client updateCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                                                              
                                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                                              if (error == nil && checkout) {
                                                                  
                                                                  NSLog(@"Successfully added discount");
                                                                  self.checkout = checkout;
                                                                  [self.tableView reloadData];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Gift Card Code" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
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

                                                          [self.client applyGiftCardCode:[alertController.textFields[0] text] toCheckout:self.checkout completion:^(BUYCheckout *checkout, NSError *error) {
                                                              
                                                              [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                                              if (error == nil && checkout) {
                                                                  
                                                                  NSLog(@"Successfully added gift card");
                                                                  self.checkout = checkout;
                                                                  [self.tableView reloadData];
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
    checkoutController.currencyFormatter = self.currencyFormatter;
    [self.navigationController pushViewController:checkoutController animated:YES];
}

- (NSString *)getCartCTA
{
    // [OPTLY - Doc] Determine which CTA text to show the user
    NSString *cartCTAExperimentKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"optlyCartCtaExperimentKey"];
    NSString *userAttributesString = [[NSUserDefaults standardUserDefaults] stringForKey:@"optlyUserAttributes"];
    NSData *userAttributesData = [userAttributesString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *userAttributesDict= nil;
    if (userAttributesData) {
        userAttributesDict = [NSJSONSerialization JSONObjectWithData:userAttributesData options:nil error:nil];
    }
    
    NSString *CTAText = @"Continue";
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    OPTLYVariation *var = nil;
    var = [appDelegate.client activate:cartCTAExperimentKey userId:appDelegate.userId attributes:userAttributesDict];
    
    if (!var) {
        return CTAText;
    }
    
    if([var.variationKey isEqualToString:@"checkout_now"]){
        CTAText = @"Checkout Now";
    } else if([var.variationKey isEqualToString:@"do_it"]) {
        CTAText = @"Do It";
    }
    
    return CTAText;
}

@end
