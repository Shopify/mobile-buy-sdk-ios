//
//  BUYVariantSelectionViewController.h
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-06-24.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUYProduct;
@class BUYVariantSelectionViewController;
@class BUYProductVariant;
@class BUYTheme;

@protocol BUYVariantSelectionDelegate <NSObject>

- (void)variantSelectionController:(BUYVariantSelectionViewController *)controller didSelectVariant:(BUYProductVariant *)variant;

@end

@interface BUYVariantSelectionViewController : UIViewController

- (instancetype)initWithProduct:(BUYProduct *)product;

@property (nonatomic, strong, readonly) BUYProduct *product;

@property (nonatomic, weak) id <BUYVariantSelectionDelegate> delegate;

@property (nonatomic, strong) BUYTheme *theme;

@end
