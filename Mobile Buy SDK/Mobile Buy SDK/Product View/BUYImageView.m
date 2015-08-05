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
	if (self.task) {
		[self cancelImageTask];
	}
    if (self.showsActivityIndicator) {
        [self.activityIndicatorView startAnimating];
    }
	self.task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			UIImage *image = [UIImage imageWithData:data];
			self.image = image;
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
	if (theme.style == BUYThemeStyleDark) {
		self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	} else {
		self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	}
}

- (BOOL)isPortraitOrSquare
{
	return self.image.size.height >= self.image.size.width;
}

@end
