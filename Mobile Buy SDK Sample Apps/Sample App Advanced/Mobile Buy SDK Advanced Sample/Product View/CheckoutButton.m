//
//  CheckoutButton.m
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

#import "CheckoutButton.h"
#import "UIColor+Additions.h"
#import "UIImage+Additions.h"

@interface CheckoutButton ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIColor *textColor;

@end

@implementation CheckoutButton

+ (instancetype)checkoutButton
{
	CheckoutButton *checkoutButton = [super buttonWithType:UIButtonTypeSystem];
	[checkoutButton commonInit];
	return checkoutButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit
{
	[self setBackgroundImage:[UIImage templateButtonBackgroundImage] forState:UIControlStateNormal];
	[self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f] forState:UIControlStateDisabled];
}

- (void)setTextColor:(UIColor*)color
{
	_textColor = color;
	[self setTitleColor:color forState:UIControlStateNormal];
}

- (UIActivityIndicatorView *)activityIndicator
{
	if (_activityIndicator == nil) {
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
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
		[self setTitleColor:self.textColor forState:UIControlStateNormal];
	}
}

@end
