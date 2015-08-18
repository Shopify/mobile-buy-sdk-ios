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
#import "BUYTheme+Additions.h"

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
		self.layoutMargins = UIEdgeInsetsMake([BUYTheme paddingLarge], [BUYTheme paddingExtraLarge], [BUYTheme paddingLarge], [BUYTheme paddingLarge]);
		
		UIView *labelContainerView = [[UIView alloc] init];
		labelContainerView.translatesAutoresizingMaskIntoConstraints = NO;
		[labelContainerView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:labelContainerView];
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_titleLabel setFont:[BUYTheme variantOptionValueFont]];
		[labelContainerView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_priceLabel setFont:[BUYTheme variantOptionPriceFont]];
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
		NSDictionary *metricsDictionary = @{ @"paddingMedium" : @([BUYTheme paddingMedium]), @"paddingSmall" : @([BUYTheme paddingSmall]), @"paddingLarge" : @([BUYTheme paddingLarge]), @"paddingExtraLarge" : @([BUYTheme paddingExtraLarge]) };
		
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:views]];
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_priceLabel]|" options:0 metrics:nil views:views]];
		
		_priceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingMedium)-[_titleLabel][_priceLabel]-(paddingMedium)-|" options:0 metrics:metricsDictionary views:views];
		_noPriceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingLarge)-[_titleLabel]-(paddingLarge)-|" options:0 metrics:metricsDictionary views:views];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[labelContainerView]|" options:0 metrics:nil views:views]];
		
		_disclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelContainerView]-(>=paddingSmall)-[_selectedImageView]-[_disclosureIndicatorImageView]-(paddingMedium)-|" options:0 metrics:metricsDictionary views:views];
		_noDisclosureConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelContainerView]-(>=paddingSmall)-[_selectedImageView]-(paddingExtraLarge)-|" options:0 metrics:metricsDictionary views:views];
		
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
	self.backgroundColor = [theme backgroundColor];
	self.selectedBackgroundView.backgroundColor = [theme selectedBackgroundColor];
	self.disclosureIndicatorImageView.image = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:[theme disclosureIndicatorColor]];
	
	self.optionValue = optionValue;
	
	self.titleLabel.text = optionValue.value;
	
	if (productVariant) {
		if (productVariant.available) {
			self.priceLabel.text = [currencyFormatter stringFromNumber:productVariant.price];
			self.priceLabel.textColor = [theme variantPriceTextColor];
		} else {
			self.priceLabel.text = @"Sold Out";
			self.priceLabel.textColor = [theme variantSoldOutTextColor];
		}
		[NSLayoutConstraint activateConstraints:self.priceConstraints];
		[NSLayoutConstraint deactivateConstraints:self.noPriceConstraints];
	} else {
		self.priceLabel.text = nil;
		[NSLayoutConstraint activateConstraints:self.noPriceConstraints];
		[NSLayoutConstraint deactivateConstraints:self.priceConstraints];
	}
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.textLabel.text = nil;
	self.selectedImageView.hidden = YES;
}

@end
