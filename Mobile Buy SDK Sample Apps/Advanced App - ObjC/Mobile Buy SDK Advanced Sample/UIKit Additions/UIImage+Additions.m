//
//  UIImage+Additions.m
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

#import "UIImage+Additions.h"

static const CGFloat kDefaultCornerRadius = 4.0f;
static const CGFloat kDefaultStrokWidth = 1.0f;

@implementation UIImage (Additions)

+ (UIImage *)templateButtonBackgroundImage
{
	UIImage *image = [UIImage templateImageWithFill:[UIColor blackColor] stroke:nil];
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return image;
}

+ (UIImage *)templateImageWithFill:(UIEdgeInsets)edgeInsets
{
	UIImage *image = [UIImage templateImageWithFill:[UIColor blackColor] stroke:nil edgeInsets:edgeInsets];
	image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	return image;
}

+ (UIImage *)templateImageWithFill:(UIColor *)fill stroke:(UIColor *)stroke
{
	CGFloat defaultInsetAmount = kDefaultCornerRadius + 1.0f;
	return [UIImage templateImageWithFill:fill stroke:stroke edgeInsets:UIEdgeInsetsMake(defaultInsetAmount, defaultInsetAmount, defaultInsetAmount, defaultInsetAmount)];
}

+ (UIImage *)templateImageWithFill:(UIColor *)fill stroke:(UIColor *)stroke edgeInsets:(UIEdgeInsets)edgeInsets
{
	CGFloat defaultStrokeWidth = kDefaultStrokWidth;
	return [self templateImageWithFill:fill stroke:stroke edgeInsets:edgeInsets strokeWidth:defaultStrokeWidth];
}

+ (UIImage *)templateImageWithFill:(UIColor *)fill stroke:(UIColor *)stroke edgeInsets:(UIEdgeInsets)edgeInsets strokeWidth:(CGFloat)width
{
	CGRect rect = CGRectMake(0.0f, 0.0f,
							 edgeInsets.left + edgeInsets.right,
							 edgeInsets.top + edgeInsets.bottom);
	CGFloat strokeOffset = stroke ? kDefaultStrokWidth * 0.5f : 0.0f;
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, strokeOffset, strokeOffset) cornerRadius:edgeInsets.top];
	path.lineWidth = width;
	
	CGRect contextRect = CGRectOffset(rect, kDefaultStrokWidth * 0.5f, kDefaultStrokWidth * 0.5f);
	UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, 0);
	
	if (fill) {
		[fill setFill];
		[path fill];
	}
	
	if (stroke) {
		[stroke setStroke];
		[path stroke];
	}
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	image = [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch];
	
	return image;
}

@end
