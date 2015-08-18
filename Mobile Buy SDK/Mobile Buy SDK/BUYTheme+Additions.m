//
//  BUYTheme+Additions.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-18.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYTheme+Additions.h"
#import "UIFont+BUYAdditions.h"

@implementation BUYTheme (Additions)

#pragma mark - Colors

- (UIColor*)backgroundColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(26, 26, 26) : [UIColor whiteColor];
}

- (UIColor*)selectedBackgroundColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(60, 60, 60) : BUY_RGB(242, 242, 242);
}

- (UIColor*)separatorColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(217, 217, 217);
}

- (UIColor*)disclosureIndicatorColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191);
}

- (UIColor*)checkoutButtonTextColor
{
	return self.style == BUYThemeStyleLight ? [UIColor whiteColor] : [UIColor blackColor];
}

+ (UIColor*)topGradientViewTopColor
{
	return [UIColor colorWithWhite:0 alpha:0.25f];
}

- (UIColor*)errorTintOverlayColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGBA(255, 66, 66, 0.75f) : BUY_RGBA(209, 44, 44, 0.75f);
}

- (UIColor*)navigationBarTitleColor
{
	return self.style == BUYThemeStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
}

- (UIColor*)navigationBarTitleVariantSelectionColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(229, 229, 229) : [UIColor blackColor];
}

- (UIColor*)navigationBarTitleVariantSelectionOptionsColor
{
	return BUY_RGB(140, 140, 140);
}

- (UIColor*)productTitleColor
{
	return self.style == BUYThemeStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
}

+ (UIColor*)comparePriceTextColor
{
	return [UIColor colorWithWhite:0.4f alpha:1];
}

+ (UIColor*)descriptionTextColor
{
	return [UIColor colorWithWhite:0.4f alpha:1];
}

- (UIColor*)variantOptionNameTextColor
{
	return self.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191);
}

- (UIColor*)variantPriceTextColor
{
	return BUY_RGB(140, 140, 140);
}

+ (UIColor*)variantSoldOutTextColor
{
	return BUY_RGB(220, 96, 96);
}

#pragma mark - Padding

+ (CGFloat)paddingSmall
{
	return 8.0f;
}

+ (CGFloat)paddingMedium
{
	return 12.0f;
}

+ (CGFloat)paddingLarge
{
	return 14.0f;
}

+ (CGFloat)paddingExtraLarge
{
	return 16.0f;
}

#pragma mark - Sizes

+ (CGFloat)topGradientViewHeight
{
	return 114.0f;
}

+ (CGFloat)productFooterHeight
{
	return 60.f;
}

+ (CGFloat)checkoutButtonHeight
{
	return 44.0f;
}

+ (CGFloat)pageControlHeight
{
	return 20.0f;
}

+ (CGFloat)bottomGradientHeightWithPageControl
{
	return 42.0f;
}

+ (CGFloat)bottomGradientHeightWithoutPageControl
{
	return 20.0f;
}

#pragma mark - Fonts

+ (UIFont*)productTitleFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody increasedPointSize:4];
}

+ (UIFont*)productPriceFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody increasedPointSize:4];
}

+ (UIFont*)productComparePriceFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (UIFont*)variantOptionNameFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

+ (UIFont*)variantOptionValueFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody increasedPointSize:2];
}

+ (UIFont*)variantOptionPriceFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

+ (UIFont*)variantOptionSelectionTitleFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

+ (UIFont*)variantOptionSelectionSelectionVariantOptionFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

+ (UIFont*)errorLabelFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

#pragma mark - Misc

- (UIBlurEffect*)blurEffect
{
	return [UIBlurEffect effectWithStyle:self.style == BUYThemeStyleDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
}

- (UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
	return self.style == BUYThemeStyleDark ? UIActivityIndicatorViewStyleWhite : UIActivityIndicatorViewStyleGray;
}

- (UIBarStyle)navigationBarStyle
{
	return self.style == BUYThemeStyleDark ? UIBarStyleBlack : UIBarStyleDefault;
}

- (BUYPaymentButtonStyle)paymentButtonStyle
{
	return self.style == BUYThemeStyleLight ? BUYPaymentButtonStyleBlack : BUYPaymentButtonStyleWhite;
}

@end
