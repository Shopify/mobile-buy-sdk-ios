//
//  BUYVariantOptionView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-05-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYVariantOptionView.h"
#import "BUYOptionValue.h"

@interface BUYVariantOptionView ()

@property (nonatomic, strong) UILabel *optionNameLabel;
@property (nonatomic, strong) UILabel *optionValueLabel;

@end

@implementation BUYVariantOptionView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.userInteractionEnabled = NO;
		
		// Configure option label
		_optionNameLabel = [[UILabel alloc] init];
		_optionNameLabel.textColor = [UIColor colorWithWhite:0.6f alpha:1];
		_optionNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_optionNameLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]];
		[self addSubview:_optionNameLabel];
		
		// Configure option value label
		_optionValueLabel = [[UILabel alloc] init];
		_optionValueLabel.textColor = self.tintColor;
		_optionValueLabel.translatesAutoresizingMaskIntoConstraints = NO;

		[_optionValueLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
		[self addSubview:_optionValueLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionNameLabel, _optionValueLabel);
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_optionNameLabel]-(3)-[_optionValueLabel]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionNameLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionValueLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionNameLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionValueLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
	}
	return self;
}

- (void)setTextForOptionValue:(BUYOptionValue*)optionValue {
	if (optionValue) {
		self.optionNameLabel.text = [optionValue.name uppercaseString];
		self.optionValueLabel.text = optionValue.value;
	} else {
		self.optionNameLabel.text = nil;
		self.optionValueLabel.text = nil;
	}
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	self.optionValueLabel.textColor = self.tintColor;
}

- (void)setTheme:(BUYTheme *)theme
{
	self.optionNameLabel.textColor = (theme.style == BUYThemeStyleDark) ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191);
}

@end
