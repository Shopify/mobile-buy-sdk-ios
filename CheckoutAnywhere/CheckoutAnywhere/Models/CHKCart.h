//
//  CHKCart.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@class CHKLineItem;
@class MERProductVariant;

@interface CHKCart : NSObject

@property (nonatomic, readonly, strong) NSArray *lineItems;

- (BOOL)isValid;
- (void)clearCart;

#pragma mark - Simple Cart Editing

/**
 * Adds a variant to the cart. If the existing line item exists, that line item's quantity is increased by one.
 */
- (void)incrementVariant:(MERProductVariant *)variant;

/**
 * Removes a variant from the cart. If the existing line item exists, that line item's quantity is decreased by one.
 */
- (void)decrementVariant:(MERProductVariant *)variant;

/**
 * Removes a variant from the cart. If an existing line item exists, that line item is removed completely.
 */
- (void)removeVariant:(MERProductVariant *)variant;

#pragma mark - Direct Line Item Editing

- (void)addLineItemsObject:(CHKLineItem *)object;
- (void)removeLineItemsObject:(CHKLineItem *)object;

@end

@interface CHKLineItem : NSObject

@property (nonatomic, strong) MERProductVariant *variant;
@property (nonatomic, strong) NSDecimalNumber *quantity;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithVariant:(MERProductVariant *)variant;

@end
