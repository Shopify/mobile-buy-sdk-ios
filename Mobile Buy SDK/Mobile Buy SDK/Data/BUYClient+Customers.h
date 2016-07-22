//
//  BUYClient+Customers.h
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

#import <Buy/BUYClient.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYAccountCredentials;
@class BUYCustomer;
@class BUYCustomerToken;
@class BUYOrder;

/**
 *  Return block containing a BUYCustomer object for an existing customer of the shop
 *
 *  @param customer A BUYCustomer
 *  @param error    An optional NSError
 */
typedef void (^BUYDataCustomerBlock)(BUYCustomer * _Nullable customer, NSError * _Nullable error);

/**
 *  Return block containing a customer auth token
 *
 *  @param customer A BUYCustomer
 *  @param token    An authentication token to retrieve the customer later.  Store this token securely on the device.
 *  @param error    An optional NSError
 */
typedef void (^BUYDataCustomerTokenBlock)(BUYCustomer * _Nullable customer, BUYCustomerToken * _Nullable token, NSError * _Nullable error);

/**
 *  Return block containing a customer auth token
 *
 *  @param token    An authentication token to retrieve the customer later.  Store this token securely on the device.
 *  @param error    An optional NSError
 */
typedef void (^BUYDataTokenBlock)(BUYCustomerToken * _Nullable token, NSError * _Nullable error);

/**
 *  Return block containing an array of BUYOrders
 *
 *  @param orders An array of BUYOrders
 *  @param error  An optional NSError
 */
typedef void (^BUYDataOrdersBlock)(NSArray <BUYOrder*> * _Nullable orders, NSError * _Nullable error);

/**
 *  Return block containing a BUYOrder
 *
 *  @param order  A BUYOrder
 *  @param error  An optional NSError
 */
typedef void (^BUYDataOrderBlock)(BUYOrder * _Nullable order, NSError * _Nullable error);


@interface BUYClient (Customers)

#pragma mark - Getting -

/**
 *  GET /api/customers/:customer_id
 *  Gets an existing customer
 *
 *  @param block      (BUYCustomer *customer, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getCustomerCallback:(BUYDataCustomerBlock)block;

#pragma mark - Customer -

/**
 *  POST /api/customers
 *  Creates a new customer
 *  Expects first name, last name, email, and password
 *
 *  @param credentials Credentials object containing items for required fields
 *  @param block       (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 *
 *  @discussion The customer is automatically logged in using -loginCustomerWithCredentials:callback:
 */
- (NSOperation *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block;

/**
 *  PUT /api/customers/:customer_id/activate
 *  Activates an unactivated customer
 *
 *  @param credentials   Credentials containing a password
 *  @param customerID    ID of customer being activated
 *  @param token         Token contained in activation URL
 *  @param block         (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSNumber *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block;

/**
 *  PUT /api/customers/:customer_id
 *
 *  @param customer		the customer object to update
 *  @param block        (BUYCustomer *customer, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)updateCustomer:(BUYCustomer *)customer callback:(BUYDataCustomerBlock)block;

/**
 *  PUT /api/customers/:customer_id/reset
 *  Resets an existing customer's password
 *
 *  @param credentials   Credentials containing a password
 *  @param customerID    ID of customer resetting password
 *  @param token         Token contained in reset URL
 *  @param block         (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSNumber *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block;

#pragma mark - Token -

/**
 *  PUT /api/customers/:customer_id/customer_token/renew
 *  Renews an existing customer's token
 *
 *  @param block      (NSString *token, NSError *error)
 *
 *  @return the associated BUYRequestOperation
 */
- (NSOperation *)renewCustomerTokenCallback:(BUYDataTokenBlock)block;

#pragma mark - Login -

/**
 *  POST /api/customers/customer_token
 *  Logs in an existing customer
 *  Expects email and password
 *
 *  @param credentials Credentials object containing items for required fields
 *  @param block    (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block;

/**
 *  DELETE /api/customers/:customer_id/customer_token
 *  Logs out an existing customer
 *
 *  @param block    (BUYStatus status, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)logoutCustomerCallback:(BUYDataStatusBlock)block;

/**
 *  POST /api/customers/recover
 *  Sends email for password recovery to an existing customer
 *
 *  @param email Email to send the password reset to
 *  @param block (BUYStatus status, NSError *error)
 *
 *  @return the associated BUYRequestOperation
 */
- (NSOperation *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataStatusBlock)block;

#pragma mark - Orders -

/**
 *  GET /api/customers/:customer_id/orders
 *  Gets orders for a given customer
 *
 *  @param block      (NSArray <BUYOrder*> *orders, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getOrdersForCustomerCallback:(BUYDataOrdersBlock)block;

/**
 *  GET /api/customers/:customer_id/orders/:id
 *  Gets order with a given identifier
 *
 *  @param orderID    An order ID to retrieve
 *  @param block      (NSArray <BUYOrder*> *orders, NSError *error)
 *
 *  @return The associated BUYRequestOperation
 */
- (NSOperation *)getOrderWithID:(NSNumber *)orderID callback:(BUYDataOrderBlock)block;

@end

NS_ASSUME_NONNULL_END
