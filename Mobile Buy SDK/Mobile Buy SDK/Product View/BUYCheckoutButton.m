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
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation BUYCheckoutButton

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	self.backgroundColor = highlighted ? [self.theme.tintColor colorWithAlphaComponent:0.4f] : self.theme.tintColor;
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	self.tintColor = theme.tintColor;
	self.backgroundColor = self.tintColor;
	UIColor *textColor = theme.style == BUYThemeStyleLight ? [UIColor whiteColor] : [UIColor blackColor];
	[self setTitleColor:textColor forState:UIControlStateNormal];
}

- (UIActivityIndicatorView *)activityIndicator
{
	if (_activityIndicator == nil) {
		
		UIActivityIndicatorViewStyle style = self.theme.style == BUYThemeStyleLight ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleGray;
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
		_activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
		_activityIndicator.hidesWhenStopped = YES;
		[self addSubview:_activityIndicator];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_activityIndicator);
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_activityIndicator]|" options:0 metrics:nil views:views]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_activityIndicator]|" options:0 metrics:nil views:views]];
	}
	
	return _activityIndicator;
}

- (void)showActivityIndicator:(BOOL)show
{
	if (show) {
		[self.activityIndicator startAnimating];
		[self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
	}
	else {
		[self.activityIndicator stopAnimating];
		[self setTheme:self.theme];
	}
}

@end
