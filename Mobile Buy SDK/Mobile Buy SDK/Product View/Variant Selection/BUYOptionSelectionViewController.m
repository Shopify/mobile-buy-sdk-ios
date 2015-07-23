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

#pragma mark - BUYOptionValueCell

@interface BUYOptionValueCell : UITableViewCell <BUYThemeable>
@property (nonatomic, strong) BUYOptionValue *optionValue;
@property (nonatomic, strong) UIImageView *selectedImageView;
@end


@implementation BUYOptionValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		
		self.textLabel.backgroundColor = [UIColor clearColor];
		
		UIImage *selectedImage = [BUYImageKit imageOfPreviousSelectionIndicatorImageWithFrame:CGRectMake(0, 0, 20, 20)];
		selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

		_selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
		_selectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_selectedImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_selectedImageView);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_selectedImageView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
		[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_selectedImageView
									 attribute:NSLayoutAttributeCenterY
									 relatedBy:NSLayoutRelationEqual
										toItem:_selectedImageView.superview
									 attribute:NSLayoutAttributeCenterY
									multiplier:1.f constant:0.f]];

	}
	return self;
}

- (void)setOptionValue:(BUYOptionValue *)optionValue
{
	_optionValue = optionValue;
	
	self.textLabel.text = optionValue.value;
}

- (void)setTheme:(BUYTheme *)theme
{
	self.textLabel.textColor = theme.tintColor;
	self.selectedImageView.tintColor = theme.tintColor;
	
	switch (theme.style) {
		case BUYThemeStyleDark:
			self.backgroundColor = [UIColor blackColor];
			self.contentView.backgroundColor = [UIColor blackColor];
			break;
			
		case BUYThemeStyleLight:
			self.backgroundColor = [UIColor whiteColor];
			break;
			
		default:
			break;
	}
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.textLabel.text = nil;
	self.selectedImageView.hidden = YES;
}

@end

#pragma mark - BUYOptionSelectionViewController

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
	BUYOptionValue *option = self.optionValues[indexPath.row];
	[self.delegate optionSelectionController:self didSelectOption:option];
	
	self.selectedOptionValue = option;
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
