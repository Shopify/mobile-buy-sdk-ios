//
//  BUYOptionSelectionViewController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYImageKit.h"
#import "BUYProduct+Options.h"
#import "BUYOptionSelectionViewController.h"
#import "BUYOptionValue.h"
#import "BUYOptionValueCell.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"

@interface BUYOptionSelectionViewController ()
@property (nonatomic, strong) NSArray *optionValues;
@property (nonatomic, weak) BUYTheme *theme;
@property (nonatomic, strong) NSArray *filteredProductVariantsForSelectionOption;
@end

@implementation BUYOptionSelectionViewController

- (instancetype)initWithOptionValues:(NSArray *)optionValues filteredProductVariantsForSelectionOption:(NSArray*)filteredProductVariantsForSelectionOption
{
	NSParameterAssert(optionValues);
	
	self = [super init];
	
	if (self) {
		self.filteredProductVariantsForSelectionOption = filteredProductVariantsForSelectionOption;
		self.optionValues = optionValues;
		self.title = [self.optionValues.firstObject name];
	}
	
	return self;
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.view.backgroundColor = [theme backgroundColor];
	self.tableView.backgroundColor = self.view.backgroundColor;
	self.tableView.separatorColor = [theme separatorColor];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[BUYOptionValueCell class] forCellReuseIdentifier:@"Cell"];
	self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	if ([self isMovingFromParentViewController]) {
		[self.delegate optionSelectionControllerDidBackOutOfChoosingOption:self];
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// clear the previous selection
	[self.tableView reloadData];
}

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.optionValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *optionValue = self.optionValues[indexPath.row];
	BUYOptionValueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.selectedImageView.hidden = ![optionValue isEqual:self.selectedOptionValue];
	if (self.isLastOption) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		BUYProductVariant *productVariant = (BUYProductVariant*)self.filteredProductVariantsForSelectionOption[indexPath.row];
		[cell setOptionValue:optionValue productVariant:productVariant currencyFormatter:self.currencyFormatter theme:self.theme];
	} else {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[cell setOptionValue:optionValue productVariant:nil currencyFormatter:nil theme:self.theme];
	}
	[cell layoutIfNeeded];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *optionValue = self.optionValues[indexPath.row];
	[self.delegate optionSelectionController:self didSelectOptionValue:optionValue];
	
	self.selectedOptionValue = optionValue;
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

@end
