//
//  BUYShop.h
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
 *  The country in which the shop is located
 */
@property (nonatomic, readonly, copy) NSString *country;

/**
 *  The three-letter code for the currency that the shop accepts.
 */
@property (nonatomic, readonly, copy) NSString *currency;

/**
 *  A string representing the way currency is formatted when the currency isn't specified.
 */
@property (nonatomic, readonly, copy) NSString *moneyFormat;

/**
 *  The shop's domain.
 */
@property (nonatomic, readonly, copy) NSString *domain;

/**
 *  The shop's description.
 */
@property (nonatomic, readonly, copy) NSString *shopDescription;

/**
 *  A list of two-letter country codes identifying the countries that the shop ships to.
 */
@property (nonatomic, readonly, copy) NSArray *shipsToCountries;

/**
 *  The URL for the web storefront
 */
@property (nonatomic, readonly) NSURL *shopURL;

/**
 *  The shop's 'myshopify.com' domain.
 */
@property (nonatomic, readonly) NSURL *myShopifyURL;

@end
