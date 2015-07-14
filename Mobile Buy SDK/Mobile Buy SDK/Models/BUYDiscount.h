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

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, assign) BOOL applicable;

- (instancetype)initWithCode:(NSString *)code;

@end
