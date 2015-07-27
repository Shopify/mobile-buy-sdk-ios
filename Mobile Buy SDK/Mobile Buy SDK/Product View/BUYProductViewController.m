//
//  BUYProductViewController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYGradientView.h"
#import "BUYImageView.h"
#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerWithNavigationController.h"
#import "BUYProduct+Options.h"
#import "BUYProductViewController.h"
#import "BUYVariantSelectionViewController.h"
#import "BUYImageKit.h"
#import "BUYProductView.h"
#import "BUYProductViewFooter.h"
#import "BUYProductHeaderCell.h"
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, BUYVariantSelectionDelegate, BUYPresentationControllerWithNavigationControllerDelegate>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) BUYProductVariant *selectedProductVariant;
@property (nonatomic, strong) BUYTheme *theme;
@property (nonatomic, assign) BOOL shouldShowVariantSelector;
@property (nonatomic, assign) BOOL shouldShowDescription;
@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, assign) BOOL isLoading;

// views
@property (nonatomic, strong) BUYProductView *productView;
@property (nonatomic, weak) UIView *navigationBar;
@property (nonatomic, weak) UIView *navigationBarTitle;
@property (nonatomic, strong) BUYProductHeaderCell *headerCell;
@property (nonatomic, strong) BUYProductVariantCell *variantCell;

@end

@implementation BUYProductViewController

- (instancetype)initWithClient:(BUYClient *)client
{
	self = [super initWithClient:client];
	if (self) {
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (self.theme == nil) {
		BUYTheme *theme = [[BUYTheme alloc] init];
		self.theme = theme;
	}
}

- (BUYProductView *)productView
{
	if (_productView == nil) {
		_productView = [[BUYProductView alloc] initWithTheme:self.theme];
		_productView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:_productView];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		
		_productView.tableView.delegate = self;
		_productView.tableView.dataSource = self;
		[_productView.productViewFooter setApplePayButtonVisible:self.isApplePayAvailable];
		[_productView.productViewFooter.buyPaymentButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
		[_productView.productViewFooter.checkoutButton addTarget:self action:@selector(checkoutWithShopify) forControlEvents:UIControlEventTouchUpInside];
	}
	return _productView;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self setupNavigationBarAppearance];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self.productView scrollViewDidScroll:self.productView.tableView];
}

- (void)setupNavigationBarAppearance
{
	if (self.navigationBar == nil) {
		for (UIView *view in [self.navigationController.navigationBar subviews]) {
			if (CGRectGetHeight(view.bounds) >= 64) {
				// Get a reference to the UINavigationBar
				self.navigationBar = view;
				continue;
			} else if (CGRectGetMinX(view.frame) > 0 && [view.subviews count] == 1 && [view.subviews[0] isKindOfClass:[UILabel class]]) {
				// Get a reference to the UINavigationBar's title
				self.navigationBarTitle = view;
				continue;
			}
		}
		// Hide the navigation bar
		[self scrollViewDidScroll:self.productView.tableView];
	}
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.view.tintColor = _theme.tintColor;
	UIColor *backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(64, 64, 64) : BUY_RGB(229, 229, 229);
	self.view.backgroundColor = backgroundColor;
	self.productView.theme = theme;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
	BUYPresentationControllerWithNavigationController *presentationController = [[BUYPresentationControllerWithNavigationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	presentationController.delegate = presentationController;
	presentationController.presentationDelegate = self;
	return presentationController;
}

- (void)loadProduct:(NSString *)productId completion:(void (^)(BOOL success, NSError *error))completion
{
	if (productId == nil) {
		completion(NO, [NSError errorWithDomain:BUYShopifyError code:BUYShopifyError_NoProductSpecified userInfo:nil]);
	}
	else {
		self.isLoading = YES;
		
		[self loadShopWithCallback:^(BOOL success, NSError *error) {
			
			if (success) {
				self.productId = productId;
				
				[self.client getProductById:productId completion:^(BUYProduct *product, NSError *error) {
					dispatch_async(dispatch_get_main_queue(), ^{
						self.isLoading = NO;
						
						if (error) {
							completion(NO, error);
						}
						else {
							self.product = product;
							completion(YES, nil);
						}
					});
				}];
			}
			else {
				self.isLoading = NO;
				completion(success, error);
			}
		}];
	}
}

- (void)loadWithProduct:(BUYProduct *)product completion:(void (^)(BOOL success, NSError *error))completion;
{
	if (product == nil) {
		completion(NO, [NSError errorWithDomain:BUYShopifyError code:BUYShopifyError_NoProductSpecified userInfo:nil]);
	}
	else {
		self.product = product;
		
		if (self.shop == nil) {
			self.isLoading = YES;
			
			[self loadShopWithCallback:^(BOOL success, NSError *error) {
				
				self.isLoading = NO;
				completion(success, error);
			}];
		}
		else {
			dispatch_async(dispatch_get_main_queue(), ^{
				completion(YES, nil);
			});
		}
	}
}

- (void)setProduct:(BUYProduct *)product
{
	_product = product;
	self.navigationItem.title = _product.title;
	self.selectedProductVariant = [_product.variants firstObject];
	self.shouldShowVariantSelector = [_product isDefaultVariant] == NO;
	self.shouldShowDescription = ([_product.htmlDescription length] == 0) == NO;
}

- (void)setShop:(BUYShop *)shop
{
	[super setShop:shop];
	[self.productView.productViewFooter setApplePayButtonVisible:self.isApplePayAvailable];
	[self.productView.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger rows = 0;
	if (self.product) {
		rows += 1; // product title and price
		rows += self.shouldShowVariantSelector;
		rows += self.shouldShowDescription;
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell <BUYThemeable> *theCell = nil;
	
	if (indexPath.row == 0) {
		BUYProductHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
		cell.currency = self.shop.currency;
		cell.productVariant = self.selectedProductVariant;
		self.headerCell = cell;
		theCell = cell;
	} else if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		BUYProductVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variantCell"];
		cell.productVariant = self.selectedProductVariant;
		self.variantCell = cell;
		theCell = cell;
	} else if ((indexPath.row == 2 && self.shouldShowDescription) || (indexPath.row == 1 && self.shouldShowVariantSelector == NO && self.shouldShowDescription)) {
		BUYProductDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
		cell.descriptionHTML = [NSString stringWithFormat:@"%@ %@", self.product.htmlDescription, self.product.htmlDescription];
		cell.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.productView.tableView.bounds), 0, 0);
		theCell = cell;
	}
	
	[theCell setTheme:self.theme];
	return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		[self.productView.tableView deselectRowAtIndexPath:indexPath animated:YES];
		// TODO: Get this navigation controller inside the BUYVariantSelectionViewController so it takes care of it's own presentation
		BUYVariantSelectionViewController *optionSelectionViewController = [[BUYVariantSelectionViewController alloc] initWithProduct:self.product theme:self.theme];
		optionSelectionViewController.selectedProductVariant = self.selectedProductVariant;
		optionSelectionViewController.delegate = self;
		BUYOptionSelectionNavigationController *optionSelectionNavigationController = [[BUYOptionSelectionNavigationController alloc] initWithRootViewController:optionSelectionViewController];
		[optionSelectionNavigationController setTheme:self.theme];
		
		[self presentViewController:optionSelectionNavigationController animated:YES completion:nil];
	}
}

#pragma mark - BUYVariantSelectionViewControllerDelegate

- (void)variantSelectionController:(BUYVariantSelectionViewController *)controller didSelectVariant:(BUYProductVariant *)variant
{
	[controller dismissViewControllerAnimated:YES completion:NULL];
	self.selectedProductVariant = variant;
}

- (void)variantSelectionControllerDidCancelVariantSelection:(BUYVariantSelectionViewController *)controller atOptionIndex:(NSUInteger)optionIndex
{
	[controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setSelectedProductVariant:(BUYProductVariant *)selectedProductVariant {
	_selectedProductVariant = selectedProductVariant;
	BUYImage *image = [self.product imageForVariant:selectedProductVariant];
	
	// if image is nil (no image specified for the variant) choose the first one
	if (image == nil) {
		image = self.product.images.firstObject;
	}
	
	[self.productView setProductImage:image];
	self.headerCell.productVariant = selectedProductVariant;
	self.variantCell.productVariant = selectedProductVariant;
	[self scrollViewDidScroll:self.productView.tableView];
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productView scrollViewDidScroll:scrollView];

	if (self.navigationBar) {
		CGFloat navigationBarHeight = CGRectGetHeight(self.navigationBar.bounds);
		CGFloat transitionPosition = CGRectGetHeight(self.productView.tableView.tableHeaderView.bounds) - scrollView.contentOffset.y - (navigationBarHeight * 2);
		transitionPosition = -transitionPosition / navigationBarHeight;
		if (transitionPosition >= 1) {
			transitionPosition = 1;
		} else if (transitionPosition <= 0) {
			transitionPosition = 0;
		}
		self.navigationBar.alpha = transitionPosition;
		self.navigationBarTitle.alpha = transitionPosition;
	}
}

#pragma mark Checkout

- (BUYCart *)cart
{
	BUYCart *cart = [[BUYCart alloc] init];
	[cart addVariant:self.selectedProductVariant];
	return cart;
}

- (BUYCheckout *)checkout
{
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithCart:[self cart]];
	return checkout;
}

- (void)checkoutWithApplePay
{
	[self startApplePayCheckout:[self checkout]];
}

- (void)checkoutWithShopify
{
	[self startWebCheckout:[self checkout]];
}

#pragma mark UIStatusBar appearance

- (UIStatusBarStyle)preferredStatusBarStyle
{
	return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
	return UIStatusBarAnimationFade;
}

#pragma mark BUYPresentationControllerWithNavigationControllerDelegate

- (void)presentationControllerWillDismiss:(UIPresentationController *)presentationController
{
	
}

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController
{
	_product = nil;
	_productId = nil;
	[_productView removeFromSuperview];
	_productView = nil;
}

@end
