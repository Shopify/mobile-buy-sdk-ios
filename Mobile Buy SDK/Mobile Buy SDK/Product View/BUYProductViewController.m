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
#import "BUYProductViewHeader.h"
#import "BUYProductImageCollectionViewCell.h"
#import "BUYProductViewHeaderBackgroundImageView.h"
#import "BUYProductViewHeaderOverlay.h"

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, BUYVariantSelectionDelegate, BUYPresentationControllerWithNavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

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
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation BUYProductViewController

@synthesize theme = _theme;

- (instancetype)initWithClient:(BUYClient *)client
{
	self = [super initWithClient:client];
	if (self) {
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
		
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
		
		self.theme = [[BUYTheme alloc] init];
	}
	return self;
}

- (BUYProductView *)productView
{
	if (_productView == nil && self.product != nil) {
		_productView = [[BUYProductView alloc] initWithTheme:self.theme];
		_productView.translatesAutoresizingMaskIntoConstraints = NO;
		_productView.hidden = YES;
		[self.view addSubview:_productView];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
		
		_productView.tableView.delegate = self;
		_productView.tableView.dataSource = self;
		[_productView.productViewFooter setApplePayButtonVisible:self.isApplePayAvailable];
		[_productView.productViewFooter.buyPaymentButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
		[_productView.productViewFooter.checkoutButton addTarget:self action:@selector(checkoutWithShopify) forControlEvents:UIControlEventTouchUpInside];
		
		_productView.productViewHeader.collectionView.delegate = self;
		_productView.productViewHeader.collectionView.dataSource = self;
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
	if (CGSizeEqualToSize(self.productView.productViewHeader.collectionView.bounds.size, CGSizeZero) == NO) {
		[self setSelectedProductVariant:self.selectedProductVariant];
	}
}

- (void)setupNavigationBarAppearance
{
	if (self.navigationBar == nil && _productView) {
		for (UIView *view in [self.navigationController.navigationBar subviews]) {
			if (CGRectGetHeight(view.bounds) >= 64) {
				// Get a reference to the UINavigationBar
				self.navigationBar = view;
				self.navigationBar.alpha = 0;
				continue;
			} else if ([view.subviews count] == 1 && [view.subviews[0] isKindOfClass:[UILabel class]]) {
				// Get a reference to the UINavigationBar's title
				self.navigationBarTitle = view;
				self.navigationBarTitle.alpha = 0;
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
	UIColor *backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
	self.view.backgroundColor = backgroundColor;
	self.productView.theme = theme;
	self.activityIndicatorView.activityIndicatorViewStyle = (_theme.style == BUYThemeStyleDark) ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleGray;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
	BUYPresentationControllerWithNavigationController *presentationController = [[BUYPresentationControllerWithNavigationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
	presentationController.delegate = presentationController;
	presentationController.presentationDelegate = self;
	[presentationController setTheme:self.theme];
	return presentationController;
}

- (void)loadProduct:(NSString *)productId completion:(void (^)(BOOL success, NSError *error))completion
{
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
	});
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
	self.productView.hidden = NO;
	[self setupNavigationBarAppearance];
	[self.activityIndicatorView stopAnimating];
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
		cell.descriptionHTML = self.product.htmlDescription;
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
	
	[self.productView.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)variantSelectionControllerDidCancelVariantSelection:(BUYVariantSelectionViewController *)controller atOptionIndex:(NSUInteger)optionIndex
{
	[controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setSelectedProductVariant:(BUYProductVariant *)selectedProductVariant {
	_selectedProductVariant = selectedProductVariant;
	if (self.headerCell) {
		self.headerCell.productVariant = selectedProductVariant;
		self.variantCell.productVariant = selectedProductVariant;
	}
	if (self.productView.productViewHeader.collectionView) {
		[self.productView.productViewHeader setImageForSelectedVariant:_selectedProductVariant withImages:self.product.images];
		[self updateProductBackgroundImage];
	}
	[self scrollViewDidScroll:self.productView.tableView];
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if ([scrollView isKindOfClass:[UITableView class]]) {
		[self.productView scrollViewDidScroll:scrollView];
		if (self.navigationBar) {
			if (self.navigationBar.alpha != 1 && [self navigationBarThresholdReached] == YES) {
				[(BUYPresentationControllerWithNavigationController*)self.presentationController updateCloseButtonImageWithDarkStyle:YES];
				[self setNeedsStatusBarAppearanceUpdate];
				[UIView animateWithDuration:0.3f
									  delay:0
									options:(UIViewAnimationOptionCurveLinear | UIViewKeyframeAnimationOptionBeginFromCurrentState)
								 animations:^{
									 self.navigationBar.alpha = 1;
									 self.navigationBarTitle.alpha = 1;
								 }
								 completion:NULL];
			} else if (self.navigationBar.alpha != 0 && [self navigationBarThresholdReached] == NO)  {
				[(BUYPresentationControllerWithNavigationController*)self.presentationController updateCloseButtonImageWithDarkStyle:NO];
				[self setNeedsStatusBarAppearanceUpdate];
				[UIView animateWithDuration:0.20f
									  delay:0
									options:(UIViewAnimationOptionCurveLinear | UIViewKeyframeAnimationOptionBeginFromCurrentState)
								 animations:^{
									 self.navigationBar.alpha = 0;
									 self.navigationBarTitle.alpha = 0;
								 }
								 completion:NULL];
			}
			[self.productView.productViewHeader.productViewHeaderOverlay scrollViewDidScroll:scrollView withNavigationBarHeight:CGRectGetHeight(self.navigationBar.bounds)];
		}
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if ([scrollView isKindOfClass:[UICollectionView class]]) {
		[self updateProductBackgroundImage];
	}
}

- (void)updateProductBackgroundImage
{
	NSInteger page = [self.product.images count] > 0 ? 0 : 0;
	if (self.productView.productViewHeader.collectionView.contentSize.width > 0) {
		page =  (int)(self.productView.productViewHeader.collectionView.contentOffset.x / self.productView.productViewHeader.collectionView.frame.size.width);
	}
	if (page >= 0) {
		[self.productView.productViewHeader setCurrentPage:page];
		BUYImage *image = self.product.images[page];
		if (image == nil) {
			image = self.product.images.firstObject;
		}
		[self.productView.backgroundImageView setBackgroundProductImage:image];
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
	if (self.theme.style == BUYThemeStyleDark || [self navigationBarThresholdReached] == NO) {
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

#pragma mark - Collection View Delegate and Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.product.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	BUYProductImageCollectionViewCell *cell = (BUYProductImageCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	BUYImage *image = self.product.images[indexPath.row];
	// if image is nil (no image specified for the variant) choose the first one
	if (image == nil) {
		image = self.product.images.firstObject;
	}
	NSURL *url = [NSURL URLWithString:image.src];
	[cell.productImageView loadImageWithURL:url completion:NULL];
	[cell setContentOffset:self.productView.tableView.contentOffset];
	
	return cell;
}

@end
