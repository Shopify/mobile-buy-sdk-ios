//
//  BUYProductVariantCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUYProductVariant;

@interface BUYProductVariantCell : UITableViewCell

@property (nonatomic, strong) BUYProductVariant *productVariant;

@end
