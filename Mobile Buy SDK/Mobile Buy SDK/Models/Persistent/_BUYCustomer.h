//
//  _BUYCustomer.h
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
// Make changes to BUYCustomer.h instead.

#import <Buy/BUYManagedObject.h>

#import <Buy/BUYModelManager.h>

extern const struct BUYCustomerAttributes {
	__unsafe_unretained NSString *acceptsMarketing;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *customerState;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *lastOrderID;
	__unsafe_unretained NSString *lastOrderName;
	__unsafe_unretained NSString *multipassIdentifier;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *ordersCount;
	__unsafe_unretained NSString *tags;
	__unsafe_unretained NSString *taxExempt;
	__unsafe_unretained NSString *totalSpent;
	__unsafe_unretained NSString *updatedAt;
	__unsafe_unretained NSString *verifiedEmail;
} BUYCustomerAttributes;

extern const struct BUYCustomerRelationships {
	__unsafe_unretained NSString *addresses;
	__unsafe_unretained NSString *defaultAddress;
} BUYCustomerRelationships;

@class BUYAddress;
@class BUYAddress;

@class BUYCustomer;
@interface BUYModelManager (BUYCustomerInserting)
- (NSArray<BUYCustomer *> *)allCustomerObjects;
- (BUYCustomer *)fetchCustomerWithIdentifierValue:(int64_t)identifier;
- (BUYCustomer *)insertCustomerWithJSONDictionary:(NSDictionary *)dictionary;
- (NSArray<BUYCustomer *> *)insertCustomersWithJSONArray:(NSArray <NSDictionary *> *)array;
@end

@interface _BUYCustomer : BUYCachedObject
+ (NSString *)entityName;

@property (nonatomic, strong) NSNumber* acceptsMarketing;

@property (atomic) BOOL acceptsMarketingValue;
- (BOOL)acceptsMarketingValue;
- (void)setAcceptsMarketingValue:(BOOL)value_;

@property (nonatomic, strong) NSDate* createdAt;

@property (nonatomic, strong) NSNumber* customerState;

@property (atomic) BOOL customerStateValue;
- (BOOL)customerStateValue;
- (void)setCustomerStateValue:(BOOL)value_;

@property (nonatomic, strong) NSString* email;

@property (nonatomic, strong) NSString* firstName;

@property (nonatomic, strong) NSNumber* identifier;

@property (atomic) int64_t identifierValue;
- (int64_t)identifierValue;
- (void)setIdentifierValue:(int64_t)value_;

@property (nonatomic, strong) NSString* lastName;

@property (nonatomic, strong) NSNumber* lastOrderID;

@property (atomic) int64_t lastOrderIDValue;
- (int64_t)lastOrderIDValue;
- (void)setLastOrderIDValue:(int64_t)value_;

@property (nonatomic, strong) NSString* lastOrderName;

@property (nonatomic, strong) NSString* multipassIdentifier;

@property (nonatomic, strong) NSString* note;

@property (nonatomic, strong) NSNumber* ordersCount;

@property (atomic) int16_t ordersCountValue;
- (int16_t)ordersCountValue;
- (void)setOrdersCountValue:(int16_t)value_;

@property (nonatomic, strong) NSString* tags;

@property (nonatomic, strong) NSNumber* taxExempt;

@property (atomic) BOOL taxExemptValue;
- (BOOL)taxExemptValue;
- (void)setTaxExemptValue:(BOOL)value_;

@property (nonatomic, strong) NSDecimalNumber* totalSpent;

@property (nonatomic, strong) NSDate* updatedAt;

@property (nonatomic, strong) NSNumber* verifiedEmail;

@property (atomic) BOOL verifiedEmailValue;
- (BOOL)verifiedEmailValue;
- (void)setVerifiedEmailValue:(BOOL)value_;

@property (nonatomic, strong) NSSet *addresses;
- (NSMutableSet *)addressesSet;

@property (nonatomic, strong) BUYAddress *defaultAddress;

@end

@interface _BUYCustomer (AddressesCoreDataGeneratedAccessors)

@end

@interface _BUYCustomer (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAcceptsMarketing;
- (void)setPrimitiveAcceptsMarketing:(NSNumber*)value;

- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;

- (NSNumber*)primitiveCustomerState;
- (void)setPrimitiveCustomerState:(NSNumber*)value;

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;

- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;

- (NSNumber*)primitiveLastOrderID;
- (void)setPrimitiveLastOrderID:(NSNumber*)value;

- (NSString*)primitiveLastOrderName;
- (void)setPrimitiveLastOrderName:(NSString*)value;

- (NSString*)primitiveMultipassIdentifier;
- (void)setPrimitiveMultipassIdentifier:(NSString*)value;

- (NSString*)primitiveNote;
- (void)setPrimitiveNote:(NSString*)value;

- (NSNumber*)primitiveOrdersCount;
- (void)setPrimitiveOrdersCount:(NSNumber*)value;

- (NSString*)primitiveTags;
- (void)setPrimitiveTags:(NSString*)value;

- (NSNumber*)primitiveTaxExempt;
- (void)setPrimitiveTaxExempt:(NSNumber*)value;

- (NSDecimalNumber*)primitiveTotalSpent;
- (void)setPrimitiveTotalSpent:(NSDecimalNumber*)value;

- (NSDate*)primitiveUpdatedAt;
- (void)setPrimitiveUpdatedAt:(NSDate*)value;

- (NSNumber*)primitiveVerifiedEmail;
- (void)setPrimitiveVerifiedEmail:(NSNumber*)value;

- (NSMutableSet *)primitiveAddresses;
- (void)setPrimitiveAddresses:(NSMutableSet *)value;

- (BUYAddress *)primitiveDefaultAddress;
- (void)setPrimitiveDefaultAddress:(BUYAddress *)value;

@end
