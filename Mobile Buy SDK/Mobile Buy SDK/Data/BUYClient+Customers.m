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
#import "BUYAuthenticatedResponse.h"
#import "BUYOrder.h"
#import "BUYShopifyErrorCodes.h"

@implementation BUYClient (Customers)

#pragma mark - Getting -

- (BUYRequestOperation *)getCustomerWithID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	NSURL *route = [self urlForCustomersWithID:customerID];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

#pragma mark - Customer -

- (BUYRequestOperation *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomers];
	return [self postRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			[self createTokenForCustomerWithCredentials:credentials customerJSON:json callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (BUYRequestOperation *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomersActivationWithID:customerID parameters:@{ @"token": token }];
	
	return [self putRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
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

- (BUYRequestOperation *)updateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	NSURL *route = [self urlForCustomersWithID:customerID];
	return [self putRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

- (BUYRequestOperation *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID token:(NSString *)token callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomersPasswordResetWithID:customerID parameters:@{ @"token": token }];
	
	return [self putRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
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

- (BUYRequestOperation *)renewCustomerTokenWithID:(NSString *)customerID callback:(BUYDataTokenBlock)block
{
	if (self.customerToken) {
		NSURL *route = [self urlForCustomersTokenRenewalWithID:customerID];
		
		return [self putRequestForURL:route object:nil completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
			NSString *accessToken = nil;
			if (json && !error) {
				BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseWithJSON:json];
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

- (BUYRequestOperation *)logoutCustomerID:(NSString *)customerID callback:(BUYDataStatusBlock)block
{
	NSURL *route = [self urlForCustomersTokenWithID:customerID];
	return [self deleteRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block(response.statusCode, error);
	}];
}

- (BUYRequestOperation *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	return [self createTokenForCustomerWithCredentials:credentials customerJSON:nil callback:block];
}

- (BUYRequestOperation *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataStatusBlock)block
{
	NSURL *route = [self urlForCustomersPasswordRecovery];
	return [self postRequestForURL:route object:@{@"email": email} completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block(response.statusCode, error);
	}];
}

#pragma mark - Orders -

- (BUYRequestOperation *)getOrdersForCustomerWithCallback:(BUYDataOrdersBlock)block
{
	NSURL *route = [self urlForCustomersOrders];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			NSArray *orders = [self.modelManager ordersWithJSONDictionary:json];
			block(orders, error);
		} else {
			block(nil, error);
		}
	}];
}

#pragma mark - Helpers -

- (BUYRequestOperation *)createTokenForCustomerWithCredentials:(BUYAccountCredentials *)credentials customerJSON:(NSDictionary *)customerJSON callback:(BUYDataCustomerTokenBlock)block
{
	NSURL *route = [self urlForCustomersToken];
	return [self postRequestForURL:route object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		if (json && !error) {
			BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseWithJSON:json];
			self.customerToken = authenticatedResponse.accessToken;
			
			if (!customerJSON) {
				[self getCustomerWithID:authenticatedResponse.customerID callback:^(BUYCustomer *customer, NSError *error) {
					block(customer, self.customerToken, error);
				}];
			}
			else {
				BUYCustomer *customer = [self.modelManager customerWithJSONDictionary:json[@"customer"]];
				block(customer, self.customerToken, error);
			}
		}
		else {
			block(nil, nil, error);
		}
	}];
}

@end
