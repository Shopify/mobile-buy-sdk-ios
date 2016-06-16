//
//  ActionableFooterView.m
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

#import "ActionableFooterView.h"

@interface ActionableFooterView()
@property (nonatomic) BOOL applePayAvailable;
@property (nonatomic) BOOL applePayRequiresSetup;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *applePayLeadingConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *firstButtonTrailingConstraint;
@property (strong, nonatomic) IBOutlet CheckoutButton *actionButton;
@property (strong, nonatomic) IBOutlet UIView *paymentButtonContainer;
@property (strong, nonatomic) IBOutlet UIView *extensionView;

@property (strong, nonatomic) UIButton *paymentButton;
@end

@implementation ActionableFooterView

- (instancetype)init
{
	return [[NSBundle bundleForClass:self.class] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.actionButton.backgroundColor = nil;
	[self.actionButton setTitle:nil forState:UIControlStateNormal];
	self.paymentButtonStyle = PaymentButtonStyleBlack;
	self.paymentButtonContainer.backgroundColor = nil;
}

- (void)setApplePayAvailable:(BOOL)applePayAvailable requiresSetup:(BOOL)requiresSetup
{
	_applePayAvailable = applePayAvailable;
	_applePayRequiresSetup = requiresSetup;
	
	self.paymentButtonContainer.hidden = !applePayAvailable;
	PaymentButtonType type = self.applePayRequiresSetup ? PaymentButtonTypeSetup : PaymentButtonTypeBuy;
	
	if (!self.paymentButton) {
		
		_paymentButton = [UIButton paymentButtonWithType:type style:self.paymentButtonStyle];
		[self.paymentButtonContainer addSubview:self.paymentButton];
		self.paymentButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.paymentButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_paymentButton]|"
																							options:0
																							metrics:nil
																							  views:NSDictionaryOfVariableBindings(_paymentButton)]];
		[self.paymentButtonContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_paymentButton]|"
																							options:0
																							metrics:nil
																							  views:NSDictionaryOfVariableBindings(_paymentButton)]];
	}
	[self setNeedsUpdateConstraints];
}

- (void)setLayoutMargins:(UIEdgeInsets)layoutMargins
{
	[super setLayoutMargins:layoutMargins];
	self.applePayLeadingConstraint.constant = self.layoutMargins.left;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self setNeedsUpdateConstraints];
}

- (void)setButtonsEnabled:(BOOL)buttonsEnabled
{
	self.actionButton.enabled = buttonsEnabled;
	self.paymentButton.enabled = buttonsEnabled;
	self.paymentButton.alpha = buttonsEnabled ? 1.0f : 0.5f;
}

- (void)updateConstraints
{
	if (self.applePayAvailable) {
		CGFloat trailingConstant = (CGRectGetWidth(self.bounds) - self.layoutMargins.right) * 0.5f;
		self.firstButtonTrailingConstraint.constant = trailingConstant;
	} else {
		self.firstButtonTrailingConstraint.constant = 0.0f;
	}
	[super updateConstraints];
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
	self.layer.shadowColor = separatorColor.CGColor;
	self.layer.shadowOffset = CGSizeMake(0, - 1 / [UIScreen mainScreen].scale);
	self.layer.shadowRadius = 0.0f;
	self.layer.shadowOpacity = 1.0f;
}

@end
