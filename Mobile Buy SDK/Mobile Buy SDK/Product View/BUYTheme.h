//
//  BUYTheme.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BUYThemeStyle) {
	BUYThemeStyleLight,
	BUYThemeStyleDark
};

@interface BUYTheme : NSObject

/**
 *  Used for the highlight color
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 *  Theme style for the views
 */
@property (nonatomic, assign) BUYThemeStyle style;

/**
 *  Determines whether a blurred scaled-up product image should appear behind the product details. Default is YES
 */
@property (nonatomic, assign) BOOL showsProductImageBackground;

@end

@protocol BUYThemeable <NSObject>

/**
 *  Sets the theme for the view, and its subviews
 *
 *  @param theme The new theme to apply
 */
- (void)setTheme:(BUYTheme *)theme;

@end
