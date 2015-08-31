//
//  CheckoutViewController.h
//  Mobile Buy SDK Advanced Sample
//
//  Created by David Muzi on 2015-08-26.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BUYCheckout;
@class BUYClient;

extern NSString * const CheckoutCallbackNotification;

@interface CheckoutViewController : UIViewController

- (instancetype)initWithClient:(BUYClient *)client checkout:(BUYCheckout *)checkout;

@end
