//
//  CHKCheckout.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface CHKCheckout : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *paymentURL;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *paymentSessionID;
@property (nonatomic, strong) NSDecimalNumber *subtotalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalTax;

@property (nonatomic, strong) NSArray *lineItems;

@end
