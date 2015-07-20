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
@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@end

@implementation BUYProductHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textColor = [UIColor blackColor];
		_comparePriceLabel.font = [UIFont systemFontOfSize:20.0];
		_titleLabel.numberOfLines = 2;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_titleLabel];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.textColor = self.tintColor;
		_comparePriceLabel.font = [UIFont systemFontOfSize:20.0];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_priceLabel];
		
		_comparePriceLabel = [[UILabel alloc] init];
		_comparePriceLabel.textColor = [UIColor colorWithWhite:0.6f alpha:1];
		_comparePriceLabel.font = [UIFont systemFontOfSize:16.0];
		_comparePriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_comparePriceLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel, _titleLabel, _comparePriceLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-(>=10)-[_priceLabel]-|" options:NSLayoutFormatAlignAllBottom metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_comparePriceLabel]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_priceLabel][_comparePriceLabel]-|" options:0 metrics:nil views:views]];
		
	}
	return self;
}

- (void)setProductVariant:(BUYProductVariant *)productVariant
{
	_productVariant = productVariant;
	
	self.titleLabel.text = productVariant.title;
	
	if (self.currency) {
		self.priceLabel.text = [self.currencyFormatter stringFromNumber:productVariant.price];
	}
	
	if (productVariant.compareAtPrice) {
		NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[self.currencyFormatter stringFromNumber:productVariant.compareAtPrice]
																			   attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
		self.comparePriceLabel.attributedText = attributedString;
	}
	else {
		self.comparePriceLabel.attributedText = nil;
	}
}

- (void)setCurrency:(NSString *)currency
{
	_currency = currency;
	
	self.currencyFormatter = [[NSNumberFormatter alloc] init];
	self.currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
	self.currencyFormatter.currencyCode = self.currency;
	
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

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	
	self.priceLabel.textColor = self.tintColor;
}

@end
