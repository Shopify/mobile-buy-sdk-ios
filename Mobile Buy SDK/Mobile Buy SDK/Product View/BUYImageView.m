//
//  BUYImageView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYImageView.h"

float const imageDuration = 0.1f;

@interface BUYImageView ()

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation BUYImageView

- (void)loadImageWithURL:(NSURL *)imageURL completion:(void (^)(UIImage *image, NSError *error))completion
{
	self.task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		if (error == nil && data) {
			UIImage *productImage = [UIImage imageWithData:data];
			dispatch_async(dispatch_get_main_queue(), ^{
				if (self.image) {
					[UIView transitionWithView:self
									  duration:imageDuration
									   options:UIViewAnimationOptionTransitionCrossDissolve
									animations:^{
										self.image = productImage;
									}
									completion:nil];
				} else {
					self.alpha = 0.0f;
					self.image = productImage;
					[UIView animateWithDuration:0.15f
									 animations:^{
										 self.alpha = 1.0f;
									 }];
				}
				if (completion) {
					completion(productImage, nil);
				}
			});
		} else {
			if (completion) {
				completion(nil, error);
			}
		}
	}];
	[self.task resume];
}

- (void)cancelImageTask {
	[self.task cancel];
	self.task = nil;
}

@end
