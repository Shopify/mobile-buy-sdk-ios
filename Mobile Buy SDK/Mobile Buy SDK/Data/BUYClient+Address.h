//
//  BUYClient+Address.h
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

#import <Buy/BUYClient+Customers.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYAddress;

/**
 *  Return block containing an array of BUYAddress objects for an existing customer of the shop
 *
 *  @param addresses  An array containing BUYAddress objects
 *  @param error      An optional NSError
 */
typedef void (^BUYDataAddressesBlock)(NSArray<BUYAddress *> * _Nullable addresses, NSError * _Nullable error);

/**
 *  Return block containing a BUYAddress object for an existing customer of the shop
 *
 *  @param address  A BUYAddress
 *  @param error    An optional NSError
 */
typedef void (^BUYDataAddressBlock)(BUYAddress * _Nullable address, NSError * _Nullable error);

@interface BUYClient (Address)

/**
 *  GET /api/customers/:customer_id/addresses
 *  Fetch all customer addresses
 *
 *  @param block      (NSArray<BUYAddress *> *addresses, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getAddressesCallback:(BUYDataAddressesBlock)block;

/**
 *  GET /api/customers/:customer_id/addresses/:id
 *  Fetch a customer address by ID
 *
 *  @param addressID  Identifier of the address to fetch
 *  @param block      (BUYAddress *address, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getAddressWithID:(NSNumber *)addressID callback:(BUYDataAddressBlock)block;

/**
 *  POST /api/customers/:customer_id/addresses
 *  Creates a new customer address
 *
 *  @param address  Address to create
 *  @param block    (BUYAddress *address, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)createAddress:(BUYAddress *)address callback:(BUYDataAddressBlock)block;

/**
 *  PUT /api/customers/:customer_id/addresses/:id
 *  Updates the customer address
 *
 *  @param address    Address to update, containing updated values
 *  @param block      (BUYAddress *address, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)updateAddress:(BUYAddress *)address callback:(BUYDataAddressBlock)block;

/**
 *  DELETE /api/customers/:customer_id/addresses/:id
 *  Delete the customer address
 *
 *  @param addressID  Address ID to delete
 *  @param block      (BUYStatus status, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)deleteAddressWithID:(NSNumber *)addressID callback:(BUYDataStatusBlock)block;

@end

NS_ASSUME_NONNULL_END
