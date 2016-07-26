//
//  _BUYShop.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BUYShop.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYShopAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *currency;
	__unsafe_unretained NSString *domain;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *moneyFormat;
	__unsafe_unretained NSString *myShopifyURL;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *province;
	__unsafe_unretained NSString *publishedCollectionsCount;
	__unsafe_unretained NSString *publishedProductsCount;
	__unsafe_unretained NSString *shipsToCountries;
	__unsafe_unretained NSString *shopDescription;
	__unsafe_unretained NSString *shopURL;
} BUYShopAttributes;

extern const struct BUYShopUserInfo {
	__unsafe_unretained NSString *documentation;
} BUYShopUserInfo;

@class NSURL;

@class NSArray;

@class NSURL;

@class BUYShop;
@interface BUYModelManager (BUYShopInserting)
- (NSArray<BUYShop *> *)allShopObjects;
- (BUYShop *)fetchShopWithIdentifierValue:(int64_t)identifier;
- (BUYShop *)insertShopWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYShop *> *)insertShopsWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

/**
 * The BUYShop object is a collection of the general settings and information about the shop.
 */
@interface _BUYShop : BUYCachedObject
+ (NSString *)entityName;

/**
 * The city in which the shop is located.
 */
@property (nonatomic, strong) NSString* city;

/**
 * The country in which the shop is located.
 */
@property (nonatomic, strong) NSString* country;

/**
 * The three-letter code for the currency that the shop accepts.
 */
@property (nonatomic, strong) NSString* currency;

/**
 * The shop's domain.
 */
@property (nonatomic, strong) NSString* domain;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

/**
 * A string representing the way currency is formatted when the currency isn't specified.
 */
@property (nonatomic, strong) NSString* moneyFormat;

/**
 * The shop's 'myshopify.com' domain.
 *
 * Maps to "myshopify_domain" in JSON.
 */
@property (nonatomic, strong) NSURL* myShopifyURL;

/**
 * The name of the shop.
 */
@property (nonatomic, strong) NSString* name;

/**
 * The shop's normalized province or state name.
 */
@property (nonatomic, strong) NSString* province;

@property (nonatomic, strong) NSNumber* publishedCollectionsCount;

@property (atomic) int64_t publishedCollectionsCountValue;
- (int64_t)publishedCollectionsCountValue;
- (void)setPublishedCollectionsCountValue:(int64_t)value_;

@property (nonatomic, strong) NSNumber* publishedProductsCount;

@property (atomic) int64_t publishedProductsCountValue;
- (int64_t)publishedProductsCountValue;
- (void)setPublishedProductsCountValue:(int64_t)value_;

/**
 * A list of two-letter country codes identifying the countries that the shop ships to.
 */
@property (nonatomic, strong) NSArray* shipsToCountries;

/**
 * The shop's description.
 *
 * Maps to "description" in JSON.
 */
@property (nonatomic, strong) NSString* shopDescription;

@property (nonatomic, strong) NSURL* shopURL;

@end

@interface _BUYShop (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;

- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;

- (NSString*)primitiveCurrency;
- (void)setPrimitiveCurrency:(NSString*)value;

- (NSString*)primitiveDomain;
- (void)setPrimitiveDomain:(NSString*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSString*)primitiveMoneyFormat;
- (void)setPrimitiveMoneyFormat:(NSString*)value;

- (NSURL*)primitiveMyShopifyURL;
- (void)setPrimitiveMyShopifyURL:(NSURL*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveProvince;
- (void)setPrimitiveProvince:(NSString*)value;

- (NSNumber*)primitivePublishedCollectionsCount;
- (void)setPrimitivePublishedCollectionsCount:(NSNumber*)value;

- (NSNumber*)primitivePublishedProductsCount;
- (void)setPrimitivePublishedProductsCount:(NSNumber*)value;

- (NSArray*)primitiveShipsToCountries;
- (void)setPrimitiveShipsToCountries:(NSArray*)value;

- (NSString*)primitiveShopDescription;
- (void)setPrimitiveShopDescription:(NSString*)value;

- (NSURL*)primitiveShopURL;
- (void)setPrimitiveShopURL:(NSURL*)value;

@end
