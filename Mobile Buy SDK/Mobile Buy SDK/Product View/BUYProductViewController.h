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
 *  The product to be displayed.  This can be set before presentation instead of calling loadProduct:completion:
 */
@property (nonatomic, strong) BUYProduct *product;

/**
 *  The loaded product ID
 */
@property (nonatomic, strong, readonly) NSString *productId;

/**
 *  The product view controller's delegate
 */
@property (nonatomic, weak) id<BUYProductViewControllerDelegate> productDelegate;

@end

@protocol BUYProductViewControllerDelegate <NSObject>

/**
 *  Called when the user dismisses the product view controller
 *
 *  @param viewController the dismissed view controller
 */
- (void)productViewControllerDidFinish:(BUYProductViewController *)viewController;

@optional

/**
 *  Called when the user chooses to checkout via web checkout which will open Safari
 *
 *  @param viewController the product view controller
 */
- (void)productViewControllerWillCheckoutViaWeb:(BUYProductViewController *)viewController;

/**
 *  Called when the user chooses to checkout via Apple Pay
 *
 *  @param viewController the product view controller
 */
- (void)productViewControllerWillCheckoutViaApplePay:(BUYProductViewController *)viewController;

/**
 *  Called when the user successfully makes a purchase using Apple Pay
 *
 *  @param viewController the product view controller
 */
- (void)productViewControllerDidFinishCheckoutViaApplePay:(BUYProductViewController *)viewController;

/**
 *  Called when Apple Pay checkout fails
 *
 *  @param viewController the product view controller
 *  @param error          an error object representing the failure reason
 */
- (void)productViewController:(BUYProductViewController *)viewController didFailCheckoutViaApplePay:(NSError *)error;

@end
