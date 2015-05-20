//
//  CheckoutSelectionView.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

@import UIKit;

#import "PAYButton.h"

@interface CheckoutSelectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame buttons:(NSArray *)buttons;
- (void)showButtons:(CGFloat)animationDuration completion:(void (^)(BOOL complete))completion;
- (void)hideButtons:(CGFloat)animationDuration completion:(void (^)(BOOL complete))completion;

@end
