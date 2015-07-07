//
//  ProductViewController.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

@import UIKit;
#import <Buy/Buy.h>

@interface ProductController : BUYViewController

- (instancetype)initWithClient:(BUYClient *)client productId:(NSString *)handle;

@end

