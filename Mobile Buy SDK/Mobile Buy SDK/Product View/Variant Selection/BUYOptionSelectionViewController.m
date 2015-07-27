//
//  BUYOptionSelectionViewController.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionSelectionViewController.h"
#import "BUYProduct+Options.h"
#import "BUYOptionValue.h"
#import "BUYTheme.h"
#import "BUYImageKit.h"
#import "BUYOptionValueCell.h"

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
	UIColor *backgroundColor = _theme.style == BUYThemeStyleDark ? BUY_RGBA(26, 26, 26, 0.8f) : BUY_RGBA(255, 255, 255, 0.9f);
	self.view.backgroundColor = backgroundColor;
	self.tableView.separatorColor = (_theme.style == BUYThemeStyleDark) ? BUY_RGB(76, 76, 76) : BUY_RGB(217, 217, 217);;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[BUYOptionValueCell class] forCellReuseIdentifier:@"Cell"];
	self.tableView.tableFooterView = [UIView new];
	
	self.tableView.backgroundColor = self.theme.style == BUYThemeStyleDark ? [UIColor blackColor] : [UIColor whiteColor];
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
	cell.accessoryType = self.isLastOption ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;

	[cell setTheme:self.theme];
	cell.optionValue = optionValue;
	cell.selectedImageView.hidden = ![optionValue isEqual:self.selectedOptionValue];
	
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
