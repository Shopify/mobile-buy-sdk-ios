//
//  CHKShop.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKObject.h"

@interface CHKShop : CHKObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *province;
@property (nonatomic, readonly, copy) NSString *currency;
@property (nonatomic, readonly, copy) NSString *domain;
@property (nonatomic, readonly, copy) NSString *shopDescription;
@property (nonatomic, readonly, copy) NSArray *shipsToCountries;

@end
