//
//  BUYShop.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

/**
 *  The BUYShop object is a collection of the general settings and information about the shop.
 */
@interface BUYShop : BUYObject

/**
 *  The name of the shop.
 */
@property (nonatomic, readonly, copy) NSString *name;

/**
 *  The city in which the shop is located.
 */
@property (nonatomic, readonly, copy) NSString *city;

/**
 *  The shop's normalized province or state name.
 */
@property (nonatomic, readonly, copy) NSString *province;

/**
 *  The three-letter code for the currency that the shop accepts.
 */
@property (nonatomic, readonly, copy) NSString *currency;

/**
 *  The shop's domain.
 */
@property (nonatomic, readonly, copy) NSString *domain;

/**
 *  The shop's description.
 */
@property (nonatomic, readonly, copy) NSString *shopDescription;

/**
 *  A list of countries the shop ships containing two-letter country codes.
 */
@property (nonatomic, readonly, copy) NSArray *shipsToCountries;

@end
