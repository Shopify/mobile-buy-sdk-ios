//
//  BUYProductViewFooter.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYProductVariant;
@class BUYTheme;
#import "BUYPaymentButton.h"
#import "BUYCheckoutButton.h"

@interface BUYProductViewFooter : UIView

- (instancetype)initWithTheme:(BUYTheme *)theme;

@property (nonatomic, strong) BUYCheckoutButton *checkoutButton;
@property (nonatomic, strong) BUYPaymentButton *buyPaymentButton;

- (void)setApplePayButtonVisible:(BOOL)isApplePayAvailable;
- (void)updateButtonsForProductVariant:(BUYProductVariant *)productVariant;

@end
