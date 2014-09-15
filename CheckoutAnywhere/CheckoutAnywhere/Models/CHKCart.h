//
//  CHKCart.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface CHKCart : NSObject

@property (nonatomic, readonly, strong) NSArray *lineItems;

@end


/*
 @interface MERCart : NSObject
 
 @property (nonatomic, readonly, strong) NSArray *lineItems;
 
 - (void)addVariant:(MERProductVariant *)variant;
 - (void)clearCart;
 
 @end
 
 @interface MERLineItem : NSObject
 
 @property (nonatomic, copy) NSString *title;
 @property (nonatomic, strong) NSDecimalNumber *itemPrice;
 @property (nonatomic, strong) NSDecimalNumber *quantity;
 @property (nonatomic, strong) MERProductVariant *variant;
 
 - (instancetype)initWithVariant:(MERProductVariant*)variant;
 
 @end
*/