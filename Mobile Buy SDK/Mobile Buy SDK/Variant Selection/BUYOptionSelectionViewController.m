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

@interface BUYOptionSelectionViewController ()
@property (nonatomic, strong) NSArray *optionValues;
@property (nonatomic, weak) BUYTheme *theme;
@end

@implementation BUYOptionSelectionViewController

- (instancetype)initWithOptionValues:(NSArray *)optionValues theme:(BUYTheme*)theme
{
	NSParameterAssert(optionValues);
	
	self = [super init];
	
	if (self) {
		self.optionValues = optionValues;
		self.title = [self.optionValues.firstObject name];
		self.theme = theme;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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

#pragma mark - Table View methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.optionValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *option = self.optionValues[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = option.value;
	cell.textLabel.textColor = self.theme.tintColor;
	cell.backgroundColor = self.theme.style == BUYThemeStyleLight ? [UIColor whiteColor] : [UIColor blackColor];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *option = self.optionValues[indexPath.row];
	[self.delegate optionSelectionController:self didSelectOption:option];
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
