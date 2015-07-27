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
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation BUYImageView

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
	if (self.showsActivityIndicator) {
		[self.activityIndicatorView startAnimating];
	}
	self.task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.activityIndicatorView stopAnimating];
			if (error == nil && data) {
				UIImage *productImage = [UIImage imageWithData:data];
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
					[UIView animateWithDuration:imageDuration
									 animations:^{
										 self.alpha = 1.0f;
									 }];
				}
				if (completion) {
					completion(productImage, nil);
				}
			} else {
				if (completion) {
					completion(nil, error);
				}
			}
		});
	}];
	[self.task resume];
}

- (void)cancelImageTask {
	[self.task cancel];
	self.task = nil;
}

- (void)setTheme:(BUYTheme *)theme
{
	if (theme.style == BUYThemeStyleDark) {
		self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	} else {
		self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	}
}

@end
