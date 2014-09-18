//
//  CHKCheckout.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@class CHKCreditCard;
@class CHKAddress;
@class CHKShippingRate;

@interface CHKCheckout : MERObject

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, strong) NSNumber *requiresShipping;
@property (nonatomic, strong) NSNumber *taxesIncluded;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, strong) NSDecimalNumber *subtotalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalTax;
@property (nonatomic, strong) NSDecimalNumber *totalPrice;

@property (nonatomic, strong) NSString *paymentSessionId;
@property (nonatomic, strong) NSURL *paymentURL;
@property (nonatomic, strong) NSNumber *reservationTime;
@property (nonatomic, strong) NSNumber *reservationTimeLeft;

@property (nonatomic, readonly, copy) NSArray *lineItems;
@property (nonatomic, readonly, copy) NSArray *taxLines;

@property (nonatomic, strong) CHKAddress *billingAddress;
@property (nonatomic, strong) CHKAddress *shippingAddress;

@property (nonatomic, strong) CHKShippingRate *shippingRate;

- (void)updateWithDictionary:(NSDictionary *)dictionary;

@end

@interface CHKTaxLine : NSObject

@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, strong) NSDecimalNumber *rate;
@property (nonatomic, copy) NSString *title;

@end

@interface CHKAddress : NSObject

@property (nonatomic, copy) NSString *address1;
@property (nonatomic, copy) NSString *address2;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *zip;

@end

@interface CHKShippingRate : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSDecimalNumber *price;
@property (nonatomic, copy) NSString *title;

@end
