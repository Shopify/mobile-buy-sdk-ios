//
//  BUYImageView.h
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

@import UIKit;
#import "BUYTheme.h"

extern float const imageDuration;

/**
 *  Provides an easy way to asynchronously load images from a URL
 */
@interface BUYImageView : UIImageView <BUYThemeable>

@property (nonatomic, assign) BOOL showsActivityIndicator;

/**
 *  Load an image asynchronously from a URL
 *
 *  @param imageURL   The URL to load the image from
 *  @param completion Completion block returning the image or an error
 */
- (void)loadImageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *image, NSError *error))completion;

/**
 *  Load an image asynchronously from a URL and animate the transition
 *
 *  @param imageURL      The URL to load the image from
 *  @param animateChange YES to animation the image transition
 *  @param completion    Completion block returning the image or an error
 */
- (void)loadImageWithURL:(NSURL *)imageURL animateChange:(BOOL)animateChange completion:(void (^)(UIImage *image, NSError *error))completion;

/**
 *  Cancel the current image loading task
 */
- (void)cancelImageTask;

/**
 *  Check if the image is portrait or square - or landscape
 *
 *  @return Returns YES if the image is portrait or square, returns NO if the image is landscape
 */
- (BOOL)isPortraitOrSquare;

@end
