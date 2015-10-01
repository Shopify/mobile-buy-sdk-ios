//
//  BUYProductViewFooter.m
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

@import PassKit;
#import "BUYProductViewFooter.h"
#import "BUYTheme.h"
#import "BUYProductVariant.h"
#import "BUYTheme+Additions.h"

@interface BUYProductViewFooter ()

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) NSArray *checkoutLayoutConstraints;
@property (nonatomic, strong) NSArray *applePayLayoutConstraints;
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYProductViewFooter

- (instancetype)initWithTheme:(BUYTheme *)theme showApplePaySetup:(BOOL)showApplePaySetup
{
	self = [super init];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.theme = theme;
		
		self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[theme blurEffect]];
		self.visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.visualEffectView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_visualEffectView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_visualEffectView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(_visualEffectView)]];
		
		UIView *separatorLineView = [[UIView alloc] init];
		separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
		separatorLineView.backgroundColor = [theme separatorColor];
		[self.visualEffectView.contentView addSubview:separatorLineView];
		
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorLineView]|"
																					  options:0
																					  metrics:nil
																						views:NSDictionaryOfVariableBindings(separatorLineView)]];
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[separatorLineView(lineHeight)]"
																					  options:0
																					  metrics:@{ @"lineHeight" : @([[UIScreen mainScreen] scale] / 4) }
																						views:NSDictionaryOfVariableBindings(separatorLineView)]];
		
		self.checkoutButton = [BUYCheckoutButton buttonWithType:UIButtonTypeCustom];
		self.checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.checkoutButton setTheme:self.theme];
		[self.checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
		self.checkoutButton.layer.cornerRadius = 5;
		[self.visualEffectView.contentView addSubview:self.checkoutButton];
		
		BUYPaymentButtonType buttonType = showApplePaySetup ? BUYPaymentButtonTypeSetup : BUYPaymentButtonTypeBuy;
		self.buyPaymentButton = [BUYPaymentButton buttonWithType:buttonType style:[self.theme paymentButtonStyle]];
		self.buyPaymentButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.visualEffectView.contentView addSubview:self.buyPaymentButton];
		
		NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_checkoutButton, _buyPaymentButton);
		
		self.applePayLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-[_buyPaymentButton(==_checkoutButton)]-|"
																				 options:0
																				 metrics:nil
																				   views:viewsDictionary];
		[self addConstraints:self.applePayLayoutConstraints];
		[NSLayoutConstraint deactivateConstraints:self.applePayLayoutConstraints];
		
		self.checkoutLayoutConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-|"
																				 options:0
																				 metrics:nil
																				   views:viewsDictionary];
		[self addConstraints:self.checkoutLayoutConstraints];
		[NSLayoutConstraint deactivateConstraints:self.checkoutLayoutConstraints];
		
		NSDictionary *metricsDictionary = @{ @"buttonHeight" : @(kBuyCheckoutButtonHeight) };
		
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_checkoutButton(buttonHeight)]-|"
																					  options:0
																					  metrics:metricsDictionary
																						views:viewsDictionary]];
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_buyPaymentButton(==_checkoutButton)]-|"
																					  options:0
																					  metrics:nil
																						views:viewsDictionary]];
	}
	return self;
}

- (void)setApplePayButtonVisible:(BOOL)isApplePayAvailable
{
	self.buyPaymentButton.hidden = !isApplePayAvailable;
	if (isApplePayAvailable) {
		[NSLayoutConstraint deactivateConstraints:self.checkoutLayoutConstraints];
		[NSLayoutConstraint activateConstraints:self.applePayLayoutConstraints];
	} else {
		[NSLayoutConstraint deactivateConstraints:self.applePayLayoutConstraints];
		[NSLayoutConstraint activateConstraints:self.checkoutLayoutConstraints];
	}
}

- (void)tintColorDidChange
{
	[super tintColorDidChange];
	self.checkoutButton.backgroundColor = self.tintColor;
}

- (void)updateButtonsForProductVariant:(BUYProductVariant *)productVariant {
	self.checkoutButton.enabled = productVariant.available;
	self.checkoutButton.alpha = productVariant.available ? 1.0f : 0.5f;
	self.buyPaymentButton.enabled = productVariant.available;
	self.buyPaymentButton.alpha = productVariant.available ? 1.0f : 0.5f;
}

@end
