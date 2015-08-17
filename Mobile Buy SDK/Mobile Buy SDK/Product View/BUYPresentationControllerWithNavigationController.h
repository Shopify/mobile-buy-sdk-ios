//
//  BUYPresentationControllerWithNavigationController.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import UIKit;
#import "BUYTheme.h"

@protocol BUYPresentationControllerWithNavigationControllerDelegate;

@interface BUYPresentationControllerWithNavigationController : UIPresentationController <UIAdaptivePresentationControllerDelegate, BUYThemeable>

@property (nonatomic, weak) id <BUYNavigationControllerDelegate> navigationDelegate;

+ (UIModalPresentationStyle)adaptivePresentationStyle;

@end


