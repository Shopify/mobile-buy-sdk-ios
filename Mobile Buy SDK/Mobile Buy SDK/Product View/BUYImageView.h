//
//  BUYImageView.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

extern float const imageDuration;

@interface BUYImageView : UIImageView <BUYThemeable>

@property (nonatomic, assign) BOOL showsActivityIndicator;

- (void)loadImageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *image, NSError *error))completion;
- (void)loadImageWithURL:(NSURL *)imageURL animateChange:(BOOL)animateChange completion:(void (^)(UIImage *image, NSError *error))completion;
- (void)cancelImageTask;
- (BOOL)isPortraitOrSquare;

@end
