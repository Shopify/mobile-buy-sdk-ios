//
//  BUYCheckoutButton.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-28.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCheckoutButton.h"

@interface BUYCheckoutButton ()

@property (nonatomic, weak) BUYTheme *theme;

@end

@implementation BUYCheckoutButton

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	self.backgroundColor = highlighted ? [self.theme.tintColor colorWithAlphaComponent:0.4] : self.theme.tintColor;
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.tintColor = theme.tintColor;
	self.backgroundColor = self.tintColor;
	UIColor *textColor = theme.style == BUYThemeStyleLight ? [UIColor whiteColor] : [UIColor blackColor];
	[self setTitleColor:textColor forState:UIControlStateNormal];
}

@end
