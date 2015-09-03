//
//  BUYVariantOptionBreadCrumbsView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-03.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYVariantOptionBreadCrumbsView.h"
#import "BUYTheme+Additions.h"

@interface BUYVariantOptionBreadCrumbsView ()

@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) UILabel *optionOneLabel;
@property (nonatomic, strong) UILabel *optionTwoLabel;

@end

@implementation BUYVariantOptionBreadCrumbsView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingSmall, kBuyPaddingExtraLarge, kBuyPaddingSmall, kBuyPaddingMedium);
		
		_selectedLabel = [UILabel new];
		_selectedLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_selectedLabel.font = [BUYTheme variantOptionPriceFont];
		_selectedLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];// [BUYTheme variantPriceTextColor];
		_selectedLabel.text = @"Selected:";
		[self addSubview:_selectedLabel];
		
		_optionOneLabel = [UILabel new];
		_optionOneLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionOneLabel.font = _selectedLabel.font;
		_optionOneLabel.textColor = _selectedLabel.textColor;
		[self addSubview:_optionOneLabel];
		
		_optionTwoLabel = [UILabel new];
		_optionTwoLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionTwoLabel.font = _selectedLabel.font;
		_optionTwoLabel.textColor = _selectedLabel.textColor;
		[self addSubview:_optionTwoLabel];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_selectedLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_selectedLabel)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionOneLabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_optionOneLabel)]];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_selectedLabel]-[_optionOneLabel]-(>=padding)-|" options:0 metrics:@{ @"padding" : @(kBuyPaddingMedium) } views:NSDictionaryOfVariableBindings(_selectedLabel, _optionOneLabel)]];
	}
	return self;
}

- (void)setSelectedBuyOptionValues:(NSArray*)optionValues
{
	NSLog(@"%@", optionValues);
	self.optionOneLabel.text = optionValues[0];
	self.optionTwoLabel.text = [optionValues count] > 1 ? [NSString stringWithFormat:@"• optionValues[1]"] : nil;
}

@end
