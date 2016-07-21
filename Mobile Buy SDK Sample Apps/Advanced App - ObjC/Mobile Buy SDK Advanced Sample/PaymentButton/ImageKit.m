//
//  ImageKit.m
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

#import "ImageKit.h"

@implementation ImageKit

#pragma mark Drawing Methods

+ (void)drawVariantCloseImageWithFrame: (CGRect)frame
{
	//// Color Declarations
	UIColor* closeColor = [UIColor colorWithRed: 0.596f green: 0.596f blue: 0.596f alpha: 1];
	
	//// Variant Close Icon Drawing
	UIBezierPath* variantCloseIconPath = UIBezierPath.bezierPath;
	[variantCloseIconPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13971f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16669f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93886f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87988f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86029f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95000f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.06114f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23681f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13971f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16669f * CGRectGetHeight(frame))];
	[variantCloseIconPath closePath];
	[variantCloseIconPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86029f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16669f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93886f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.23681f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.13971f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95000f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.06114f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87988f * CGRectGetHeight(frame))];
	[variantCloseIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86029f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.16669f * CGRectGetHeight(frame))];
	[variantCloseIconPath closePath];
	[closeColor setFill];
	[variantCloseIconPath fill];
}

+ (void)drawPreviousSelectionIndicatorImageWithFrame: (CGRect)frame
{
	//// Color Declarations
	UIColor* indicatorColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
	
	//// Previous Selection Indicator Drawing
	UIBezierPath* previousSelectionIndicatorPath = UIBezierPath.bezierPath;
	[previousSelectionIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.22386f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000f * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77614f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000f * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22386f * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.22386f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 1.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50000f * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.77614f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00000f * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 1.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22386f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000f * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 1.00000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77614f * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.77614f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 1.00000f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath closePath];
	[previousSelectionIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74926f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28003f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62929f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25074f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48003f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.18002f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55074f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.39926f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76997f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40000f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76924f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.40073f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.76997f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.81997f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35074f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74926f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28003f * CGRectGetHeight(frame))];
	[previousSelectionIndicatorPath closePath];
	[indicatorColor setFill];
	[previousSelectionIndicatorPath fill];
}

+ (void)drawDisclosureIndicatorImageWithFrame: (CGRect)frame color:(UIColor*)arrowColor
{
	//// Disclosure Indicator Drawing
	UIBezierPath* disclosureIndicatorPath = UIBezierPath.bezierPath;
	[disclosureIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25149f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06878f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93995f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49908f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79854f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.58746f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11004f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15717f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25149f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06878f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath closePath];
	[disclosureIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79854f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41253f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.93995f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50092f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25149f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93121f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11004f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84282f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79854f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41253f * CGRectGetHeight(frame))];
	[disclosureIndicatorPath closePath];
	[arrowColor setFill];
	[disclosureIndicatorPath fill];
}

+ (void)drawProductViewCloseImageWithFrame: (CGRect)frame color:(UIColor *)closeColor2 hasShadow:(BOOL)hasShadow
{
	//// General Declarations
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	//// Color Declarations
	UIColor* closeShadowColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
	
	//// Shadow Declarations
	NSShadow* closeDropShadow = [[NSShadow alloc] init];
	[closeDropShadow setShadowColor: [closeShadowColor colorWithAlphaComponent: 0.15f]];
	[closeDropShadow setShadowOffset: CGSizeMake(0.1f, 1.1f)];
	[closeDropShadow setShadowBlurRadius: 2];
	
	//// Close Icon Drawing
	UIBezierPath* closeIconPath = UIBezierPath.bezierPath;
	[closeIconPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11431f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09548f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85907f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84024f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79479f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90452f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.05002f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15976f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11431f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09548f * CGRectGetHeight(frame))];
	[closeIconPath closePath];
	[closeIconPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79479f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09548f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.85907f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15976f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.11431f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90452f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.05002f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84024f * CGRectGetHeight(frame))];
	[closeIconPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79479f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09548f * CGRectGetHeight(frame))];
	[closeIconPath closePath];
	CGContextSaveGState(context);
	if (hasShadow) {
		CGContextSetShadowWithColor(context, closeDropShadow.shadowOffset, closeDropShadow.shadowBlurRadius, [closeDropShadow.shadowColor CGColor]);
	}
	[closeColor2 setFill];
	[closeIconPath fill];
	CGContextRestoreGState(context);
}
+ (void)drawVariantBackImageWithFrame: (CGRect)frame
{
	//// Color Declarations
	UIColor* indicatorColor3 = [UIColor colorWithRed: 0.596f green: 0.596f blue: 0.596f alpha: 1];
	
	//// Variant Back Indicator Drawing
	UIBezierPath* variantBackIndicatorPath = UIBezierPath.bezierPath;
	[variantBackIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20956f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42225f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86663f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86029f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74878f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93886f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.09171f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50082f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20956f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.42225f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath closePath];
	[variantBackIndicatorPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74878f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06114f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.86663f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.13971f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20956f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57775f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.09171f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49918f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74878f * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06114f * CGRectGetHeight(frame))];
	[variantBackIndicatorPath closePath];
	[indicatorColor3 setFill];
	[variantBackIndicatorPath fill];
}

#pragma mark Generated Images

+ (UIImage*)imageOfVariantCloseImageWithFrame: (CGRect)frame
{
	UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
	[ImageKit drawVariantCloseImageWithFrame: frame];
	
	UIImage* imageOfVariantCloseImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageOfVariantCloseImage;
}

+ (UIImage*)imageOfPreviousSelectionIndicatorImageWithFrame: (CGRect)frame
{
	UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
	[ImageKit drawPreviousSelectionIndicatorImageWithFrame: frame];
	
	UIImage* imageOfPreviousSelectionIndicatorImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageOfPreviousSelectionIndicatorImage;
}

+ (UIImage*)imageOfDisclosureIndicatorImageWithFrame: (CGRect)frame color:(UIColor*)color;
{
	UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
	[ImageKit drawDisclosureIndicatorImageWithFrame: frame color:color];
	
	UIImage* imageOfDisclosureIndicatorImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageOfDisclosureIndicatorImage;
}

+ (UIImage*)imageOfProductViewCloseImageWithFrame: (CGRect)frame color:(UIColor*)color hasShadow:(BOOL)hasShadow;
{
	UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
	[ImageKit drawProductViewCloseImageWithFrame: frame color:color hasShadow:hasShadow];
	
	UIImage* imageOfProductViewCloseImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageOfProductViewCloseImage;
}

+ (UIImage*)imageOfVariantBackImageWithFrame: (CGRect)frame
{
	UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
	[ImageKit drawVariantBackImageWithFrame: frame];
	
	UIImage* imageOfVariantBackImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return imageOfVariantBackImage;
}

@end
