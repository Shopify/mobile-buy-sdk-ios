//
//  BUYProductHeaderCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductHeaderCell.h"
#import "BUYProductVariant.h"

@interface BUYProductHeaderCell ()
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYProductHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.numberOfLines = 2;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.textColor = self.tintColor;
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_priceLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel, _titleLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-(>=10)-[_priceLabel]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_priceLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_priceLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
		
	}
	return self;
}

- (void)setProductVariant:(BUYProductVariant *)productVariant
{
	_productVariant = productVariant;
	
	self.titleLabel.text = productVariant.title;
	
	if (self.currency) {
		NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
		numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		numberFormatter.currencyCode = self.currency;
		self.priceLabel.text = [numberFormatter stringFromNumber:productVariant.price];
	}
}

- (void)setCurrency:(NSString *)currency
{
	_currency = currency;
	
	[self setProductVariant:self.productVariant];
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	
	switch (theme.style) {
		case BUYThemeStyleDark:
			self.titleLabel.textColor = [UIColor whiteColor];
			self.contentView.backgroundColor = [UIColor blackColor];
			break;
			
		case BUYThemeStyleLight:
			self.titleLabel.textColor = [UIColor blackColor];
			self.contentView.backgroundColor = [UIColor whiteColor];
			break;
			
		default:
			break;
	}
}

- (void)layoutSubviews
{
	[super layoutSubviews];
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	
	self.priceLabel.textColor = self.tintColor;
}

@end
