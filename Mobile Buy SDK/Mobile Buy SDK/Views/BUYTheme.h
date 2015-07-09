//
//  BUYTheme.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BUYThemeStyle) {
	BUYThemeStyle_Light,
	BUYThemeStyle_Dark
};

@interface BUYTheme : NSObject

@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic, assign) BUYThemeStyle style;

@end
