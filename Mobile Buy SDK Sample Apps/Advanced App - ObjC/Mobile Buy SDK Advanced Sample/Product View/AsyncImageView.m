//
//  AsyncImageView.m
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

#import "AsyncImageView.h"

float const imageDuration = 0.1f;

static NSUInteger const memoryCacheSize = 10 * 1024 * 1024; // 10 MB
static NSUInteger const diskCacheSize = 50 * 1024 * 1024; // 50 MB

@interface NSURLSession (BUYImageSession)

+ (instancetype)buy_sharedImageSession;

@end

@implementation NSURLSession (BUYImageSession)

+ (instancetype)buy_sharedImageSession
{
	static NSURLSession *_sharedSession = nil;
	static dispatch_once_t oncePredicate;
	
	dispatch_once(&oncePredicate, ^{
		
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		config.URLCache = [[NSURLCache alloc] initWithMemoryCapacity:memoryCacheSize diskCapacity:diskCacheSize diskPath:nil];
		
		_sharedSession = [NSURLSession sessionWithConfiguration:config];
	});
	
	return _sharedSession;
}

@end

@interface AsyncImageView ()

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation AsyncImageView

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.showsActivityIndicator = YES;
		
		self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
		self.activityIndicatorView.hidesWhenStopped = YES;
		[self addSubview:self.activityIndicatorView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView
														 attribute:NSLayoutAttributeCenterY
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeCenterY
														multiplier:1.0
														  constant:0]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:self.activityIndicatorView
														 attribute:NSLayoutAttributeCenterX
														 relatedBy:NSLayoutRelationEqual
															toItem:self
														 attribute:NSLayoutAttributeCenterX
														multiplier:1.0
														  constant:0]];
	}
	return self;
}

- (void)loadImageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *image, NSError *error))completion
{
	[self loadImageWithURL:imageURL setImage:YES completion:completion];
}

- (void)loadImageWithURL:(NSURL *)imageURL animateChange:(BOOL)animateChange completion:(void (^)(UIImage *image, NSError *error))completion
{
	[self loadImageWithURL:imageURL setImage:NO completion:^(UIImage *image, NSError *error) {
		if (animateChange) {
			[UIView transitionWithView:self
							  duration:0.15f
							   options:(UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionBeginFromCurrentState)
							animations:^{
								self.image = image;
							}
							completion:^(BOOL finished) {
								if (completion) {
									completion(image, error);
								}
							}];
		} else {
			self.image = image;
			if (completion) {
				completion(image, error);
			}
		}
	}];
}

- (void)loadImageWithURL:(NSURL *)imageURL setImage:(BOOL)setImage completion:(void (^)(UIImage *image, NSError *error))completion
{
	if (self.task) {
		[self cancelImageTask];
	}
	if (self.showsActivityIndicator) {
		[self.activityIndicatorView startAnimating];
	}
	self.task = [[NSURLSession buy_sharedImageSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *image = [UIImage imageWithData:data];
			if (setImage) {
				self.image = image;
			}
			[self.activityIndicatorView stopAnimating];
			if (completion) {
				completion(image, error);
			}
		});
	}];
	[self.task resume];
}

- (void)cancelImageTask
{
	[self.task cancel];
	self.task = nil;
}

- (BOOL)isPortraitOrSquare
{
	return self.image.size.height >= self.image.size.width;
}

- (void)loadImageLink:(BUYImageLink *)imageLink animateChange:(BOOL)animateChange completion:(void (^)(UIImage *image, NSError *error))completion;
{
	BUYImageURLSize size = [self buy_imageSize];
	NSURL *url = [imageLink imageURLWithSize:size];
	
	[self loadImageWithURL:url animateChange:animateChange completion:completion];
}

@end
