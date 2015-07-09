//
//  BUYTheme.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BUYThemeStyle) {
	BUYThemeStyleLight,
	BUYThemeStyleDark
};

@interface BUYTheme : NSObject

/**
 * Used for the highlight color
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 * Theme style for the views
 */
@property (nonatomic, assign) BUYThemeStyle style;

@end
