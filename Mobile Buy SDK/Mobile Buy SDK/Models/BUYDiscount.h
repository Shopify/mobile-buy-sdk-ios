//
//  BUYDiscount.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"
#import "BUYSerializable.h"

/**
 *   BUYDiscount represents a discount that is applied to the BUYCheckout.
 */
@interface BUYDiscount : BUYObject <BUYSerializable>

/**
 *  The unique identifier for the discount code.
 */
@property (nonatomic, copy) NSString *code;

/**
 *  The amount that is deducted from `paymentDue` on BUYCheckout.
 */
@property (nonatomic, strong) NSDecimalNumber *amount;

/**
 *  Whether this discount code can be applied to the checkout.
 */
@property (nonatomic, assign) BOOL applicable;

/**
 *  Created a BUYDiscount with a code
 *
 *  @param code The discount code
 *
 *  @return BUYDiscount object
 */
- (instancetype)initWithCode:(NSString *)code;

@end
