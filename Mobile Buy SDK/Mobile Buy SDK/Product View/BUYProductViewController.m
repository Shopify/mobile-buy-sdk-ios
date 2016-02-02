//
//  BUYProductViewController.m
//  Mobile Buy SDK
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

#import "BUYGradientView.h"
#import "BUYImageView.h"
#import "BUYOptionSelectionNavigationController.h"
#import "BUYPresentationControllerWithNavigationController.h"
#import "BUYProduct+Options.h"
#import "BUYProductViewController.h"
#import "BUYImageKit.h"
#import "BUYProductView.h"
#import "BUYProductViewFooter.h"
#import "BUYProductHeaderCell.h"
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"
#import "BUYProductViewHeader.h"
#import "BUYProductImageCollectionViewCell.h"
#import "BUYProductViewHeaderBackgroundImageView.h"
#import "BUYProductViewHeaderOverlay.h"
#import "BUYTheme+Additions.h"
#import "BUYVariantSelectionViewController.h"
#import "BUYError.h"
#import "BUYShop.h"
#import "BUYImage.h"

CGFloat const BUYMaxProductViewWidth = 414.0; // We max out to the width of the iPhone 6+
CGFloat const BUYMaxProductViewHeight = 640.0;

@interface BUYProductViewController (Private)
@property (nonatomic, strong) BUYCheckout *checkout;
- (void)handleCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)completion;
- (void)postCheckoutCompletion:(BUYCheckout *)checkout error:(NSError *)error;
@end

@interface BUYProductViewController () <BUYThemeable, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, BUYVariantSelectionDelegate, BUYNavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) BUYProductVariant *selectedProductVariant;
@property (nonatomic, strong) BUYTheme *theme;
@property (nonatomic, assign) BOOL shouldShowVariantSelector;
@property (nonatomic, assign) BOOL shouldEnableVariantSelection;
@property (nonatomic, assign) BOOL shouldShowDescription;
@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;

// views
@property (nonatomic, strong) BUYProductView *productView;
@property (nonatomic, weak) UIView *navigationBar;
@property (nonatomic, weak) UILabel *navigationBarTitle;
@property (nonatomic, strong) BUYProductHeaderCell *headerCell;
@property (nonatomic, strong) BUYProductVariantCell *variantCell;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation BUYProductViewController

@synthesize theme = _theme;

- (instancetype)initWithClient:(BUYClient *)client
{
	return [self initWithClient:client theme:nil];
}

- (instancetype)initWithClient:(BUYClient *)client theme:(BUYTheme *)theme
{
	self = [super initWithClient:client];
	if (self) {
		
		self.theme = theme? : [[BUYTheme alloc] init];
		
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
		
		self.allowApplePaySetup = YES;
		
		_activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
		_activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
		_activityIndicatorView.hidesWhenStopped = YES;
		[_activityIndicatorView startAnimating];
		[self.view addSubview:_activityIndicatorView];
		
		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
															  attribute:NSLayoutAttributeCenterY
															  relatedBy:NSLayoutRelationEqual
																 toItem:self.view
															  attribute:NSLayoutAttributeCenterY
															 multiplier:1.0
															   constant:0.0]];
		
		[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
															  attribute:NSLayoutAttributeCenterX
															  relatedBy:NSLayoutRelationEqual
																 toItem:self.view
															  attribute:NSLayoutAttributeCenterX
															 multiplier:1.0
															   constant:0.0]];
		
		
	}
	return self;
}

- (BUYProductView *)productView
{
	if (_productView == nil && self.product != nil && self.shop != nil) {
		_productView = [[BUYProductView alloc] initWithFrame:CGRectMake(0, 0, self.preferredContentSize.width, self.preferredContentSize.height) product:self.product theme:self.theme shouldShowApplePaySetup:self.shouldShowApplePaySetup];
		_productView.translatesAutoresizingMaskIntoConstraints = NO;
		_productView.hidden = YES;
		[self.view addSubview:_productView];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		
		_productView.tableView.delegate = self;
		_productView.tableView.dataSource = self;
		[_productView.productViewFooter setApplePayButtonVisible:self.shouldShowApplePayButton];
		[_productView.productViewFooter.buyPaymentButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
		[_productView.productViewFooter.checkoutButton addTarget:self action:@selector(checkoutWithShopify) forControlEvents:UIControlEventTouchUpInside];
		
		_productView.productViewHeader.collectionView.delegate = self;
		_productView.productViewHeader.collectionView.dataSource = self;
		
		_productView.layoutMargins = UIEdgeInsetsMake(self.productView.layoutMargins.top, self.productView.layoutMargins.left, self.bottomLayoutGuide.length, self.productView.layoutMargins.right);
	}
	return _productView;
}

- (CGSize)preferredContentSize
{
	return CGSizeMake(MIN(BUYMaxProductViewWidth, self.view.bounds.size.width),
					  MIN(BUYMaxProductViewHeight, self.view.bounds.size.height));
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self setupNavigationBarAppearance];
	[self.navigationController setNavigationBarHidden:self.isLoading];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	if (self.productView.hasSetVariantOnCollectionView == NO) {
		if ([self canCollectionViewDrawProductImages] || [self.product.images count] == 0) {
			[self setSelectedProductVariant:self.selectedProductVariant];
			self.productView.hasSetVariantOnCollectionView = YES;
		}
	}
}

- (BOOL)canCollectionViewDrawProductImages
{
	return [self.product.images count] > 0 && CGSizeEqualToSize(self.productView.productViewHeader.collectionView.bounds.size, CGSizeZero) == NO;
}

- (void)setupNavigationBarAppearance
{
	if (self.navigationBar == nil && _productView && self.presentingViewController != nil) {
		for (UIView *view in [self.navigationController.navigationBar subviews]) {
			if (CGRectGetHeight(view.bounds) >= 44) {
				// Get a reference to the UINavigationBar
				self.navigationBar = view;
				self.navigationBar.alpha = 0;
				continue;
			} else if ([view.subviews count] == 1 && [view.subviews[0] isKindOfClass:[UILabel class]]) {
				// Get a reference to the UINavigationBar's title
				self.navigationBarTitle = view.subviews[0];
				self.navigationBarTitle.alpha = 0;
				continue;
			}
		}
		// Hide the navigation bar
		[self scrollViewDidScroll:self.productView.tableView];
	} else if (self.navigationController && _productView && self.presentingViewController == nil) {
		[self.productView setTopInset:CGRectGetHeight(self.navigationController.navigationBar.bounds) + self.navigationController.topLayoutGuide.length];
	}
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.view.tintColor = theme.tintColor;
	self.view.backgroundColor = [theme backgroundColor];
	self.productView.theme = theme;
	self.activityIndicatorView.activityIndicatorViewStyle = [theme activityIndicatorViewStyle];
	[self setNeedsStatusBarAppearanceUpdate];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
	BUYPresentationControllerWithNavigationController *presentationController = [[BUYPresentationControllerWithNavigationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	presentationController.delegate = presentationController;
	presentationController.navigationDelegate = self;
	[presentationController setTheme:self.theme];
	return presentationController;
}

- (void)loadProduct:(NSString *)productId completion:(void (^)(BOOL success, NSError *error))completion
{
	if (productId == nil) {
		if (completion) {
			completion(NO, [NSError errorWithDomain:BUYShopifyError code:BUYShopifyError_NoProductSpecified userInfo:nil]);
		}
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
							if (completion) {
								completion(NO, error);
							}
						}
						else {
							self.product = product;
							if (completion) {
								completion(YES, nil);
							}
						}
					});
				}];
			}
			else {
				self.isLoading = NO;
				if (completion) {
					completion(success, error);
				}
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
		if (self.shop == nil) {
			self.isLoading = YES;
			
			[self loadShopWithCallback:^(BOOL success, NSError *error) {
				self.product = product;
				self.isLoading = NO;
				if (completion) {
					completion(success, error);
				}
			}];
		}
		else {
			self.product = product;
			dispatch_async(dispatch_get_main_queue(), ^{
				if (completion) {
					completion(YES, nil);
				}
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
	self.shouldEnableVariantSelection = self.shouldShowVariantSelector && [_product.variants count] > 1;
	self.shouldShowDescription = ([_product.htmlDescription length] == 0) == NO;
	self.productView.hidden = NO;
	[self setupNavigationBarAppearance];
	[self.activityIndicatorView stopAnimating];
	[self setNeedsStatusBarAppearanceUpdate];
	[self.navigationController setNavigationBarHidden:NO];
}

- (void)setShop:(BUYShop *)shop
{
	[super setShop:shop];
	self.currencyFormatter = [[NSNumberFormatter alloc] init];
	self.currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
	self.currencyFormatter.currencyCode = shop.currency;
	[self.productView.productViewFooter setApplePayButtonVisible:self.shouldShowApplePayButton];
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
		[cell setProductVariant:self.selectedProductVariant withCurrencyFormatter:self.currencyFormatter];
		self.headerCell = cell;
		theCell = cell;
	} else if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		BUYProductVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variantCell"];
		[cell setOptionsForProductVariant:self.selectedProductVariant];
		cell.accessoryType = self.shouldEnableVariantSelection ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
		self.variantCell = cell;
		theCell = cell;
	} else if ((indexPath.row == 2 && self.shouldShowDescription) || (indexPath.row == 1 && self.shouldShowVariantSelector == NO && self.shouldShowDescription)) {
		BUYProductDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
		cell.descriptionHTML = self.product.htmlDescription;
		cell.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.productView.tableView.bounds), 0, 0);
		theCell = cell;
	}
	
	[theCell setTheme:self.theme];
	return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 1 && self.shouldEnableVariantSelection) {
		[self.productView.tableView deselectRowAtIndexPath:indexPath animated:YES];
		BUYVariantSelectionViewController *optionSelectionViewController = [[BUYVariantSelectionViewController alloc] initWithProduct:self.product theme:self.theme];
		optionSelectionViewController.selectedProductVariant = self.selectedProductVariant;
		optionSelectionViewController.delegate = self;
		optionSelectionViewController.currencyFormatter = self.currencyFormatter;
		BUYOptionSelectionNavigationController *optionSelectionNavigationController = [[BUYOptionSelectionNavigationController alloc] initWithRootViewController:optionSelectionViewController];
		[optionSelectionNavigationController setTheme:self.theme];
		[self presentViewController:optionSelectionNavigationController animated:YES completion:nil];
	}
}

#pragma mark - BUYVariantSelectionViewControllerDelegate

- (void)variantSelectionController:(BUYVariantSelectionViewController *)controller didSelectVariant:(BUYProductVariant *)variant
{
	if (self.selectedProductVariant != variant) {
		self.selectedProductVariant = variant;
		[self.productView.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
	[self dismissViewControllerAnimated:YES completion:^{
		[self setNeedsStatusBarAppearanceUpdate];
		[self scrollViewDidScroll:self.productView.tableView];
	}];
}

- (void)variantSelectionControllerDidCancelVariantSelection:(BUYVariantSelectionViewController *)controller atOptionIndex:(NSUInteger)optionIndex
{
	[self dismissViewControllerAnimated:YES completion:^{
		[self setNeedsStatusBarAppearanceUpdate];
	}];
}

- (void)setSelectedProductVariant:(BUYProductVariant *)selectedProductVariant {
	_selectedProductVariant = selectedProductVariant;
	if (self.headerCell) {
		[self.headerCell setProductVariant:selectedProductVariant withCurrencyFormatter:self.currencyFormatter];
		[self.variantCell setOptionsForProductVariant:self.selectedProductVariant];
	}
	if (self.productView.productViewHeader.collectionView) {
		[self.productView.productViewHeader setImageForSelectedVariant:_selectedProductVariant withImages:self.product.images];
		[self.productView updateBackgroundImage:self.product.images];
	}
	if (self.productView.productViewFooter) {
		[self.productView.productViewFooter updateButtonsForProductVariant:selectedProductVariant];
	}
	if (self.productView.tableView) {
		[self scrollViewDidScroll:self.productView.tableView];
	}
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if ([scrollView isKindOfClass:[UITableView class]]) {
		if (self.productView.productViewHeader) {
			[self.productView scrollViewDidScroll:scrollView];
			if (self.navigationBar) {
				CGFloat duration = 0.3f;
				if (self.navigationBar.alpha != 1 && [self navigationBarThresholdReached] == YES) {
					[(BUYNavigationController*)self.navigationController updateCloseButtonImageWithTintColor:YES duration:duration];
					[UIView animateWithDuration:duration
										  delay:0
										options:(UIViewAnimationOptionCurveLinear | UIViewKeyframeAnimationOptionBeginFromCurrentState)
									 animations:^{
										 [self setNeedsStatusBarAppearanceUpdate];
										 self.navigationBar.alpha = 1;
										 self.navigationBarTitle.alpha = 1;
									 }
									 completion:NULL];
				} else if (self.navigationBar.alpha != 0 && [self navigationBarThresholdReached] == NO)  {
					duration = 0.2f;
					[(BUYNavigationController*)self.navigationController updateCloseButtonImageWithTintColor:NO duration:duration];
					[UIView animateWithDuration:duration
										  delay:0
										options:(UIViewAnimationOptionCurveLinear | UIViewKeyframeAnimationOptionBeginFromCurrentState)
									 animations:^{
										 [self setNeedsStatusBarAppearanceUpdate];
										 self.navigationBar.alpha = 0;
										 self.navigationBarTitle.alpha = 0;
									 }
									 completion:NULL];
				}
				[self.productView.productViewHeader.productViewHeaderOverlay scrollViewDidScroll:scrollView withNavigationBarHeight:CGRectGetHeight(self.navigationBar.bounds)];
			}
		} else if (self.productView.productViewHeader == nil && self.navigationBar && self.navigationBar.alpha == 0) {
			// If the product view does not contain an image, inset the productView so its not obstructed with the navigation bar
			[(BUYNavigationController*)self.navigationController updateCloseButtonImageWithTintColor:YES duration:0];
			self.navigationBar.alpha = 1;
			self.navigationBarTitle.alpha = 1;
			CGFloat topInset = 0;
			if (self.presentingViewController) {
				topInset = CGRectGetHeight(self.navigationController.navigationBar.bounds) + self.presentingViewController.topLayoutGuide.length;
			}
			[self.productView setInsets:UIEdgeInsetsMake(topInset, 0, 0, 0) appendToCurrentInset:YES];
		}
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if ([scrollView isKindOfClass:[UICollectionView class]]) {
		[self.productView updateBackgroundImage:self.product.images];
	}
}

#pragma mark Checkout

- (BUYCart *)cart
{
	BUYCart *cart = [[BUYCart alloc] init];
	[cart addVariant:self.selectedProductVariant];
	return cart;
}

- (void)checkoutWithApplePay
{
	if (self.isApplePayAvailable) {
		self.checkout = [[BUYCheckout alloc] initWithCart:[self cart]];
		[self startApplePayCheckout:self.checkout];
	} else {
		[[[PKPassLibrary alloc] init] openPaymentSetup];
	}
}

- (void)checkoutWithShopify
{
	self.checkout = [[BUYCheckout alloc] initWithCart:[self cart]];
	[self startWebCheckout:self.checkout];
}

- (void)startWebCheckout:(BUYCheckout *)checkout
{
	[_productView.productViewFooter.checkoutButton showActivityIndicator:YES];
	
	[self handleCheckout:checkout completion:^(BUYCheckout *checkout, NSError *error) {
		
		[_productView.productViewFooter.checkoutButton showActivityIndicator:NO];
		
		[self postCheckoutCompletion:checkout error:error];
		
		if (error) {
			[self.productView showErrorWithMessage:@"Could not checkout at this time"];
		}
	}];
}

#pragma mark UIStatusBar appearance

- (UIStatusBarStyle)preferredStatusBarStyle
{
	if (self.theme.style == BUYThemeStyleDark || ([self navigationBarThresholdReached] == NO && self.isLoading == NO && self.productView.productViewHeader)) {
		return UIStatusBarStyleLightContent;
	} else if (self.isLoading == YES && self.theme.style == BUYThemeStyleDark && self.productView.productViewHeader) {
		return UIStatusBarStyleLightContent;
	} else {
		return UIStatusBarStyleDefault;
	}
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
	return UIStatusBarAnimationFade;
}

- (BOOL)navigationBarThresholdReached
{
	return self.productView.tableView.contentOffset.y > CGRectGetHeight(self.productView.productViewHeader.bounds) - CGRectGetHeight(self.navigationBar.bounds);
}

#pragma mark BUYPresentationControllerWithNavigationControllerDelegate

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotate {
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

- (void)presentationControllerWillDismiss:(UIPresentationController *)presentationController
{
	
}

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController
{
	if ([self.delegate respondsToSelector:@selector(didDismissViewController:)]) {
		[self.delegate didDismissViewController:self];
	}
	
	_product = nil;
	_productId = nil;
	[_productView removeFromSuperview];
	_productView = nil;
}

#pragma mark - Collection View Delegate and Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.product.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	BUYProductImageCollectionViewCell *cell = (BUYProductImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	BUYImage *image = self.product.images[indexPath.row];
	NSURL *url = [NSURL URLWithString:image.src];
	[cell.productImageView loadImageWithURL:url completion:NULL];
	[cell setContentOffset:self.productView.tableView.contentOffset];
	
	return cell;
}

- (void)presentPortraitInViewController:(UIViewController *)controller
{
	BUYNavigationController *navController = [[BUYNavigationController alloc] initWithRootViewController:self];
	navController.modalPresentationStyle = [BUYPresentationControllerWithNavigationController adaptivePresentationStyle];
	navController.navigationDelegate = self;
	[navController setTheme:self.theme];
	[controller presentViewController:navController animated:YES completion:nil];
}

@end
