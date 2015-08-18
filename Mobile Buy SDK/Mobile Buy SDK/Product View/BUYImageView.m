//
//  BUYImageView.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-09.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYImageView.h"
#import "BUYTheme+Additions.h"

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
	self.task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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

- (void)cancelImageTask {
	[self.task cancel];
	self.task = nil;
}

- (void)setTheme:(BUYTheme *)theme
{
	self.activityIndicatorView.activityIndicatorViewStyle = [theme activityIndicatorViewStyle];
}

- (BOOL)isPortraitOrSquare
{
	return self.image.size.height >= self.image.size.width;
}

@end
