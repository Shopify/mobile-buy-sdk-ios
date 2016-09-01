//
//  MasterViewController.m
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

#import "ProductListViewController.h"
#import "ProductViewController.h"
#import "Theme.h"
#import "ShippingRatesTableViewController.h"
#import "ProductViewControllerToggleTableViewCell.h"
#import "ProductViewControllerThemeStyleTableViewCell.h"
#import "ProductViewControllerThemeTintColorTableViewCell.h"

#import <Buy/Buy.h>

//#warning - Enter your merchant ID
// Adding a merchant ID will show Apple Pay in the BUYProductViewController (on supported devices)
#define MERCHANT_ID @""

@interface ProductListViewController () <UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) BUYClient *client;
@property (nonatomic, strong) BUYCollection *collection;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSOperation *collectionOperation;
@property (nonatomic, strong) NSOperation *checkoutCreationOperation;

@property (nonatomic, assign) BOOL demoProductViewController;
@property (nonatomic, assign) ThemeStyle themeStyle;
@property (nonatomic, strong) NSArray *themeTintColors;
@property (nonatomic, assign) NSInteger themeTintColorSelectedIndex;
@property (nonatomic, assign) BOOL showsProductImageBackground;
@property (nonatomic, assign) BOOL presentViewController;

@end

@implementation ProductListViewController

- (instancetype)initWithClient:(BUYClient *)client collection:(BUYCollection*)collection
{
    NSParameterAssert(client);
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.client = client;
        self.collection = collection;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.collection) {
        self.title = self.collection.title;
    } else {
        self.title = @"All Products";
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[ProductViewControllerToggleTableViewCell class] forCellReuseIdentifier:@"ProductViewControllerToggleCell"];
    [self.tableView registerClass:[ProductViewControllerThemeStyleTableViewCell class] forCellReuseIdentifier:@"ThemeStyleCell"];
    [self.tableView registerClass:[ProductViewControllerThemeTintColorTableViewCell class] forCellReuseIdentifier:@"ThemeTintColorCell"];
    [self.tableView registerClass:[ProductViewControllerToggleTableViewCell class] forCellReuseIdentifier:@"ThemeShowsBackgroundToggleCell"];
    [self.tableView registerClass:[ProductViewControllerToggleTableViewCell class] forCellReuseIdentifier:@"ProductViewControllerPresentViewControllerToggleCell"];
    
    self.themeTintColors = @[[UIColor colorWithRed:0.48f green:0.71f blue:0.36f alpha:1.0f], [UIColor colorWithRed:0.88 green:0.06 blue:0.05 alpha:1], [UIColor colorWithRed:0.02 green:0.54 blue:1 alpha:1]];
    self.themeTintColorSelectedIndex = 0;
    self.showsProductImageBackground = YES;
    self.presentViewController = YES;
    
    if (self.collection) {
        // If we're presenting with a collection, add the ability to sort
        UIBarButtonItem *sortBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(presentCollectionSortOptions:)];
        self.navigationItem.rightBarButtonItem = sortBarButtonItem;
        [self getCollectionWithSortOrder:BUYCollectionSortCollectionDefault];
    } else {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self.client getProductsPage:1 completion:^(NSArray *products, NSUInteger page, BOOL reachedEnd, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            if (error == nil && products) {
                self.products = products;
                [self.tableView reloadData];
            }
            else {
                NSLog(@"Error fetching products: %@", error);
            }
        }];
    }
}

- (void)dealloc
{
    [self.checkoutCreationOperation cancel];
    [self.collectionOperation cancel];
}

- (void)presentCollectionSortOptions:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Collection Sort" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Default" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortCollectionDefault];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Best Selling" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortBestSelling];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Title - Ascending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortTitleAscending];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Title - Descending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortTitleDescending];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Price - Ascending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortPriceAscending];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Price - Descending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortPriceDescending];
    }]];
    
    /*  Note: The BUYCollectionSortCreatedAscending and BUYCollectionSortCreatedDescending are currently not support
    [alertController addAction:[UIAlertAction actionWithTitle:@"BUYCollectionSortCreatedAscending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortCreatedAscending];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"BUYCollectionSortCreatedDescending" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getCollectionWithSortOrder:BUYCollectionSortCreatedDescending];
    }]];
     */
    
    if (self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
        popPresenter.barButtonItem = (UIBarButtonItem*)sender;
    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)getCollectionWithSortOrder:(BUYCollectionSort)collectionSort
{
    [self.collectionOperation cancel];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.collectionOperation = [self.client getProductsPage:1 inCollection:self.collection.identifier withTags:nil sortOrder:collectionSort completion:^(NSArray<BUYProduct *> * _Nullable products, NSUInteger page, BOOL reachedEnd, NSError * _Nullable error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error == nil && products) {
            self.products = products;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error fetching products: %@", error);
        }
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if (self.demoProductViewController) {
                return 5;
            } else {
                return 1;
            }
            break;
        case 1:
            return self.products.count;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: {
                    ProductViewControllerToggleTableViewCell *toggleCell = (ProductViewControllerToggleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ProductViewControllerToggleCell" forIndexPath:indexPath];
                    toggleCell.textLabel.text = @"Demo BUYProductViewController";
                    [toggleCell.toggleSwitch setOn:self.demoProductViewController];
                    [toggleCell.toggleSwitch addTarget:self action:@selector(toggleProductViewControllerDemo:) forControlEvents:UIControlEventValueChanged];
                    cell = toggleCell;
                }
                    break;
                case 1: {
                    ProductViewControllerThemeStyleTableViewCell *themeCell = (ProductViewControllerThemeStyleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ThemeStyleCell" forIndexPath:indexPath];
                    themeCell.segmentedControl.selectedSegmentIndex = self.themeStyle;
                    [themeCell.segmentedControl addTarget:self action:@selector(toggleProductViewControllerThemeStyle:) forControlEvents:UIControlEventValueChanged];
                    cell = themeCell;
                }
                    break;
                case 2: {
                    ProductViewControllerThemeTintColorTableViewCell *themeCell = (ProductViewControllerThemeTintColorTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ThemeTintColorCell" forIndexPath:indexPath];
                    themeCell.segmentedControl.selectedSegmentIndex = self.themeTintColorSelectedIndex;
                    [themeCell.segmentedControl addTarget:self action:@selector(toggleProductViewControllerTintColorSelection:) forControlEvents:UIControlEventValueChanged];
                    cell = themeCell;
                }
                    break;
                case 3: {
                    ProductViewControllerToggleTableViewCell *toggleCell = (ProductViewControllerToggleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ThemeShowsBackgroundToggleCell" forIndexPath:indexPath];
                    toggleCell.textLabel.text = @"Product Image in Background";
                    [toggleCell.toggleSwitch setOn:self.showsProductImageBackground];
                    [toggleCell.toggleSwitch addTarget:self action:@selector(toggleShowsProductImageBackground:) forControlEvents:UIControlEventValueChanged];
                    cell = toggleCell;
                }
                    break;
                case 4: {
                    ProductViewControllerToggleTableViewCell *toggleCell = (ProductViewControllerToggleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"ProductViewControllerPresentViewControllerToggleCell" forIndexPath:indexPath];
                    toggleCell.textLabel.text = @"Modal Presentation";
                    [toggleCell.toggleSwitch setOn:self.presentViewController];
                    [toggleCell.toggleSwitch addTarget:self action:@selector(togglePresentViewController:) forControlEvents:UIControlEventValueChanged];
                    cell = toggleCell;
                    
                }
                    break;
                default:
                    break;
            }
            break;
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            BUYProduct *product = self.products[indexPath.row];
            cell.textLabel.text = product.title;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        BUYProduct *product = self.products[indexPath.row];
        if (self.demoProductViewController) {
            [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self demoProductViewControllerWithProduct:product];
        } else {
            [self demoNativeFlowWithProduct:product];
        }
    }
}

- (void)demoNativeFlowWithProduct:(BUYProduct*)product
{
    if (self.checkoutCreationOperation.executing) {
        [self.checkoutCreationOperation cancel];
    }
    
    BUYCart *cart = [self.client.modelManager insertCartWithJSONDictionary:nil];
    [cart addVariant:product.variants.firstObject];
    
    BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:cart.modelManager cart:cart];
    
    // Apply billing and shipping address, as well as email to the checkout
    checkout.shippingAddress = [self address];
    checkout.billingAddress = [self address];
    checkout.email = @"banana@testasaurus.com";
    
    self.client.urlScheme = @"advancedsample://";
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.checkoutCreationOperation = [self.client createCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error == nil && checkout) {
            
            ShippingRatesTableViewController *shippingController = [[ShippingRatesTableViewController alloc] initWithClient:self.client checkout:checkout];
            [self.navigationController pushViewController:shippingController animated:YES];
        }
        else {
            NSLog(@"Error creating checkout: %@", error);
        }
    }];
}

- (void)demoProductViewControllerWithProduct:(BUYProduct*)product
{
    ProductViewController *productViewController = [self productViewController];
    [productViewController loadWithProduct:product completion:^(BOOL success, NSError *error) {
        if (error == nil) {
            if (self.presentViewController) {
                [productViewController presentPortraitInViewController:self];
            } else {
                [self.navigationController pushViewController:productViewController animated:YES];
            }
        }
    }];
}

-(ProductViewController*)productViewController
{
    Theme *theme = [Theme new];
    theme.style = self.themeStyle;
    theme.tintColor = self.themeTintColors[self.themeTintColorSelectedIndex];
    theme.showsProductImageBackground = self.showsProductImageBackground;
    ProductViewController *productViewController = [[ProductViewController alloc] initWithClient:self.client theme:theme];
    productViewController.merchantId = MERCHANT_ID;
    return productViewController;
}

- (void)toggleProductViewControllerDemo:(UISwitch*)toggleSwitch
{
    self.demoProductViewController = toggleSwitch.on;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // Add 3D Touch peek and pop for product previewing
    if (self.demoProductViewController == YES && [[UITraitCollection class] respondsToSelector:@selector(traitCollectionWithForceTouchCapability:)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
    } else if ([[UITraitCollection class] respondsToSelector:@selector(traitCollectionWithForceTouchCapability:)] && self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
    }
}

- (void)toggleProductViewControllerThemeStyle:(UISegmentedControl*)segmentedControl
{
    self.themeStyle = segmentedControl.selectedSegmentIndex;
}

- (void)toggleProductViewControllerTintColorSelection:(UISegmentedControl*)segmentedControl
{
    self.themeTintColorSelectedIndex = segmentedControl.selectedSegmentIndex;
}

- (void)toggleShowsProductImageBackground:(UISwitch*)toggleSwitch
{
    self.showsProductImageBackground = toggleSwitch.on;
}

- (void)togglePresentViewController:(UISwitch*)toggleSwitch
{
    self.presentViewController = toggleSwitch.on;
}

- (BUYAddress *)address
{
    BUYAddress *address = [self.client.modelManager insertAddressWithJSONDictionary:nil];
    address.address1 = @"150 Elgin Street";
    address.address2 = @"8th Floor";
    address.city = @"Ottawa";
    address.company = @"Shopify Inc.";
    address.firstName = @"Egon";
    address.lastName = @"Spengler";
    address.phone = @"1-555-555-5555";
    address.countryCode = @"CA";
    address.provinceCode = @"ON";
    address.zip = @"K1N5T5";
    return address;
}

#pragma mark - UIViewControllerPreviewingDelegate

-(UIViewController*)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil || self.demoProductViewController == NO) {
        return nil;
    }
    
    BUYProduct *product = self.products[indexPath.row];
    ProductViewController *productViewController = [self productViewController];
    [productViewController loadWithProduct:product completion:NULL];
    
    previewingContext.sourceRect = cell.frame;
    
    return productViewController;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    if (self.presentViewController) {
        [self presentViewController:viewControllerToCommit animated:YES completion:NULL];
    } else {
        [self.navigationController pushViewController:viewControllerToCommit animated:YES];
    }
}

@end
