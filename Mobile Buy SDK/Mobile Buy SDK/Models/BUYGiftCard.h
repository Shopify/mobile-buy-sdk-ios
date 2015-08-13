//
//  BUYGiftCard.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"
#import "BUYSerializable.h"

@interface BUYGiftCard : BUYObject <BUYSerializable>

/**
 *  The gift card code. This is only used when applying a gift card and 
 *  is not visible on a BUYCheckout object synced with Shopify.
 */
@property (nonatomic, readonly, copy) NSString *code;

/**
 *  The last characters of the applied gift card code.
 */
@property (nonatomic, readonly, copy) NSString *lastCharacters;

/**
 *  The amount left on the gift card after being applied to this checkout.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *balance;

/**
 *  The amount of the gift card used by this checkout.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *amountUsed;

@end
