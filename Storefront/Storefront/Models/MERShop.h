//
//  MERShop.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "MERObject.h"

@interface MERShop : MERObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *shopDescription;
@property (nonatomic, copy) NSArray *shipsToCountries;

@end
