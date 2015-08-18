//
//  BUYProductViewErrorView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-13.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewErrorView.h"
#import "BUYTheme.h"
#import "BUYTheme+Additions.h"

@implementation BUYProductViewErrorView

- (instancetype)initWithTheme:(BUYTheme*)theme
{
	self = [super init];
	if (self) {
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
		visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:visualEffectView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(visualEffectView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(visualEffectView)]];
		
		UIView *redTintOverlayView = [[UIView alloc] init];
		redTintOverlayView.translatesAutoresizingMaskIntoConstraints = NO;
		redTintOverlayView.backgroundColor = [theme errorTintOverlayColor];
		[visualEffectView.contentView addSubview:redTintOverlayView];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[redTintOverlayView]|"
																							 options:0
																							 metrics:nil
																							   views:NSDictionaryOfVariableBindings(redTintOverlayView)]];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[redTintOverlayView]|"
																							 options:0
																							 metrics:nil
																							   views:NSDictionaryOfVariableBindings(redTintOverlayView)]];
		
		_errorLabel = [[UILabel alloc] init];
		_errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_errorLabel.textAlignment = NSTextAlignmentCenter;
		_errorLabel.font = [BUYTheme errorLabelFont];
		_errorLabel.textColor = [UIColor whiteColor];
		_errorLabel.backgroundColor = [UIColor clearColor];
		_errorLabel.numberOfLines = 0;
		[visualEffectView.contentView addSubview:_errorLabel];
		
		NSDictionary *metricsDictionary = @{ @"paddingExtraLarge" : @([BUYTheme paddingExtraLarge]), @"paddingMedium" : @([BUYTheme paddingMedium]) };
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(paddingExtraLarge)-[_errorLabel]-(paddingExtraLarge)-|"
																	 options:0
																	 metrics:metricsDictionary
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(paddingMedium)-[_errorLabel]-(paddingMedium)-|"
																	 options:0
																	 metrics:metricsDictionary
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
	}
	return self;
}

@end
