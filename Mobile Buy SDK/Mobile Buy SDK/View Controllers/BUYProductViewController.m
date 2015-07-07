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

@interface BUYProductViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BUYProductViewHeader *productViewHeader;
@property (nonatomic, strong) BUYProductViewFooter *productViewFooter;

@end

@implementation BUYProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
	[self.view addSubview:self.tableView];
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_tableView)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|"
																	  options:0
																	  metrics:nil
																		views:NSDictionaryOfVariableBindings(_tableView)]];
	
	self.productViewHeader = [[BUYProductViewHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 200)];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
	return cell;
}

#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[self.productViewHeader setContentOffset:scrollView.contentOffset];
}

@end
