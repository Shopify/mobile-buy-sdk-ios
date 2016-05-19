//
//  Theme+Additions.m
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

#import "Theme+Additions.h"
#import "UIFont+Additions.h"
#import "UIColor+Additions.h"

@implementation Theme (Additions)

#pragma mark - Colors

+ (UIColor*)topGradientViewTopColor
{
	return [UIColor colorWithWhite:0 alpha:0.25f];
}

+ (UIColor*)comparePriceTextColor
{
	return [UIColor colorWithWhite:0.4f alpha:1];
}

+ (UIColor*)descriptionTextColor
{
	return [UIColor colorWithWhite:0.4f alpha:1];
}

+ (UIColor*)variantPriceTextColor
{
	return BUY_RGB(140, 140, 140);
}

+ (UIColor*)variantSoldOutTextColor
{
	return BUY_RGB(220, 96, 96);
}

#pragma mark - Padding and Sizes

CGFloat const kBuyPaddingSmall = 8.0f;
CGFloat const kBuyPaddingMedium = 12.0f;
CGFloat const kBuyPaddingLarge = 14.0f;
CGFloat const kBuyPaddingExtraLarge = 16.0f;
CGFloat const kBuyTopGradientViewHeight = 114.0f;
CGFloat const kBuyCheckoutButtonHeight = 44.0f;
CGFloat const kBuyPageControlHeight = 20.0f;
CGFloat const kBuyBottomGradientHeightWithPageControl = 42.0f;
CGFloat const kBuyBottomGradientHeightWithoutPageControl = 20.0f;

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

+ (UIFont*)variantBreadcrumbsFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

+ (UIFont*)errorLabelFont
{
	return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

@end
