//
//  BUYProductViewFooter.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductViewFooter.h"

@implementation BUYProductViewFooter

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		
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
		
		self.checkoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
		self.checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
		[self.checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
		[self.checkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		self.checkoutButton.backgroundColor = self.tintColor;
		self.checkoutButton.layer.cornerRadius = 5;
		[visualEffectView.contentView addSubview:self.checkoutButton];
		
		self.buyPaymentButton = [BUYPaymentButton buttonWithType:BUYPaymentButtonTypeBuy style:BUYPaymentButtonStyleBlack];
		self.buyPaymentButton.translatesAutoresizingMaskIntoConstraints = NO;
		[visualEffectView.contentView addSubview:self.buyPaymentButton];
		
		NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_checkoutButton, _buyPaymentButton);
		NSDictionary *metricsDictionary = @{ @"buttonHeight" : @44, @"lineHeight" : @([[UIScreen mainScreen] scale] / 4) };
		
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-[_buyPaymentButton(==_checkoutButton)]-|"
																	 options:0
																	 metrics:nil
																	   views:viewsDictionary]];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_checkoutButton(buttonHeight)]-|"
																	 options:0
																	 metrics:metricsDictionary
																	   views:viewsDictionary]];
		[visualEffectView.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_buyPaymentButton(buttonHeight)]-|"
																							 options:0
																							 metrics:metricsDictionary
																							   views:viewsDictionary]];
		
		UIView *separatorLineView = [[UIView alloc] init];
		separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
		separatorLineView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
		[visualEffectView.contentView addSubview:separatorLineView];
		
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorLineView]|"
																	 options:0
																	 metrics:nil
																	   views:NSDictionaryOfVariableBindings(separatorLineView)]];
		[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[separatorLineView(lineHeight)]"
																	 options:0
																	 metrics:metricsDictionary
																	   views:NSDictionaryOfVariableBindings(separatorLineView)]];
	}
	return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
