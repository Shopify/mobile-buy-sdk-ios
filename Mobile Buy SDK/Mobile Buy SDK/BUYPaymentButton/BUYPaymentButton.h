//
//  BUYPaymentButton.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-04-27.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

typedef NS_ENUM(NSInteger, BUYPaymentButtonStyle) {
    BUYPaymentButtonStyleWhite = 0,
    BUYPaymentButtonStyleWhiteOutline,
    BUYPaymentButtonStyleBlack
};

typedef NS_ENUM(NSInteger, BUYPaymentButtonType) {
    BUYPaymentButtonTypePlain = 0,
    BUYPaymentButtonTypeBuy
};

@interface BUYPaymentButton : UIButton

+ (instancetype)buttonWithType:(BUYPaymentButtonType)buttonType style:(BUYPaymentButtonStyle)buttonStyle;

@end
