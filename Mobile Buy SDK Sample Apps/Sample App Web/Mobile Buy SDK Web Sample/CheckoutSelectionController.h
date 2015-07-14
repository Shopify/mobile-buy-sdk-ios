//
//  CheckoutSelectionController.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

@import UIKit;

@class CheckoutSelectionController;

typedef NS_ENUM(NSUInteger, CheckoutType) {
	CheckoutTypeNormal,
	CheckoutTypeApplePay
};

@protocol CheckoutSelectionControllerDelegate <NSObject>

- (void)checkoutSelectionControllerCancelled:(CheckoutSelectionController *)controller;
- (void)checkoutSelectionController:(CheckoutSelectionController *)controller selectedCheckoutType:(CheckoutType)checkoutType;

@end

@interface CheckoutSelectionController : UIViewController

@property (nonatomic, strong) NSURLRequest *checkoutRequest;
@property (nonatomic, weak) id <CheckoutSelectionControllerDelegate> delegate;

@end
