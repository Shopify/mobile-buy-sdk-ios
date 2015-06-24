//
//  ProductView.m
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import "ProductView.h"

#define kMargin 11.0f
#define kActivityWidth 88.0f

// Should have used layout constraints
#define kTabBarHeight 49.0f

@implementation ProductView {
	UIView *_overlay;
	UIActivityIndicatorView *_activityIndicator;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		
		_productImageView = [[UIImageView alloc] init];
		_productImageView.backgroundColor = [UIColor lightGrayColor];
		_productImageView.contentMode = UIViewContentModeScaleAspectFill;
        _productImageView.clipsToBounds = YES;
        _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_productImageView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_productImageView]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_productImageView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(40)-[_productImageView]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_productImageView)]];
        [_productImageView addConstraint:[NSLayoutConstraint constraintWithItem:_productImageView
                                                                      attribute:NSLayoutAttributeHeight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:_productImageView
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:.66
                                                                       constant:0]];

        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"Title";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
		[self addSubview:_titleLabel];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_titleLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_productImageView][_titleLabel]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_titleLabel, _productImageView)]];
        
		
		_priceLabel = [[UILabel alloc] init];
		_priceLabel.text = @"Price";
		_priceLabel.textAlignment = NSTextAlignmentCenter;
		_priceLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		[self addSubview:_priceLabel];
        _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_priceLabel]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_priceLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel][_priceLabel]"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_priceLabel, _titleLabel)]];
		
		_paymentButton = [BUYPaymentButton buttonWithType:BUYPaymentButtonTypeBuy style:BUYPaymentButtonStyleBlack];
        _paymentButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_paymentButton];

        
        _checkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkoutButton.layer.cornerRadius = 5.0;
        _checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_checkoutButton setTitle:@"Checkout" forState:UIControlStateNormal];
        _checkoutButton.titleLabel.textColor = [UIColor whiteColor];
        _checkoutButton.backgroundColor = [UIColor blackColor];
        [self addSubview:_checkoutButton];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_checkoutButton]-|"
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_checkoutButton)]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_paymentButton]-|"
                                                                     options:NSLayoutFormatAlignAllCenterY
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_paymentButton)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_checkoutButton(66)]-[_paymentButton(66)]-(20)-|"
                                                                     options:NSLayoutFormatAlignAllCenterX
                                                                     metrics:0
                                                                       views:NSDictionaryOfVariableBindings(_paymentButton, _checkoutButton)]];
	}
	return self;
}

- (void)showLoading:(BOOL)loading
{
	if (loading && _overlay == nil) {
		CGRect bounds = self.bounds;
		_overlay = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
		_overlay.frame = bounds;
		_overlay.alpha = 0.0f;
		_overlay.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self addSubview:_overlay];
		
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_activityIndicator.frame = CGRectMake(bounds.origin.x + roundf((bounds.size.width - kActivityWidth) * 0.5f), bounds.origin.y + roundf((bounds.size.height - kActivityWidth) * 0.5f), kActivityWidth, kActivityWidth);
		_activityIndicator.alpha = 0.0f;
		[self addSubview:_activityIndicator];
		[_activityIndicator startAnimating];
		
		[UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
			_activityIndicator.alpha = 1.0f;
			_overlay.alpha = 1.0f;
		} completion:nil];
	}
	else if (loading == NO) {
		[UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
			_activityIndicator.alpha = 0.0f;
		} completion:^(BOOL finished) {
			[_overlay removeFromSuperview];
			[_activityIndicator stopAnimating];
			[_activityIndicator removeFromSuperview];
		}];
	}
}

@end
