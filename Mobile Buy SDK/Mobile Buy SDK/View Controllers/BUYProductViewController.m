//
//  BUYProductViewController.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewController.h"
#import "BUYProductViewFooter.h"
#import "BUYProductViewHeader.h"
#import "BUYProductHeaderCell.h"
#import "BUYProductVariantCell.h"
#import "BUYProductDescriptionCell.h"

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;
@property (nonatomic, strong) BUYProduct *product;

@end

@implementation BUYProductViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
	
	self.productViewHeader = [[BUYProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), CGRectGetWidth([[UIScreen mainScreen] bounds]))];
	self.tableView.tableHeaderView = self.productViewHeader;
	
	self.productViewFooter = [[BUYProductViewFooter alloc] init];
	self.productViewFooter.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.productViewFooter];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_productViewFooter]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_productViewFooter)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productViewFooter(60)]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_productViewFooter)]];
	
	[self.productViewFooter setApplePayButtonVisible:YES];
	
	[self.client getProductById:@"595444547" completion:^(BUYProduct *product, NSError *error) {
		self.product = product;
		[self.tableView reloadData];
	}];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.tableView.separatorInset = self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, CGRectGetHeight(self.productViewFooter.frame), self.tableView.contentInset.right);
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
	return self.product ? 3 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		BUYProductHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
		cell.tintColor = [UIColor redColor];
		
		cell.titleLabel.text = @"Products with a really loooooong title";
		cell.priceLabel.text = @"$9.99";
		return cell;
	}
	else if (indexPath.row == 1) {
		BUYProductVariantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"variantCell"];
		cell.tintColor = [UIColor redColor];
		cell.productVariant = self.product.variants.firstObject;
		return cell;
	}
	else {
		BUYProductDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
		cell.tintColor = [UIColor redColor];
		cell.descriptionHTML = self.product.htmlDescription;
		cell.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.tableView.bounds), 0, 0);
		return cell;
	}
 
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productViewHeader setContentOffset:scrollView.contentOffset];
}

@end
