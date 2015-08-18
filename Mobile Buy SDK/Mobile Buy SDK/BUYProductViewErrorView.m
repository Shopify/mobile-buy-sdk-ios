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
		redTintOverlayView.backgroundColor = (theme.style == BUYThemeStyleDark) ? BUY_RGBA(255, 66, 66, 0.75f) : BUY_RGBA(209, 44, 44, 0.75f);
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
		_errorLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_errorLabel.textColor = [UIColor whiteColor];
		_errorLabel.backgroundColor = [UIColor clearColor];
		_errorLabel.numberOfLines = 0;
		[visualEffectView.contentView addSubview:_errorLabel];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_errorLabel]-(16)-|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(12)-[_errorLabel]-(12)-|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_errorLabel)]];
	}
	return self;
}

@end
