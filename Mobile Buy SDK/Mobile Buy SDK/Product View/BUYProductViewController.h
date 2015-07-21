//
//  BUYProductViewController.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>
#import "BUYTheme.h"

@protocol BUYProductViewControllerDelegate;

@interface BUYProductViewController : BUYViewController <BUYThemeable>

/**
 *  Loads the product details
 *
 *  @param productId  the product ID for the item to display
 *  @param completion a block to be called on completion of the loading of the product details. Will be called on the main thread.
 *  Upon success, the view controller should be presented modally
 */
- (void)loadProduct:(NSString *)productId completion:(void (^)(BOOL success, NSError *error))completion;

/**
 *  Alternative method when setting the product (and optionally, shop) directly on the view controller
 *
 *  @param product  the product to display
 *  @param completion block called when view controller is ready for display. Called on main thread
 */
- (void)loadWithProduct:(BUYProduct *)product completion:(void (^)(BOOL success, NSError *error))completion;

/**
 *  The loaded product ID
 */
@property (nonatomic, strong, readonly) NSString *productId;

/**
 *  The product to be displayed.  This can be set before presentation instead of calling loadProduct:completion:
 */
@property (nonatomic, strong, readonly) BUYProduct *product;

/**
 *  Returns YES when the view controller is loading data.  loadProduct: or loadWithProduct: should not be called when data is already loading
 */
@property (nonatomic, assign, readonly) BOOL isLoading;

@end


