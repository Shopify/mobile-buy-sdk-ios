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

@interface BUYOptionValueCell()
@property (nonatomic, strong) NSArray *disclosureConstraint;
@property (nonatomic, strong) NSArray *noDisclosureConstraint;
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
		self.layoutMargins = UIEdgeInsetsMake(self.layoutMargins.top, 16.0, self.layoutMargins.bottom, 0);
		
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
		
		self.disclosureConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_selectedImageView]-[_disclosureIndicatorImageView]-(12)-|" options:0 metrics:nil views:views];
		self.noDisclosureConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[_selectedImageView]-(12)-|" options:0 metrics:nil views:views];
		
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
		[NSLayoutConstraint activateConstraints:self.disclosureConstraint];
		[NSLayoutConstraint deactivateConstraints:self.noDisclosureConstraint];
	} else {
		[NSLayoutConstraint deactivateConstraints:self.disclosureConstraint];
		[NSLayoutConstraint activateConstraints:self.noDisclosureConstraint];
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
	self.backgroundColor = theme.style == BUYThemeStyleDark ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
	self.selectedBackgroundView.backgroundColor = theme.style == BUYThemeStyleDark ? BUY_RGB(60, 60, 60) : BUY_RGB(242, 242, 242);
	UIImage *disclosureIndicatorImage;
	switch (theme.style) {
		case BUYThemeStyleDark:
			disclosureIndicatorImage = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:BUY_RGB(76, 76, 76)];
			break;
		case BUYThemeStyleLight:
			disclosureIndicatorImage = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:BUY_RGB(191, 191, 191)];
			break;
		default:
			break;
	}
	_disclosureIndicatorImageView.image = disclosureIndicatorImage;
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.textLabel.text = nil;
	self.selectedImageView.hidden = YES;
}

@end


