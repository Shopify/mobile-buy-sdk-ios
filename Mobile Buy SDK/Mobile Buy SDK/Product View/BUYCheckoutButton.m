//
//  BUYCheckoutButton.m
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

#import "BUYCheckoutButton.h"
#import "BUYTheme+Additions.h"

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
	UIColor *textColor = [theme checkoutButtonTextColor];
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
