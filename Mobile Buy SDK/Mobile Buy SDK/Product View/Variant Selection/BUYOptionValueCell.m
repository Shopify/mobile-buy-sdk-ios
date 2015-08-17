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
#import "BUYProductVariant.h"
#import "BUYTheme.h"

@interface BUYOptionValueCell()
@property (nonatomic, strong) NSArray *priceConstraints;
@property (nonatomic, strong) NSArray *noPriceConstraints;
@property (nonatomic, strong) NSArray *disclosureConstraints;
@property (nonatomic, strong) NSArray *noDisclosureConstraints;
@property (nonatomic, strong) UIImageView *disclosureIndicatorImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
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
		
		UIView *labelContainerView = [[UIView alloc] init];
		labelContainerView.translatesAutoresizingMaskIntoConstraints = NO;
		[labelContainerView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:labelContainerView];
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_priceLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
		[labelContainerView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_priceLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
		[labelContainerView addSubview:_priceLabel];
		
		UIImage *selectedImage = [BUYImageKit imageOfPreviousSelectionIndicatorImageWithFrame:CGRectMake(0, 0, 20, 20)];
		selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		_selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
		_selectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[_selectedImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_selectedImageView setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_selectedImageView];
		
		_disclosureIndicatorImageView = [[UIImageView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _priceLabel, labelContainerView, _selectedImageView, _disclosureIndicatorImageView);
		
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:views]];
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_priceLabel]|" options:0 metrics:nil views:views]];
		
		_priceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel][_priceLabel]|" options:0 metrics:nil views:views];
		_noPriceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:views];
		
		NSDictionary *metricsDictionary = @{ @"padding" : @12 };
		
		_disclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelContainerView]-(>=padding)-[_selectedImageView]-[_disclosureIndicatorImageView]-(padding)-|" options:0 metrics:metricsDictionary views:views];
		_noDisclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelContainerView]-(>=padding)-[_selectedImageView]-(padding)-|" options:0 metrics:metricsDictionary views:views];
		
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:labelContainerView
																	 attribute:NSLayoutAttributeCenterY
																	 relatedBy:NSLayoutRelationEqual
																		toItem:labelContainerView.superview
																	 attribute:NSLayoutAttributeCenterY
																	multiplier:1.0f
																	  constant:0.0f]];
		
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_selectedImageView
																	 attribute:NSLayoutAttributeCenterY
																	 relatedBy:NSLayoutRelationEqual
																		toItem:_selectedImageView.superview
																	 attribute:NSLayoutAttributeCenterY
																	multiplier:1.0f
																	  constant:0.0f]];
		
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_disclosureIndicatorImageView
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

- (void)setOptionValue:(BUYOptionValue *)optionValue productVariant:(BUYProductVariant*)productVariant currencyFormatter:(NSNumberFormatter*)currencyFormatter theme:(BUYTheme *)theme
{
	self.titleLabel.textColor = theme.tintColor;
	self.selectedImageView.tintColor = theme.tintColor;
	self.backgroundColor = theme.style == BUYThemeStyleDark ? BUY_RGB(26, 26, 26) : BUY_RGB(255, 255, 255);
	self.selectedBackgroundView.backgroundColor = theme.style == BUYThemeStyleDark ? BUY_RGB(60, 60, 60) : BUY_RGB(242, 242, 242);
	self.disclosureIndicatorImageView.image = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:theme.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191)];
	
	self.optionValue = optionValue;
	
	self.titleLabel.text = optionValue.value;
	
	if (productVariant) {
		if (productVariant.available) {
			self.priceLabel.text = [currencyFormatter stringFromNumber:productVariant.price];
			self.priceLabel.textColor = (theme.style == BUYThemeStyleDark) ? BUY_RGB(229, 229, 229) : BUY_RGB(51, 51, 51);
		} else {
			self.priceLabel.text = @"Sold Out";
			self.priceLabel.textColor = [UIColor redColor];
		}
		[NSLayoutConstraint activateConstraints:self.priceConstraints];
		[NSLayoutConstraint deactivateConstraints:self.noPriceConstraints];
	} else {
		self.priceLabel.text = nil;
		[NSLayoutConstraint deactivateConstraints:self.priceConstraints];
		[NSLayoutConstraint activateConstraints:self.noPriceConstraints];
	}
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	self.textLabel.text = nil;
	self.selectedImageView.hidden = YES;
}

@end


