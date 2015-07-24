//
//  BUYTheme.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUY_RGB(r, g, b) BUY_RGBA(r, g, b, 1)
#define BUY_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

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
