//
//  BUYTheme+Additions.h
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

#import "BUYTheme.h"
#import "BUYPaymentButton.h"

#define BUY_RGB(r, g, b) BUY_RGBA(r, g, b, 1)
#define BUY_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface BUYTheme (Additions)

// colours
- (UIColor*)backgroundColor;
- (UIColor*)selectedBackgroundColor;
- (UIColor*)separatorColor;
- (UIColor*)disclosureIndicatorColor;
- (UIColor*)checkoutButtonTextColor;
+ (UIColor*)topGradientViewTopColor;
- (UIColor*)errorTintOverlayColor;
- (UIColor*)navigationBarTitleColor;
- (UIColor*)navigationBarTitleVariantSelectionColor;
- (UIColor*)navigationBarTitleVariantSelectionOptionsColor;
- (UIColor*)productTitleColor;
+ (UIColor*)comparePriceTextColor;
+ (UIColor*)descriptionTextColor;
- (UIColor*)variantOptionNameTextColor;
+ (UIColor*)variantPriceTextColor;
+ (UIColor*)variantSoldOutTextColor;
- (UIColor*)variantBreadcrumbsBackground;
+ (UIColor*)variantBreadcrumbsTextColor;

// padding and sizes
extern CGFloat const kBuyPaddingSmall;
extern CGFloat const kBuyPaddingMedium;
extern CGFloat const kBuyPaddingLarge;
extern CGFloat const kBuyPaddingExtraLarge;
extern CGFloat const kBuyTopGradientViewHeight;
extern CGFloat const kBuyProductFooterHeight;
extern CGFloat const kBuyCheckoutButtonHeight;
extern CGFloat const kBuyPageControlHeight;
extern CGFloat const kBuyBottomGradientHeightWithPageControl;
extern CGFloat const kBuyBottomGradientHeightWithoutPageControl;

// fonts
+ (UIFont*)productTitleFont;
+ (UIFont*)productPriceFont;
+ (UIFont*)productComparePriceFont;
+ (UIFont*)variantOptionNameFont;
+ (UIFont*)variantOptionValueFont;
+ (UIFont*)variantOptionPriceFont;
+ (UIFont*)variantOptionSelectionTitleFont;
+ (UIFont*)variantOptionSelectionSelectionVariantOptionFont;
+ (UIFont*)variantBreadcrumbsFont;
+ (UIFont*)errorLabelFont;

// misc
- (UIBlurEffect*)blurEffect;
- (UIActivityIndicatorViewStyle)activityIndicatorViewStyle;
- (UIBarStyle)navigationBarStyle;
- (BUYPaymentButtonStyle)paymentButtonStyle;

@end
