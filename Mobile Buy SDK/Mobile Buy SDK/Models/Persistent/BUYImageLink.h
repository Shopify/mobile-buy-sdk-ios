//
//  _BUYImageLink.h
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
#import <Buy/_BUYImageLink.h>
NS_ASSUME_NONNULL_BEGIN

// Defines for common maximum image sizes
typedef NS_ENUM(NSUInteger, BUYImageURLSize) {
	BUYImageURLSize100x100,
	BUYImageURLSize160x160,
	BUYImageURLSize240x240,
	BUYImageURLSize480x480,
	BUYImageURLSize600x600,
	BUYImageURLSize1024x1024,
	BUYImageURLSize2048x2048
};

@interface BUYImageLink : _BUYImageLink {}

@property (nonatomic, readonly, copy) NSDate *createdAtDate;
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;

@end


@interface BUYImageLink (BUYImageSizing)

/**
 *  Generates a link to the image with the specified size
 *
 *  @param size desired maximum size of the image
 *
 *  @return NSURL to the image resourse
 */
- (NSURL *)imageURLWithSize:(BUYImageURLSize)size;

@end

@interface NSURL (BUYImageSizing)

/**
 *  Generates a link to the image with the specified size
 *
 *  @param size desired maximum size of the image
 *
 *  @return NSURL to the image resourse
 */
- (instancetype)buy_imageURLWithSize:(BUYImageURLSize)size;

@end

@interface UIView (BUYImageSizing)

/**
 *  Determines the optimal size for the image for the given view
 *
 *  @return the size enum value
 */
- (BUYImageURLSize)buy_imageSize;

@end

NS_ASSUME_NONNULL_END
