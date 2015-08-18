//
//  BUYOptionValueCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-23.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYOptionValueCell.h"
#import "BUYImageKit.h"
#import "BUYOptionValue.h"
#import "BUYTheme+Additions.h"

@interface BUYOptionValueCell()
@property (nonatomic, strong) NSArray *disclosureConstraints;
@property (nonatomic, strong) NSArray *noDisclosureConstraints;
@property (nonatomic, strong) UIImageView *disclosureIndicatorImageView;
@end

@implementation BUYOptionValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIView *backgroundView = [[UIView alloc] init];
		[self setSelectedBackgroundView:backgroundView];
		
		self.textLabel.backgroundColor = [UIColor clearColor];
		self.layoutMargins = UIEdgeInsetsMake(self.layoutMargins.top, [BUYTheme paddingLarge], self.layoutMargins.bottom, 0);
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		
		[self.contentView addSubview:_titleLabel];
		
		UIImage *selectedImage = [BUYImageKit imageOfPreviousSelectionIndicatorImageWithFrame:CGRectMake(0, 0, 20, 20)];
		selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		_selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
		_selectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[_selectedImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_selectedImageView];
		
		_disclosureIndicatorImageView = [[UIImageView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _selectedImageView, _disclosureIndicatorImageView);
		NSDictionary *metricsDictionary = @{ @"paddingPurple" : [NSNumber numberWithDouble:[BUYTheme paddingMedium]] };
		
		self.disclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_selectedImageView]-[_disclosureIndicatorImageView]-(paddingPurple)-|" options:0 metrics:metricsDictionary views:views];
		self.noDisclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_selectedImageView]-(paddingPurple)-|" options:0 metrics:metricsDictionary views:views];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:views]];
		
		[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_selectedImageView
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:_selectedImageView.superview
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0f
																	   constant:0.0f]];
		
		[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_disclosureIndicatorImageView
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:_disclosureIndicatorImageView.superview
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0f
																	   constant:0.0f]];
		
	}
	return self;
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
	self.disclosureIndicatorImageView.hidden = accessoryType != UITableViewCellAccessoryDisclosureIndicator;
	if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		[NSLayoutConstraint activateConstraints:self.disclosureConstraints];
		[NSLayoutConstraint deactivateConstraints:self.noDisclosureConstraints];
	} else {
		[NSLayoutConstraint deactivateConstraints:self.disclosureConstraints];
		[NSLayoutConstraint activateConstraints:self.noDisclosureConstraints];
	}
}

- (void)setOptionValue:(BUYOptionValue *)optionValue
{
	_optionValue = optionValue;
	self.titleLabel.text = optionValue.value;
}

- (void)setTheme:(BUYTheme *)theme
{
	self.titleLabel.textColor = theme.tintColor;
	self.selectedImageView.tintColor = theme.tintColor;
	self.backgroundColor = [theme backgroundColor];
	self.selectedBackgroundView.backgroundColor = [theme selectedBackgroundColor];
	_disclosureIndicatorImageView.image = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:[theme disclosureIndicatorColor]];
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.textLabel.text = nil;
	self.selectedImageView.hidden = YES;
}

@end
