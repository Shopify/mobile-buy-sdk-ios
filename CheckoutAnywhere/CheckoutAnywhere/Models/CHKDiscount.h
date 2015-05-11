//
//  CHKDiscount.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

/**
 *  CHKDiscount represents a discount that is applied to the CHKCheckout.
 */
@interface CHKDiscount : CHKObject <CHKSerializable>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, assign) BOOL applicable;

- (instancetype)initWithCode:(NSString *)code;

@end
