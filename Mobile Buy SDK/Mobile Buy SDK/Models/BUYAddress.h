//
//  BUYAddress.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"
#import "BUYSerializable.h"

/**
 *  A BUYAddress represents a shipping or billing address on an order. This will be associated with the customer upon completion.
 */
@interface BUYAddress : BUYObject <BUYSerializable>

/**
 *  The street address of the address.
 */
@property (nonatomic, copy) NSString *address1;

/**
 *  An optional additional field for the street address of the address.
 */
@property (nonatomic, copy) NSString *address2;

/**
 *   The city of the address.
 */
@property (nonatomic, copy) NSString *city;

/**
 *  The company of the person associated with the address (optional).
 */
@property (nonatomic, copy) NSString *company;

/**
 *  The first name of the person associated with the payment method.
 */
@property (nonatomic, copy) NSString *firstName;

/**
 *  The last name of the person associated with the payment method.
 */
@property (nonatomic, copy) NSString *lastName;

/**
 *  The phone number at the address.
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  The name of the country of the address.
 */
@property (nonatomic, copy) NSString *country;

/**
 *  The two-letter code (ISO 3166-1 alpha-2 two-letter country code) for the country of the address.
 */
@property (nonatomic, copy) NSString *countryCode;

/**
 *  The name of the state or province of the address
 */
@property (nonatomic, copy) NSString *province;

/**
 *  The two-letter abbreviation of the state or province of the address.
 */
@property (nonatomic, copy) NSString *provinceCode;

/**
 *  The zip or postal code of the address.
 */
@property (nonatomic, copy) NSString *zip;

@end
