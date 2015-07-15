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

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, BUYVariantSelectionDelegate, BUYPresentationControllerWithNavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *stickyFooterView;
@property (nonatomic, strong) NSLayoutConstraint *footerHeightLayoutConstraint;
@property (nonatomic, strong) NSLayoutConstraint *footerOffsetLayoutConstraint;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewHeaderBackgroundImageView *backgroundImageView;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;
@property (nonatomic, strong) BUYGradientView *topGradientView;
@property (nonatomic, weak) UIImageView *navigationBarShadowImageView;
@property (nonatomic, weak) UIView *navigationBar;
@property (nonatomic, weak) UIView *navigationBarTitle;
@property (nonatomic, strong) NSLayoutConstraint *gradientHeightConstraint;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) BUYProduct *product;
@property (nonatomic, strong) BUYProductVariant *selectedProductVariant;
@property (nonatomic, strong) BUYTheme *theme;
@property (nonatomic, assign) BOOL shouldShowVariantSelector;

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

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.view.tintColor = theme.tintColor;
	UIColor *backgroundColor = [UIColor whiteColor];
	if (theme.style == BUYThemeStyleDark) {
		backgroundColor = [UIColor blackColor];
	}
	self.stickyFooterView.backgroundColor = backgroundColor;
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
	self.productId = productId;
	[self.client getProductById:productId completion:^(BUYProduct *product, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			self.product = product;
			if (completion) {
				completion(error == nil, error);
			}
		});
	}];
}

- (void)setProduct:(BUYProduct *)product
{
	_product = product;
	self.navigationItem.title = _product.title;
	[self.tableView reloadData];
	[self scrollViewDidScroll:self.tableView];
	self.selectedProductVariant = [_product.variants firstObject];
	self.shouldShowVariantSelector = [_product isDefaultVariant] == NO;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (self.theme == nil) {
		BUYTheme *theme = [[BUYTheme alloc] init];
		self.theme = theme;
	}
	
	self.view.backgroundColor = [UIColor clearColor];
	
	self.backgroundImageView = [[BUYProductViewHeaderBackgroundImageView alloc] init];
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
	self.stickyFooterView.translatesAutoresizingMaskIntoConstraints = NO;
	self.stickyFooterView.backgroundColor = [UIColor whiteColor];
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
	[self.view addSubview:self.tableView];
	
	[self.tableView registerClass:[BUYProductHeaderCell class] forCellReuseIdentifier:@"Cell"];
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
	[self.productViewFooter setApplePayButtonVisible:YES]; //self.isApplePayAvailable
	
	
	self.topGradientView = [[BUYGradientView alloc] init];
	self.topGradientView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.topGradientView];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topGradientView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_topGradientView)]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topGradientView
														  attribute:NSLayoutAttributeTop
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeTop
														 multiplier:1.0
														   constant:0]];
	self.gradientHeightConstraint = [NSLayoutConstraint constraintWithItem:self.topGradientView
																 attribute:NSLayoutAttributeHeight
																 relatedBy:NSLayoutRelationEqual
																	toItem:nil
																 attribute:NSLayoutAttributeNotAnAttribute
																multiplier:1.0
																  constant:0];
	[self.view addConstraint:self.gradientHeightConstraint];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self findNavigationBar];
}

- (void)findNavigationBar
{
	for (UIView *view in [self.navigationController.navigationBar subviews]) {
		if (CGRectGetHeight(view.bounds) >= 64) {
			// Get a reference to the UINavigationBar
			self.navigationBar = view;
			self.gradientHeightConstraint.constant = CGRectGetHeight(self.navigationBar.bounds) * 2;
			continue;
		} else if (CGRectGetMinX(view.frame) > 0 && [view.subviews count] == 1 && [view.subviews[0] isKindOfClass:[UILabel class]]) {
			// Get a reference to the UINavigationBar's title
			self.navigationBarTitle = view;
			continue;
		}
	}
	[self scrollViewDidScroll:self.tableView];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.tableView.contentInset = self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, self.tableView.contentInset.left, CGRectGetHeight(self.productViewFooter.frame), self.tableView.contentInset.right);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	// TODO: add logic to determine whether there are variants to select
	NSInteger rows = 0;
	if (self.product) {
		self.shouldShowVariantSelector ? 3 : 2;
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell <BUYThemeable> *theCell = nil;
	
	if (indexPath.row == 0) {
		BUYProductHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
		cell.titleLabel.text = self.product.title;
		cell.priceLabel.text = @"$9.99";
		theCell = cell;
	}
	else if (indexPath.row == 1 && self.shouldShowVariantSelector) {
		BUYProductVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variantCell"];
		cell.productVariant = self.selectedProductVariant;
		theCell = cell;
	}
	else {
		BUYProductDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
		//		cell.descriptionHTML = self.product.htmlDescription;
		cell.descriptionHTML = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non eleifend lectus, nec efficitur velit. Etiam ligula elit, sagittis at velit ac, vehicula efficitur nulla. Vivamus nec nulla vel lacus sollicitudin bibendum. Mauris mattis neque eu arcu scelerisque blandit condimentum vehicula eros. Suspendisse potenti. Proin ornare ut augue eu posuere. Ut volutpat, massa a tempor suscipit, enim augue sodales nulla, non efficitur urna magna vel nunc. Aenean commodo turpis nec orci consectetur, luctus suscipit purus laoreet. Phasellus mi nisi, viverra eu diam in, scelerisque tempor velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc ut tristique arcu, in scelerisque diam. Sed sem dolor, euismod tristique maximus a, viverra sed metus. Donec ex nisi, facilisis at lacus condimentum, vulputate malesuada turpis.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non eleifend lectus, nec efficitur velit. Etiam ligula elit, sagittis at velit ac, vehicula efficitur nulla. Vivamus nec nulla vel lacus sollicitudin bibendum. Mauris mattis neque eu arcu scelerisque blandit condimentum vehicula eros. Suspendisse potenti. Proin ornare ut augue eu posuere. Ut volutpat, massa a tempor suscipit, enim augue sodales nulla, non efficitur urna magna vel nunc. Aenean commodo turpis nec orci consectetur, luctus suscipit purus laoreet. Phasellus mi nisi, viverra eu diam in, scelerisque tempor velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc ut tristique arcu, in scelerisque diam. Sed sem dolor, euismod tristique maximus a, viverra sed metus. Donec ex nisi, facilisis at lacus condimentum, vulputate malesuada turpis.";
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
		optionSelectionViewController.delegate = self;
		BUYOptionSelectionNavigationController *optionSelectionNavigationController = [[BUYOptionSelectionNavigationController alloc] initWithRootViewController:optionSelectionViewController];
		[optionSelectionNavigationController setTheme:self.theme];
		[self presentViewController:optionSelectionNavigationController animated:YES completion:^{}];
	}
}

#pragma mark - BUYVariantSelectionViewControllerDelegate

- (void)variantSelectionController:(BUYVariantSelectionViewController *)controller didSelectVariant:(BUYProductVariant *)variant
{
	[controller dismissViewControllerAnimated:YES completion:NULL];
	self.selectedProductVariant = variant;
	[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)variantSelectionControllerDidCancelVariantSelection:(BUYVariantSelectionViewController *)controller atOptionIndex:(NSUInteger)optionIndex
{
	[controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setSelectedProductVariant:(BUYProductVariant *)selectedProductVariant {
	_selectedProductVariant = selectedProductVariant;
	BUYImage *image = [self.product imageForVariant:selectedProductVariant];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", image.src]];
	[self.productViewHeader.productImageView loadImageWithURL:url
												   completion:^(UIImage *image, NSError *error) {
													   self.backgroundImageView.productImageView.image = image;
													   [self.productViewHeader setContentOffset:self.tableView.contentOffset];
												   }];
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productViewHeader setContentOffset:scrollView.contentOffset];
	CGFloat footerViewHeight = (scrollView.contentOffset.y + scrollView.bounds.size.height) - scrollView.contentSize.height;
	if (footerViewHeight >= 0) {
		self.footerHeightLayoutConstraint.constant = footerViewHeight;
		self.footerOffsetLayoutConstraint.constant = -footerViewHeight;
	}
	
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

- (BUYCart*)cart
{
	BUYCart *cart = [[BUYCart alloc] init];
	[cart addVariant:self.selectedProductVariant];
	return cart;
}

- (void)checkoutWithApplePay
{
	if ([self.productDelegate respondsToSelector:@selector(productViewControllerWillCheckoutViaApplePay:)]) {
		[self.productDelegate productViewControllerWillCheckoutViaApplePay:self];
	}
	[self startApplePayCheckoutWithCart:[self cart]];
}

- (void)checkoutWithShopify
{
	if ([self.productDelegate respondsToSelector:@selector(productViewControllerWillCheckoutViaWeb:)]) {
		[self.productDelegate productViewControllerWillCheckoutViaWeb:self];
	}
	[self startWebCheckoutWithCart:[self cart]];
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
	if ([self.productDelegate respondsToSelector:@selector(productViewControllerDidFinish:)]) {
		[self.productDelegate productViewControllerDidFinish:self];
	}
}

@end
