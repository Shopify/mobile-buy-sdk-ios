//
//  ProductView.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

@import UIKit;
@import PassKit;
#import <Buy/Buy.h>

@interface ProductView : UIView

@property (nonatomic, strong, readonly) UIImageView *productImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *priceLabel;
@property (nonatomic, strong, readonly) BUYPaymentButton *paymentButton;
@property (nonatomic, strong, readonly) UIButton *checkoutButton;

- (void)showLoading:(BOOL)loading;

@end
