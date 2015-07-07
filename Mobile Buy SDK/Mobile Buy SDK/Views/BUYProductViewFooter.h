//
//  BUYProductViewFooter.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-07.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Buy/BUYPaymentButton.h>

@interface BUYProductViewFooter : UIView

@property (nonatomic, strong) UIButton *checkoutButton;
@property (nonatomic, strong) BUYPaymentButton *buyPaymentButton;

@end
