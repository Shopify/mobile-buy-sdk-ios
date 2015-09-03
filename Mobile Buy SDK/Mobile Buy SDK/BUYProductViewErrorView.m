//
//  BUYProductViewErrorView.m
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
		
		NSDictionary *metricsDictionary = @{ @"paddingExtraLarge" : @(kBuyPaddingExtraLarge), @"paddingMedium" : @(kBuyPaddingMedium) };
		
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
