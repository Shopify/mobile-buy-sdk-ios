//
//  BUYProductViewFooter.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

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

- (instancetype)initWithTheme:(BUYTheme *)theme;
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
		
		self.buyPaymentButton = [BUYPaymentButton buttonWithType:BUYPaymentButtonTypeBuy style:[theme paymentButtonStyle]];
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
		[NSLayoutConstraint activateConstraints:self.applePayLayoutConstraints];
		[NSLayoutConstraint deactivateConstraints:self.checkoutLayoutConstraints];
	} else {
		[NSLayoutConstraint activateConstraints:self.checkoutLayoutConstraints];
		[NSLayoutConstraint deactivateConstraints:self.applePayLayoutConstraints];
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
