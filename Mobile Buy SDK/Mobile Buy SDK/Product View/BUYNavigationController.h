//
//  BUYNavigationController.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

@protocol BUYNavigationControllerDelegate <NSObject>

- (void)presentationControllerWillDismiss:(UIPresentationController*)presentationController;
- (void)presentationControllerDidDismiss:(UIPresentationController*)presentationController;

@end

@interface BUYNavigationController : UINavigationController <BUYThemeable>

- (void)updateCloseButtonImageWithDarkStyle:(BOOL)darkStyle duration:(CGFloat)duration;

@property (nonatomic, weak) id <BUYNavigationControllerDelegate> navigationDelegate;

@end

