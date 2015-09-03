//
//  BUYVariantOptionView.m
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

#import "BUYVariantOptionView.h"
#import "BUYOptionValue.h"
#import "UIFont+BUYAdditions.h"

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
		[_optionNameLabel setFont:[BUYTheme variantOptionNameFont]];
		[self addSubview:_optionNameLabel];
		
		// Configure option value label
		_optionValueLabel = [[UILabel alloc] init];
		_optionValueLabel.textColor = self.tintColor;
		_optionValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[_optionValueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
		[_optionValueLabel setFont:[BUYTheme variantOptionValueFont]];
		[self addSubview:_optionValueLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionNameLabel, _optionValueLabel);
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_optionNameLabel][_optionValueLabel]|" options:NSLayoutFormatAlignAllLeading metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_optionNameLabel]|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_optionValueLabel]|" options:0 metrics:nil views:views]];
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
	self.optionNameLabel.textColor = [theme variantOptionNameTextColor];
	self.backgroundColor = [theme backgroundColor];
	self.optionNameLabel.backgroundColor = self.backgroundColor;
	self.optionValueLabel.backgroundColor = self.backgroundColor;
}

@end
