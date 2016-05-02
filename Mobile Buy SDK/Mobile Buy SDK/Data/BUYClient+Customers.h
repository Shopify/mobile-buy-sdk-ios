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

#import "BUYClient.h"

@class BUYCustomer;
@class BUYOrder;
@class BUYAccountCredentials;

/**
 *  Return block containing a BUYCustomer object for an existing customer of the shop
 *
 *  @param customer A BUYCustomer
 *  @param error    An optional NSError
 */
typedef void (^BUYDataCustomerBlock)(BUYCustomer *customer, NSError *error);

/**
 *  Return block containing a customer auth token
 *
 *  @param customer A BUYCustomer
 *  @param token    An authentication token to retrieve the customer later.  Store this token securely on the device.
 *  @param error    An optional NSError
 */
typedef void (^BUYDataCustomerTokenBlock)(BUYCustomer *customer, NSString *token, NSError *error);

/**
 *  Return block containing a customer auth token
 *
 *  @param token    An authentication token to retrieve the customer later.  Store this token securely on the device.
 *  @param error    An optional NSError
 */
typedef void (^BUYDataTokenBlock)(NSString *token, NSError *error);

/**
 *  Return block containing an array of BUYOrders
 *
 *  @param orders An array of BUYOrders
 *  @param error  An optional NSError
 */
typedef void (^BUYDataOrdersBlock)(NSArray <BUYOrder*> *orders, NSError *error);


@interface BUYClient (Customers)

/**
 *  GET /api/customers/:customer_id
 *  Gets an existing customer
 *
 *  @param customerID A customer ID retrieved from either customer creation or login
 *  @param block      (BUYCustomer *customer, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getCustomerWithID:(NSString *)customerID callback:(BUYDataCustomerBlock)block;

/**
 *  POST /api/customers
 *  Creates a new customer
 *  Expects first name, last name, email, password, and password confirmation
 *
 *  @param credentials Credentials object containing items for required fields
 *  @param block       (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 *
 *  @discussion The customer is automatically logged in using -loginCustomerWithCredentials:callback:
 */
- (NSURLSessionDataTask *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block;

/**
 *  POST /api/customers/customer_token
 *  Logs in an existing customer
 *  Expects email and password
 *
 *  @param credentials Credentials object containing items for required fields
 *  @param block    (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block;

/**
 *  POST /api/customers/recover
 *  Sends email for password recovery to an existing customer
 *
 *  @param email Email to send the password reset to
 *  @param block (BUYStatus status, NSError *error)
 *
 *  @return the associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataCheckoutStatusBlock)block;

/**
 *  PUT /api/customers/:customer_id/customer_token/renew
 *  Renews an existing customer's token
 *
 *  @param customerID ID of customer renewing token
 *  @param block      (NSString *token, NSError *error)
 *
 *  @return the associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)renewCustomerTokenWithID:(NSString *)customerID callback:(BUYDataTokenBlock)block;

/**
 *  PUT /api/customers/:customer_id/activate
 *  Activates an unactivated customer
 *
 *  @param credentials   Credentials containing a password and password confirmation
 *  @param customerID    ID of customer being activated
 *  @param customerToken Token contained in activation URL
 *  @param block         (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block;

/**
 *  PUT /api/customers/:customer_id/reset
 *  Resets an existing customer's password
 *
 *  @param credentials   Credentials containing a password and password confirmation
 *  @param customerID    ID of customer resetting password
 *  @param customerToken Token contained in reset URL
 *  @param block         (BUYCustomer *customer, NSString *token, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block;

/**
 *  GET /api/customers/:customer_id/orders
 *  Gets orders for a given customer
 *
 *  @param token An auth token retrieved from customer creation or customer login API
 *  @param block    (NSArray <BUYOrder*> *orders, NSError *error)
 *
 *  @return The associated NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getOrdersForCustomerWithCallback:(BUYDataOrdersBlock)block;

@end
