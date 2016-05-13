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
#import "BUYClient_Internal.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "BUYCustomer.h"
#import "BUYAccountCredentials.h"
#import "BUYOrder.h"
#import "BUYShopifyErrorCodes.h"
#import "BUYRouter.h"

@interface BUYAuthenticatedResponse : NSObject
+ (BUYAuthenticatedResponse *)responseFromJSON:(NSDictionary *)json;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSDate *expiry;
@property (nonatomic, copy) NSString *customerID;
@end

@implementation BUYAuthenticatedResponse

+ (BUYAuthenticatedResponse *)responseFromJSON:(NSDictionary *)json
{
	BUYAuthenticatedResponse *response = [BUYAuthenticatedResponse new];
	NSDictionary *access = json[@"customer_access_token"];
	response.accessToken = access[@"access_token"];
	NSDateFormatter *formatter = [NSDateFormatter dateFormatterForPublications];
	response.expiry = [formatter dateFromString:access[@"expires_at"]];
	response.customerID = [NSString stringWithFormat:@"%@", access[@"customer_id"]];
	return response;
}

@end

@implementation BUYClient (Customers)

#pragma mark - Customer

- (NSURLSessionDataTask *)getCustomerWithID:(NSString *)customerID callback:(BUYDataCustomerBlock)block
{
	BUYRoute *route = [self.router routeForCustomersWithID:customerID];
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		BUYCustomer *customer = nil;
		if (json && !error) {
			customer = [self.modelManager customerWithJSONDictionary:json];
		}
		block(customer, error);
	}];
}

- (NSURLSessionDataTask *)createCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	BUYRoute *route = [self.router routeForCustomers];
	return [self postRequestForURL:route.URL object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			[self createTokenForCustomerWithCredentials:credentials customerJSON:json callback:block];
		}
		else {
			block(nil, nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)createTokenForCustomerWithCredentials:(BUYAccountCredentials *)credentials customerJSON:(NSDictionary *)customerJSON callback:(BUYDataCustomerTokenBlock)block
{
	BUYRoute *route = [self.router routeForCustomersToken];
	return [self postRequestForURL:route.URL object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseFromJSON:json];
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

- (NSURLSessionDataTask *)loginCustomerWithCredentials:(BUYAccountCredentials *)credentials callback:(BUYDataCustomerTokenBlock)block
{
	return [self createTokenForCustomerWithCredentials:credentials customerJSON:nil callback:block];
}

- (NSURLSessionDataTask *)recoverPasswordForCustomer:(NSString *)email callback:(BUYDataCheckoutStatusBlock)block
{
	BUYRoute *route = [self.router routeForCustomersPasswordRecovery];
	return [self postRequestForURL:route.URL object:@{@"email": email} completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		if (!error) {
			error = [self errorFromJSON:json response:response];
		}
		
		block(statusCode, error);
	}];
}

- (NSURLSessionDataTask *)renewCustomerTokenWithID:(NSString *)customerID callback:(BUYDataTokenBlock)block
{
	if (self.customerToken) {
		BUYRoute *route = [self.router routeForCustomersTokenRenewalWithID:customerID];
		
		return [self putRequestForURL:route.URL object:nil completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			
			NSString *accessToken = nil;
			if (json && !error) {
				BUYAuthenticatedResponse *authenticatedResponse = [BUYAuthenticatedResponse responseFromJSON:json];
				accessToken = authenticatedResponse.accessToken;
			}
			
			if (!error) {
				error = [self errorFromJSON:json response:response];
			}
			
			block(accessToken, error);
		}];
	}
	else {
		block(nil, [NSError errorWithDomain:kShopifyError code:BUYShopifyError_InvalidCustomerToken userInfo:nil]);
		return nil;
	}
}

- (NSURLSessionDataTask *)activateCustomerWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block
{
	BUYRoute *route  = [self.router routeForCustomersActivationWithID:customerID];
	route.queryItems = @{
						 @"token": customerToken,
						 };
	
	return [self putRequestForURL:route.URL object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
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

- (NSURLSessionDataTask *)resetPasswordWithCredentials:(BUYAccountCredentials *)credentials customerID:(NSString *)customerID customerToken:(NSString *)customerToken callback:(BUYDataCustomerTokenBlock)block
{
	BUYRoute *route  = [self.router routeForCustomersPasswordResetWithID:customerID];
	route.queryItems = @{
						 @"token": customerToken,
						 };
	
	return [self putRequestForURL:route.URL object:credentials.JSONRepresentation completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
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

- (NSURLSessionDataTask *)getOrdersForCustomerWithCallback:(BUYDataOrdersBlock)block
{
	BUYRoute *route = [self.router routeForCustomersOrders];
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			NSArray *orders = [self.modelManager ordersWithJSONDictionary:json];
			block(orders, error);
		} else {
			block(nil, error);
		}
	}];
}

@end
