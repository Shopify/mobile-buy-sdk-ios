//
//  OptionSelectionViewController.m
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

#import "ImageKit.h"
#import "OptionSelectionViewController.h"
#import "OptionValueCell.h"
#import "Theme+Additions.h"

@interface OptionSelectionViewController ()

@property (nonatomic, strong) NSArray *optionValues;
@property (nonatomic, strong) NSArray *filteredProductVariantsForSelectionOption;

@end

@implementation OptionSelectionViewController

- (instancetype)initWithOptionValues:(NSArray *)optionValues filteredProductVariantsForSelectionOption:(NSArray*)filteredProductVariantsForSelectionOption
{
	NSParameterAssert(optionValues);
	
	self = [super init];
	
	if (self) {
		self.filteredProductVariantsForSelectionOption = filteredProductVariantsForSelectionOption;
		self.optionValues = optionValues;
		self.tableView.estimatedRowHeight = 44.0f;
		self.tableView.rowHeight = UITableViewAutomaticDimension;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[OptionValueCell class] forCellReuseIdentifier:@"Cell"];
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
	OptionValueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.selectedImageView.hidden = ![optionValue isEqual:self.selectedOptionValue];
	if (self.isLastOption) {
		cell.accessoryType = UITableViewCellAccessoryNone;
		BUYProductVariant *productVariant = (BUYProductVariant*)self.filteredProductVariantsForSelectionOption[indexPath.row];
		[cell setOptionValue:optionValue productVariant:productVariant currencyFormatter:self.currencyFormatter];
	} else {
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		[cell setOptionValue:optionValue productVariant:nil currencyFormatter:nil];
	}
	[cell setNeedsLayout];
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
