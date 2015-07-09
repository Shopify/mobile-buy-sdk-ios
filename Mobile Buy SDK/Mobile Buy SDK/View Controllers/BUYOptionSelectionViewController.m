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

@interface BUYOptionSelectionViewController ()
@property (nonatomic, strong) NSArray *options;
@end

@implementation BUYOptionSelectionViewController

- (instancetype)initWithOptions:(NSArray *)options
{
	NSParameterAssert(options);
	
	self = [super init];
	
	if (self) {
		self.options = options;
		self.title = [options.firstObject name];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
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
	return self.options.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *option = self.options[indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = option.value;
	cell.textLabel.textColor = self.theme.tintColor;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	BUYOptionValue *option = self.options[indexPath.row];
	[self.delegate optionSelectionController:self didSelectOption:option];
}

@end
