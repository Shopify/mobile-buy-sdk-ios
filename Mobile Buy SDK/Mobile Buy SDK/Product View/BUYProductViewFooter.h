//
//  BUYProductViewFooter.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

@import UIKit;
@class BUYProductVariant;
@class BUYTheme;
#import "BUYPaymentButton.h"
#import "BUYCheckoutButton.h"

@interface BUYProductViewFooter : UIView

/**
 *  A footer view for the BUYProductView that includes a checkout button and an Apple Pay button (if available)
 *
 *  @param theme             The theme for the footer view
 *  @param showApplePaySetup Show Apple Pay button with 'Set Up Apple Pay' text as determined by the presenter
 *
 *  @return A footer view with a checkout and Apple Pay button
 */
- (instancetype)initWithTheme:(BUYTheme *)theme showApplePaySetup:(BOOL)showApplePaySetup;

/**
 *  A checkout button themed with the BUYTheme tintColor. 
 *  This button is used for web checkout
 */
@property (nonatomic, strong) BUYCheckoutButton *checkoutButton;

/**
 *  An Apple Pay button, shown if Apple Pay is enabled and available on the device.
 *  The BUYPaymentButton is a PKPaymentButton on iOS 8.3 and greater.
 *  Styled to match the given theme.
 */
@property (nonatomic, strong) BUYPaymentButton *buyPaymentButton;

/**
 *  Sets the Apple Pay visible (or hides it). This updates the layout for the buttons.
 *
 *  @param isApplePayAvailable True when the Apple Pay button is visible
 */
- (void)setApplePayButtonVisible:(BOOL)isApplePayAvailable;

/**
 *  Lowers the alpha and disable the buttons if the `available` property on the
 *  BUYProductVariant is false.
 *
 *  @param productVariant The selected product variant that determines availability and functionality of the buttons.
 */
- (void)updateButtonsForProductVariant:(BUYProductVariant *)productVariant;

@end
