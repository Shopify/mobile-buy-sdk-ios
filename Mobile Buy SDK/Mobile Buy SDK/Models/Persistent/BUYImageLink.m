//
//  _BUYImageLink.m
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

#import "BUYImageLink.h"
#import "NSString+BUYAdditions.h"
#import "NSURL+BUYAdditions.h"

@implementation BUYImageLink

- (NSDate *)createdAtDate
{
	return self.createdAt;
}

- (NSDate *)updatedAtDate
{
	return self.updatedAt;
}

@end

@implementation BUYImageLink (BUYImageSizing)

- (NSURL *)imageURLWithSize:(BUYImageURLSize)size
{
	return [self.sourceURL buy_imageURLWithSize:size];
}

+ (NSString *)keyForImageSize:(BUYImageURLSize)size
{
	switch (size) {
		case BUYImageURLSize100x100:   return @"_small";
		case BUYImageURLSize160x160:   return @"_compact";
		case BUYImageURLSize240x240:   return @"_medium";
		case BUYImageURLSize480x480:   return @"_large";
		case BUYImageURLSize600x600:   return @"_grande";
		case BUYImageURLSize1024x1024: return @"_1024x1024";
		case BUYImageURLSize2048x2048: return @"_2048x2048";
	}
}

@end

#pragma mark -

@implementation NSURL (BUYImageSizing)

- (instancetype)buy_imageURLWithSize:(BUYImageURLSize)size
{
	return [self buy_URLByAppendingFileBaseNameSuffix:[BUYImageLink keyForImageSize:size]];
}

@end

#pragma mark -

@implementation UIView (BUYImageSizing)

- (BUYImageURLSize)buy_imageSize
{
	CGFloat scale = [[UIScreen mainScreen] scale];
	CGFloat maxDimension = MAX(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
	
	CGFloat pixelSize = scale * maxDimension;
	
	if (pixelSize <= 100.0) return BUYImageURLSize100x100;
	if (pixelSize <= 160.0) return BUYImageURLSize160x160;
	if (pixelSize <= 240.0) return BUYImageURLSize240x240;
	if (pixelSize <= 480.0) return BUYImageURLSize480x480;
	if (pixelSize <= 600.0) return BUYImageURLSize600x600;
	if (pixelSize <= 1024.0) return BUYImageURLSize1024x1024;
	
	return BUYImageURLSize2048x2048;
}

@end
