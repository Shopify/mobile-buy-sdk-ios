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
#import "BUYProductViewFooter.h"
#import "BUYProductViewHeader.h"
#import "BUYProductViewHeaderBackgroundImageView.h"
#import "BUYProductHeaderCell.h"
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"
#import "BUYVariantSelectionViewController.h"
#import "BUYImageKit.h"

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, BUYVariantSelectionDelegate, BUYPresentationControllerWithNavigationControllerDelegate>

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) BUYProductVariant *selectedProductVariant;
@property (nonatomic, strong) BUYTheme *theme;
@property (nonatomic, assign) BOOL shouldShowVariantSelector;
@property (nonatomic, assign) BOOL shouldShowDescription;
@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, assign) BOOL isLoading;

// views
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *stickyFooterView;
@property (nonatomic, strong) NSLayoutConstraint *footerHeightLayoutConstraint;
@property (nonatomic, strong) NSLayoutConstraint *footerOffsetLayoutConstraint;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewHeaderBackgroundImageView *backgroundImageView;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;
@property (nonatomic, strong) BUYGradientView *topGradientView;
@property (nonatomic, weak) UIView *navigationBar;
@property (nonatomic, weak) UIView *navigationBarTitle;

@end

@implementation BUYProductViewController

- (instancetype)initWithClient:(BUYClient *)client
{
	self = [super initWithClient:client];
	if (self) {
		
		self.modalPresentationStyle = UIModalPresentationCustom;
		self.transitioningDelegate = self;
		self.productViewHeader = [[BUYProductViewHeader alloc] init];
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
	
	self.backgroundImageView = [[BUYProductViewHeaderBackgroundImageView alloc] init];
	self.backgroundImageView.hidden = _theme.productImageBackground == NO;
	self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.backgroundImageView];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView
														  attribute:NSLayoutAttributeHeight
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeHeight
														 multiplier:1.0
														   constant:0.0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView
														  attribute:NSLayoutAttributeWidth
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeWidth
														 multiplier:1.0
														   constant:0.0]];
	
	self.stickyFooterView = [UIView new];
	self.stickyFooterView.backgroundColor = (self.theme.style == BUYThemeStyleDark) ? [UIColor blackColor] : [UIColor whiteColor];
	self.stickyFooterView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.stickyFooterView];
	
	self.footerHeightLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.stickyFooterView
																	 attribute:NSLayoutAttributeHeight
																	 relatedBy:NSLayoutRelationEqual
																		toItem:nil
																	 attribute:NSLayoutAttributeNotAnAttribute
																	multiplier:1.0
																	  constant:0.0];
	[self.view addConstraint:self.footerHeightLayoutConstraint];
	
	self.footerOffsetLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.stickyFooterView
																	 attribute:NSLayoutAttributeTop
																	 relatedBy:NSLayoutRelationEqual
																		toItem:self.view
																	 attribute:NSLayoutAttributeBottom
																	multiplier:1.0
																	  constant:0.0];
	[self.view addConstraint:self.footerOffsetLayoutConstraint];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stickyFooterView
														  attribute:NSLayoutAttributeWidth
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeWidth
														 multiplier:1.0
														   constant:0.0]];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	self.tableView.estimatedRowHeight = 60.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.tableFooterView = [UIView new];
	self.tableView.layoutMargins = UIEdgeInsetsMake(0, 16, 0, 12);
	[self.view addSubview:self.tableView];
	
	[self.tableView registerClass:[BUYProductHeaderCell class] forCellReuseIdentifier:@"headerCell"];
	[self.tableView registerClass:[BUYProductVariantCell class] forCellReuseIdentifier:@"variantCell"];
	[self.tableView registerClass:[BUYProductDescriptionCell class] forCellReuseIdentifier:@"descriptionCell"];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_tableView)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_tableView)]];
	
	[self.productViewHeader setFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetWidth([[UIScreen mainScreen] bounds]))];
	self.tableView.tableHeaderView = self.productViewHeader;
	
	self.productViewFooter = [[BUYProductViewFooter alloc] initWithTheme:self.theme];
	self.productViewFooter.translatesAutoresizingMaskIntoConstraints = NO;
	[self.productViewFooter.buyPaymentButton addTarget:self action:@selector(checkoutWithApplePay) forControlEvents:UIControlEventTouchUpInside];
	[self.productViewFooter.checkoutButton addTarget:self action:@selector(checkoutWithShopify) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.productViewFooter];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewFooter]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_productViewFooter)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productViewFooter(60)]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_productViewFooter)]];
	[self.productViewFooter setApplePayButtonVisible:self.isApplePayAvailable];
	
	
	self.topGradientView = [[BUYGradientView alloc] init];
	self.topGradientView.topColor = [UIColor colorWithWhite:0 alpha:0.25f];
	self.topGradientView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.topGradientView];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topGradientView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_topGradientView)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topGradientView(height)]|"
																	  options:0
																	  metrics:@{ @"height" : @114 }
																		views:NSDictionaryOfVariableBindings(_topGradientView)]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self setupNavigationBarAppearance];
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
		[self scrollViewDidScroll:self.tableView];
	}
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, self.tableView.contentInset.left, CGRectGetHeight(self.productViewFooter.frame), self.tableView.contentInset.right);
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.view.tintColor = _theme.tintColor;
	UIColor *backgroundColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(64, 64, 64) : BUY_RGB(229, 229, 229);
	self.stickyFooterView.backgroundColor = (_theme.style == BUYThemeStyleDark) ? [UIColor blackColor] : [UIColor whiteColor];;
	self.view.backgroundColor = backgroundColor;
	self.backgroundImageView.hidden = _theme.productImageBackground == NO;
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
	[self.tableView reloadData];
	[self scrollViewDidScroll:self.tableView];
	self.selectedProductVariant = [_product.variants firstObject];
	self.shouldShowVariantSelector = [_product isDefaultVariant] == NO;
	self.shouldShowDescription = ([_product.htmlDescription length] == 0) == NO;
}

- (void)setShop:(BUYShop *)shop
{
	[super setShop:shop];

	[self.productViewFooter setApplePayButtonVisible:self.isApplePayAvailable];

	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
		theCell = cell;
	} else if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		BUYProductVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variantCell"];
		cell.productVariant = self.selectedProductVariant;
		theCell = cell;
	} else if ((indexPath.row == 2 && self.shouldShowDescription) || (indexPath.row == 1 && self.shouldShowVariantSelector == NO && self.shouldShowDescription)) {
		BUYProductDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
		cell.descriptionHTML = self.product.htmlDescription;
		cell.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.tableView.bounds), 0, 0);
		theCell = cell;
	}
	
	[theCell setTheme:self.theme];
	return theCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	[self.tableView reloadData];
//	[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:1 inSection:0]]
//						  withRowAnimation:UITableViewRowAnimationFade];
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
	
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", image.src]];
	[self.productViewHeader.productImageView loadImageWithURL:url
												   completion:^(UIImage *image, NSError *error) {
													   [self.productViewHeader setContentOffset:self.tableView.contentOffset];
													   if (self.backgroundImageView.productImageView.image) {
														   [UIView transitionWithView:self.backgroundImageView.productImageView
																			 duration:imageDuration
																			  options:UIViewAnimationOptionTransitionCrossDissolve
																		   animations:^{
																			   self.backgroundImageView.productImageView.image = image;
																		   }
																		   completion:nil];
													   } else {
														   self.backgroundImageView.productImageView.alpha = 0.0f;
														   self.backgroundImageView.productImageView.image = image;
														   [UIView animateWithDuration:imageDuration
																			animations:^{
																				self.backgroundImageView.productImageView.alpha = 1.0f;
																			}];
													   }
													   [self.productViewHeader setContentOffset:self.tableView.contentOffset];
												   }];
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productViewHeader setContentOffset:scrollView.contentOffset];
	CGFloat footerViewHeight = (scrollView.contentOffset.y + scrollView.bounds.size.height) - scrollView.contentSize.height;
	if (footerViewHeight >= 0 || -footerViewHeight == scrollView.contentSize.height) {
		// when the table view is initially displayed we don't get the correct bounds, so we need to force the footer view to display below the table view on the first view
		if (scrollView.bounds.size.height == 0) {
			footerViewHeight = MIN(CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.tableView.tableHeaderView.bounds), scrollView.contentSize.height);
		}
	} else {
		footerViewHeight = 0;
	}
	self.footerHeightLayoutConstraint.constant = footerViewHeight;
	self.footerOffsetLayoutConstraint.constant = -footerViewHeight;
	
	if (self.navigationBar) {
		CGFloat navigationBarHeight = CGRectGetHeight(self.navigationBar.bounds);
		CGFloat transitionPosition = CGRectGetHeight(self.tableView.tableHeaderView.bounds) - scrollView.contentOffset.y - navigationBarHeight;
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
	self.product = nil;
	self.productId = nil;
	self.productViewHeader.productImageView.image = nil;
}

@end
