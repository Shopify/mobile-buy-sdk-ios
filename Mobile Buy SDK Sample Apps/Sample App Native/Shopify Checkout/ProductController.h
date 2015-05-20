//
//  ProductViewController.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

@import UIKit;
@import Buy;

@interface ProductController : BUYViewController

- (instancetype)initWithDataProvider:(BUYClient *)dataProvider productId:(NSString *)handle;

@end

