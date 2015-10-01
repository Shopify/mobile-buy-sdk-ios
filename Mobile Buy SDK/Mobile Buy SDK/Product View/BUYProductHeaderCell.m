//
//  BUYProductHeaderCell.m
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

#import "BUYProductHeaderCell.h"
#import "BUYProductVariant.h"
#import "BUYProduct.h"
#import "UIFont+BUYAdditions.h"
#import "BUYTheme+Additions.h"

@interface BUYProductHeaderCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *comparePriceLabel;
@property (nonatomic, strong) BUYTheme *theme;
@property (nonatomic, strong) BUYProductVariant *productVariant;

@end

@implementation BUYProductHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingExtraLarge, self.layoutMargins.left, kBuyPaddingExtraLarge, self.layoutMargins.right);
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.font = [BUYTheme productTitleFont];
		_titleLabel.numberOfLines = 0;
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_titleLabel];
		
		UIView *priceView = [[UIView alloc] init];
		priceView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:priceView];
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.font = [BUYTheme productPriceFont];
		_priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_priceLabel.textAlignment = NSTextAlignmentRight;
		[_priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_priceLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
		[priceView addSubview:_priceLabel];
		
		_comparePriceLabel = [[UILabel alloc] init];
		_comparePriceLabel.textColor = [BUYTheme comparePriceTextColor];
		_comparePriceLabel.textAlignment = NSTextAlignmentRight;
		_comparePriceLabel.font = [BUYTheme productComparePriceFont];
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

- (void)setProductVariant:(BUYProductVariant *)productVariant withCurrencyFormatter:(NSNumberFormatter*)currencyFormatter
{
	_productVariant = productVariant;
	
	self.titleLabel.text = productVariant.product.title;
	
	if (currencyFormatter) {
		self.priceLabel.text = [currencyFormatter stringFromNumber:productVariant.price];
	}
	
	if (productVariant.available == YES && productVariant.compareAtPrice) {
		NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[currencyFormatter stringFromNumber:productVariant.compareAtPrice]
																			   attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)}];
		self.comparePriceLabel.attributedText = attributedString;
		self.comparePriceLabel.textColor = [BUYTheme comparePriceTextColor];
	} else if (productVariant.available == NO) {
		self.comparePriceLabel.text = @"Sold Out";
		self.comparePriceLabel.textColor = [BUYTheme variantSoldOutTextColor];
	} else {
		self.comparePriceLabel.attributedText = nil;
	}
	
	[self setNeedsLayout];
	[self layoutIfNeeded];
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.backgroundColor = [theme backgroundColor];
	self.titleLabel.backgroundColor = self.priceLabel.backgroundColor = self.comparePriceLabel.backgroundColor = self.backgroundColor;
	self.titleLabel.textColor = [theme productTitleColor];
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	self.priceLabel.textColor = self.tintColor;
}

@end
