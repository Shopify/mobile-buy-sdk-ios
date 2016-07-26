//
//  OptionValueCell.m
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

#import "DisclosureIndicatorView.h"
#import "ImageKit.h"
#import "OptionValueCell.h"
#import "Theme+Additions.h"

@interface OptionValueCell()

@property (nonatomic, strong) NSArray *priceConstraints;
@property (nonatomic, strong) NSArray *noPriceConstraints;
@property (nonatomic, strong) NSArray *disclosureConstraints;
@property (nonatomic, strong) NSArray *noDisclosureConstraints;
@property (nonatomic, strong) DisclosureIndicatorView *disclosureIndicatorImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation OptionValueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		UIView *backgroundView = [[UIView alloc] init];
		[self setSelectedBackgroundView:backgroundView];
		
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingLarge, kBuyPaddingExtraLarge, kBuyPaddingLarge, kBuyPaddingLarge);
		
		UIView *labelContainerView = [[UIView alloc] init];
		labelContainerView.translatesAutoresizingMaskIntoConstraints = NO;
		[labelContainerView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:labelContainerView];
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_titleLabel setFont:[Theme variantOptionValueFont]];
		[labelContainerView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_priceLabel setFont:[Theme variantOptionPriceFont]];
		[labelContainerView addSubview:_priceLabel];
		
		UIImage *selectedImage = [ImageKit imageOfPreviousSelectionIndicatorImageWithFrame:CGRectMake(0, 0, 20, 20)];
		selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		
		_selectedImageView = [[UIImageView alloc] initWithImage:selectedImage];
		_selectedImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[_selectedImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_selectedImageView setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self.contentView addSubview:_selectedImageView];
		
		_disclosureIndicatorImageView = [[DisclosureIndicatorView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _priceLabel, labelContainerView, _selectedImageView, _disclosureIndicatorImageView);
		NSDictionary *metricsDictionary = @{ @"paddingMedium" : @(kBuyPaddingMedium), @"paddingSmall" : @(kBuyPaddingSmall), @"paddingExtraLarge" : @(kBuyPaddingExtraLarge) };
		
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:views]];
		[labelContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_priceLabel]|" options:0 metrics:nil views:views]];
		
		_priceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel][_priceLabel]|" options:0 metrics:metricsDictionary views:views];
		_noPriceConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:metricsDictionary views:views];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelContainerView]-|" options:0 metrics:nil views:views]];
		
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

-(void)tintColorDidChange
{
	[super tintColorDidChange];
	self.titleLabel.textColor = self.tintColor;
}

- (void)setSelectedBackgroundViewBackgroundColor:(UIColor *)selectedBackgroundViewBackgroundColor
{
	self.selectedBackgroundView.backgroundColor = selectedBackgroundViewBackgroundColor;
}

- (void)setOptionValue:(BUYOptionValue *)optionValue productVariant:(BUYProductVariant*)productVariant currencyFormatter:(NSNumberFormatter*)currencyFormatter
{
	self.titleLabel.text = optionValue.value;
	
	if (productVariant) {
		if (productVariant.available) {
			self.priceLabel.text = [currencyFormatter stringFromNumber:productVariant.price];
			self.priceLabel.textColor = [Theme variantPriceTextColor];
		} else {
			self.priceLabel.text = NSLocalizedString(@"Sold Out", @"Sold out string displayed on option selector");
			self.priceLabel.textColor = [Theme variantSoldOutTextColor];
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
