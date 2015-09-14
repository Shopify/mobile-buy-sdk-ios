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
		self.layoutMargins = UIEdgeInsetsMake(kBuyPaddingSmall, kBuyPaddingExtraLarge, kBuyPaddingSmall, kBuyPaddingMedium);
		
		_optionOneLabel = [UILabel new];
		_optionOneLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionOneLabel.font = [BUYTheme variantBreadcrumbsFont];
		_optionOneLabel.textColor = [BUYTheme variantBreadcrumbsTextColor];
		_optionOneLabel.text = @"Selected: ";
		[self addSubview:_optionOneLabel];
		
		_optionTwoLabel = [UILabel new];
		_optionTwoLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_optionTwoLabel.font = [BUYTheme variantBreadcrumbsFont];
		_optionTwoLabel.textColor = [BUYTheme variantBreadcrumbsTextColor];
		_optionTwoLabel.alpha = 0;
		[_optionTwoLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
		[self addSubview:_optionTwoLabel];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionOneLabel, _optionTwoLabel);
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionOneLabel]-|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionTwoLabel]-|" options:0 metrics:nil views:views]];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0]];
		
		NSLayoutConstraint *optionOneTrailingConstraint = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
		NSLayoutConstraint *optionTwoLeadingConstraintHidden = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_optionTwoLabel attribute:NSLayoutAttributeLeading multiplier:1.6f constant:-4];
		_oneOptionConstraints = @[optionOneTrailingConstraint, optionTwoLeadingConstraintHidden];
		
		NSLayoutConstraint *optionTwoLeadingConstraint = [NSLayoutConstraint constraintWithItem:_optionOneLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_optionTwoLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-4];
		NSLayoutConstraint *optionTwoTrailingConstraint = [NSLayoutConstraint constraintWithItem:_optionTwoLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
		_twoOptionsConstraints = @[optionTwoLeadingConstraint, optionTwoTrailingConstraint];
	}
	return self;
}

- (void)setTheme:(BUYTheme *)theme
{
	self.backgroundColor = [theme variantBreadcrumbsBackground];
}

- (void)setSelectedBuyOptionValues:(NSArray*)optionValues
{
	if ([optionValues count] == 1) {
		self.optionOneLabel.text = [NSString stringWithFormat:@"Selected: %@", [optionValues count] > 0 ? optionValues[0] : @""];
	}
	if ([self.optionTwoLabel.text length] == 0 && [optionValues count] == 2) {
		self.optionTwoLabel.text = [optionValues count] > 1 ? [NSString stringWithFormat:@"• %@", optionValues[1]] : @"";
	}

	if ([optionValues count] > 0) {
		[NSLayoutConstraint deactivateConstraints:@[_hiddenConstraint]];
		[NSLayoutConstraint activateConstraints:@[_visibleConstraint]];
	} else {
		[NSLayoutConstraint deactivateConstraints:@[_visibleConstraint]];
		[NSLayoutConstraint activateConstraints:@[_hiddenConstraint]];
	}
	
	if ([optionValues count] > 1) {
		[NSLayoutConstraint deactivateConstraints:_oneOptionConstraints];
		[NSLayoutConstraint activateConstraints:_twoOptionsConstraints];
	} else {
		[NSLayoutConstraint deactivateConstraints:_twoOptionsConstraints];
		[NSLayoutConstraint activateConstraints:_oneOptionConstraints];
	}
	
	// force the need to update layout in the animation block below
	[self setNeedsLayout];
	
	[UIView animateWithDuration:0.3
						  delay:0
						options:(UIViewAnimationOptionBeginFromCurrentState | 7 << 16)
					 animations:^{
						 self.optionTwoLabel.alpha = [_twoOptionsConstraints[0] isActive];
						 [self layoutIfNeeded];
					 }
					 completion:^(BOOL finished) {
						 if ([optionValues count] < 2 && [self.optionTwoLabel.text length] > 0) {
							 self.optionTwoLabel.text = nil;
						 }
						 if ([optionValues count] == 0) {
							 self.optionOneLabel.text = [NSString stringWithFormat:@"Selected: %@", [optionValues count] > 0 ? optionValues[0] : @""];
						 }
					 }];
}

@end
