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

@property (nonatomic, strong) UILabel *optionOneLabel;
@property (nonatomic, strong) UILabel *optionTwoLabel;

@property (nonatomic, strong) NSArray *oneOptionConstraints;
@property (nonatomic, strong) NSArray *twoOptionsConstraints;

@end

@implementation BUYVariantOptionBreadCrumbsView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingSmall, kBuyPaddingExtraLarge, kBuyPaddingSmall, kBuyPaddingMedium);
		
		_optionOneLabel = [UILabel new];
		_optionOneLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionOneLabel.font = [BUYTheme variantOptionPriceFont];
		_optionOneLabel.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1];// [BUYTheme variantPriceTextColor];
		[self addSubview:_optionOneLabel];
		
		_optionTwoLabel = [UILabel new];
		_optionTwoLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionTwoLabel.font = _optionOneLabel.font;
		_optionTwoLabel.textColor = _optionOneLabel.textColor;
		_optionTwoLabel.alpha = 0;
		[_optionTwoLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self addSubview:_optionTwoLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionOneLabel, _optionTwoLabel);
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionOneLabel]-|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionTwoLabel]-|" options:0 metrics:nil views:views]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0]];
		
		NSLayoutConstraint *optionOneTrailingConstraint = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
		NSLayoutConstraint *optionTwoLeadingConstraintHidden = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_optionTwoLabel attribute:NSLayoutAttributeLeading multiplier:2.0 constant:-4];
		_oneOptionConstraints = @[optionOneTrailingConstraint, optionTwoLeadingConstraintHidden];
		
		NSLayoutConstraint *optionTwoLeadingConstraint = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_optionTwoLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-4];
		NSLayoutConstraint *optionTwoTrailingConstraint = [NSLayoutConstraint constraintWithItem:_optionTwoLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
		_twoOptionsConstraints = @[optionTwoLeadingConstraint, optionTwoTrailingConstraint];
	}
	return self;
}

- (void)setSelectedBuyOptionValues:(NSArray*)optionValues
{
	if ([optionValues count]) {
		self.optionOneLabel.text = [NSString stringWithFormat:@"Selected: %@", optionValues[0]];
		if ([_oneOptionConstraints[0] isActive] == NO && [self.optionTwoLabel.text length] == 0) {
			[NSLayoutConstraint activateConstraints:_oneOptionConstraints];
			[self layoutIfNeeded];
		}
	}
	if ([self.optionTwoLabel.text length] == 0) {
		self.optionTwoLabel.text = [optionValues count] > 1 ? [NSString stringWithFormat:@"• %@", optionValues[1]] : nil;
	}
	if ([optionValues count] > 1) {
		[NSLayoutConstraint deactivateConstraints:_oneOptionConstraints];
		[NSLayoutConstraint activateConstraints:_twoOptionsConstraints];
	} else {
		[NSLayoutConstraint deactivateConstraints:_twoOptionsConstraints];
		[NSLayoutConstraint activateConstraints:_oneOptionConstraints];
	}
	[UIView animateWithDuration:0.3
						  delay:0
						options:(UIViewAnimationOptionBeginFromCurrentState | 7 << 16)
					 animations:^{
						 if ([_twoOptionsConstraints[0] isActive]) {
							 self.optionTwoLabel.alpha = 1;
						 } else {
							 self.optionTwoLabel.alpha = 0;
						 }
						 [self layoutIfNeeded];
					 }
					 completion:^(BOOL finished) {
						 if ([_oneOptionConstraints[0] isActive]) {
							 self.optionTwoLabel.text = nil;
						 }
					 }];
}

@end
