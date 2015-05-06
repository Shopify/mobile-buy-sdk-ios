//
//  CHKGiftCard.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "CHKObject.h"
#import "CHKSerializable.h"

@class CHKCheckout;

@interface CHKGiftCard : CHKObject <CHKSerializable>

/**
 *  <#Description#>
 */
@property (nonatomic, readonly, copy) NSString *code;

/**
 *  <#Description#>
 */
@property (nonatomic, readonly, copy) NSString *lastCharacters;

/**
 *  <#Description#>
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *balance;

/**
 *  <#Description#>
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *amountUsed;

/**
 *  <#Description#>
 */
@property (nonatomic, readonly, strong) CHKCheckout *checkout;

@end
