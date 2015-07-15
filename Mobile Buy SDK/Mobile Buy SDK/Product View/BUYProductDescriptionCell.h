//
//  BUYProductDescriptionCell.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUYTheme.h"

@interface BUYProductDescriptionCell : UITableViewCell <BUYThemeable>

@property (nonatomic, copy) NSString *descriptionHTML;

@end
