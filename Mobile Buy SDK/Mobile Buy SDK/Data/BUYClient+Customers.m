//
//  BUYClient+Customers.m
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

#import "BUYClient+Customers.h"
#import "BUYClient+Internal.h"
#import "BUYClient+Routing.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "BUYCustomer.h"
#import "BUYAccountCredentials.h"
#import "BUYCustomerToken.h"
#import "BUYOrder.h"
#import "BUYShopifyErrorCodes.h"

@implementation BUYClient (Customers)

#pragma mark - Getting -

- (NSOperation *)getCustomerWithID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	NSURL *url = [self urlForCustomersWithID:customerID];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

#pragma mark - Customer -

- (NSOperation *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *url = [self urlForCustomers];
	return [self postRequestForURL:url object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			[self createTokenForCustomerWithCredentials:credentials customerJSON:json callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSOperation *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *url = [self urlForCustomersActivationWithID:customerID parameters:@{ @"token": token }];
	
	return [self putRequestForURL:url object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		NSString *email = json[@"customer"][@"email"];
		if (email && !error) {
			BUYAccountCredentialItem *emailItem = [BUYAccountCredentialItem itemWithEmail:email];
			[self loginCustomerWithCredentials:[credentials credentialsByAddingItems:@[emailItem]] callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSOperation *)updateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	NSURL *url = [self urlForCustomersWithID:customerID];
	return [self putRequestForURL:url object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

- (NSOperation *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *url = [self urlForCustomersPasswordResetWithID:customerID parameters:@{ @"token": token }];
	
	return [self putRequestForURL:url object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		NSString *email = json[@"customer"][@"email"];
		if (email && !error) {
			BUYAccountCredentialItem *emailItem = [BUYAccountCredentialItem itemWithEmail:email];
			[self loginCustomerWithCredentials:[credentials credentialsByAddingItems:@[emailItem]] callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

#pragma mark - Token -

- (NSOperation *)renewCustomerTokenWithID:(NSString *)customerID callback:(BUYDataTokenBlock)block
{
	if (self.customerToken) {
		NSURL *url = [self urlForCustomersTokenRenewalWithID:customerID];
		
		return [self putRequestForURL:url object:nil completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
			NSString *accessToken = nil;
			if (json && !error) {
				BUYCustomerToken *authenticatedResponse = [BUYCustomerToken responseWithJSON:json];
				accessToken = authenticatedResponse.accessToken;
			}
			
			block(accessToken, error);
		}];
	}
	else {
		block(nil, [NSError errorWithDomain:BUYShopifyErrorDomain code:BUYShopifyError_InvalidCustomerToken userInfo:nil]);
		return nil;
	}
}

#pragma mark - Login -

- (NSOperation *)logoutCustomerID:(NSString *)customerID callback:(BUYDataStatusBlock)block
{
	NSURL *url = [self urlForCustomersTokenWithID:customerID];
	return [self deleteRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block(response.statusCode, error);
	}];
}

- (NSOperation *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	return [self createTokenForCustomerWithCredentials:credentials customerJSON:nil callback:block];
}

- (NSOperation *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataStatusBlock)block
{
	NSURL *url = [self urlForCustomersPasswordRecovery];
	return [self postRequestForURL:url object:@{@"email": email} completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block(response.statusCode, error);
	}];
}

#pragma mark - Orders -

- (NSOperation *)getOrdersForCustomerWithID:(NSString *)customerID callback:(BUYDataOrdersBlock)block
{
	NSURL *url = [self urlForCustomersOrdersWithID:customerID];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			NSArray *orders = [self.modelManager ordersWithJSONDictionary:json];
			block(orders, error);
		} else {
			block(nil, error);
		}
	}];
}

- (NSOperation *)getOrderWithID:(NSNumber *)orderID customerID:(NSString *)customerID callback:(BUYDataOrderBlock)block
{
	NSURL *url = [self urlForCustomersOrdersWithID:customerID orderID:orderID];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			BUYOrder *order = [self.modelManager orderWithJSONDictionary:json];
			block(order, error);
		} else {
			block(nil, error);
		}
	}];
}

#pragma mark - Helpers -

- (NSOperation *)createTokenForCustomerWithCredentials:(BUYAccountCredentials *)credentials customerJSON:(NSDictionary *)customerJSON callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *url = [self urlForCustomersToken];
	return [self postRequestForURL:url object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			BUYCustomerToken *authenticatedResponse = [BUYCustomerToken responseWithJSON:json];
			self.customerToken = authenticatedResponse.accessToken;
			
			if (!customerJSON) {
				[self getCustomerWithID:authenticatedResponse.customerID callback:^(BUYCustomer *customer, NSError *error) {
					block(customer, self.customerToken, error);
				}];
			}
			else {
				BUYCustomer *customer = [self.modelManager customerWithJSONDictionary:customerJSON];
				block(customer, self.customerToken, error);
			}
		}
		else {
			block(nil, nil, error);
		}
	}];
}

@end
