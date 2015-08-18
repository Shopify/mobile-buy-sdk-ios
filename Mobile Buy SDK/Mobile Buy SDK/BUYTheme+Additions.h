//
//  BUYTheme+Additions.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-18.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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
- (UIColor*)navigationBarVariantSelectionTintColor;
- (UIColor*)navigationBarVariantSelectionCloseButtonTintColor;
- (UIColor*)productTitleColor;
+ (UIColor*)descriptionTextColor;
- (UIColor*)variantOptionNameTextColor;

// padding
+ (CGFloat)paddingSmall;
+ (CGFloat)paddingMedium;
+ (CGFloat)paddingLarge;

// sizes
+ (CGFloat)topGradientViewHeight;
+ (CGFloat)productFooterHeight;
+ (CGFloat)checkoutButtonHeight;
+ (CGFloat)pageControlHeight;
+ (CGFloat)bottomGradientHeightWithPageControl;
+ (CGFloat)bottomGradientHeightWithoutPageControl;

// fonts
+ (UIFont*)productTitleFont;
+ (UIFont*)productPriceFont;
+ (UIFont*)productComparePriceFont;
+ (UIFont*)variantOptionNameFont;
+ (UIFont*)variantOptionValueFont;
+ (UIFont*)errorLabelFont;

// misc
- (UIBlurEffect*)blurEffect;
- (UIActivityIndicatorViewStyle)activityIndicatorViewStyle;
- (UIBarStyle)navigationBarStyle;
- (BUYPaymentButtonStyle)paymentButtonStyle;

@end
