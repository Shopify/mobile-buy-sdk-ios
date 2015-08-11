//
//  BUYProductHeaderCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductHeaderCell.h"
#import "BUYProductVariant.h"
#import "BUYProduct.h"
#import "UIFont+BUYAdditions.h"

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
		
		self.layoutMargins = UIEdgeInsetsMake(16, self.layoutMargins.left, 16, self.layoutMargins.right);
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody increasedPointSize:4];
		_titleLabel.numberOfLines = 0;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_titleLabel];
		
		UIView *priceView = [[UIView alloc] init];
		priceView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:priceView];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody increasedPointSize:4];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_priceLabel.textAlignment = NSTextAlignmentRight;
		[_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_priceLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[priceView addSubview:_priceLabel];
		
		_comparePriceLabel = [[UILabel alloc] init];
		_comparePriceLabel.textColor = [UIColor colorWithWhite:0.6f alpha:1];
		_comparePriceLabel.textAlignment = NSTextAlignmentRight;
		_comparePriceLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_comparePriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_comparePriceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_comparePriceLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[priceView addSubview:_comparePriceLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(priceView, _titleLabel);
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-[priceView]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[priceView]" options:0 metrics:nil views:views]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeFirstBaseline relatedBy:NSLayoutRelationEqual toItem:_priceLabel attribute:NSLayoutAttributeFirstBaseline multiplier:1.0 constant:0.0]];
		
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0]];
		[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:priceView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0]];
		
		NSDictionary *priceViews = NSDictionaryOfVariableBindings(_priceLabel, _comparePriceLabel);
		[priceView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_priceLabel]|" options:0 metrics:nil views:priceViews]];
		[priceView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_comparePriceLabel]|" options:0 metrics:nil views:priceViews]];
		[priceView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_priceLabel][_comparePriceLabel]|" options:0 metrics:nil views:priceViews]];
	}
	return self;
}

- (void)setProductVariant:(BUYProductVariant *)productVariant
{
	_productVariant = productVariant;
	
	self.titleLabel.text = productVariant.product.title;
	
	if (productVariant.available == NO) {
		self.priceLabel.text = @"Sold Out";
		self.comparePriceLabel.attributedText = nil;
	} else {
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
	
	[self setNeedsLayout];
	[self layoutIfNeeded];
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
			self.backgroundColor = BUY_RGB(26, 26, 26);
			break;
			
		case BUYThemeStyleLight:
			self.titleLabel.textColor = [UIColor blackColor];
			self.backgroundColor = [UIColor whiteColor];
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
