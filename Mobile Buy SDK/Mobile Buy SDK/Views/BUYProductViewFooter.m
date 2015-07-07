//
//  BUYProductViewFooter.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewFooter.h"

@interface BUYProductViewFooter ()

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

@end

@implementation BUYProductViewFooter

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
		self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
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
		separatorLineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
		[self.visualEffectView.contentView addSubview:separatorLineView];
		
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorLineView]|"
																					  options:0
																					  metrics:nil
																						views:NSDictionaryOfVariableBindings(separatorLineView)]];
		[self.visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[separatorLineView(lineHeight)]"
																					  options:0
																					  metrics:@{ @"lineHeight" : @([[UIScreen mainScreen] scale] / 4) }
																						views:NSDictionaryOfVariableBindings(separatorLineView)]];
	}
	return self;
}

- (void)setApplePayButtonVisible:(BOOL)isApplePayAvailable
{
	NSMutableDictionary *viewsDictionary = [@{} mutableCopy];
	NSDictionary *metricsDictionary = @{ @"buttonHeight" : @44 };
	
	self.checkoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
	self.checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
	[self.checkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	self.checkoutButton.backgroundColor = self.tintColor;
	self.checkoutButton.layer.cornerRadius = 5;
	[self.visualEffectView.contentView addSubview:self.checkoutButton];
	viewsDictionary[@"_checkoutButton"] = self.checkoutButton;
	
	if (isApplePayAvailable) {
		self.buyPaymentButton = [BUYPaymentButton buttonWithType:BUYPaymentButtonTypeBuy style:BUYPaymentButtonStyleBlack];
		self.buyPaymentButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.visualEffectView.contentView addSubview:self.buyPaymentButton];
		viewsDictionary[@"_buyPaymentButton"] = self.buyPaymentButton;
		[self.visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-[_buyPaymentButton(==_checkoutButton)]-|"
																								  options:0
																								  metrics:nil
																									views:viewsDictionary]];
		[self.visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_buyPaymentButton(buttonHeight)]-|"
																								  options:0
																								  metrics:metricsDictionary
																									views:viewsDictionary]];
	} else {
		[self.visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-|"
																								  options:0
																								  metrics:nil
																									views:viewsDictionary]];
	}
	
	[self.visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_checkoutButton(buttonHeight)]-|"
																						 options:0
																						 metrics:metricsDictionary
																						   views:viewsDictionary]];
	
	if (isApplePayAvailable) {
		self.buyPaymentButton.hidden = !isApplePayAvailable;
		
	}
}

/*
 // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
