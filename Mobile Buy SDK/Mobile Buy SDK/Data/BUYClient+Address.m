//
//  BUYClient+Address.m
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

#import "BUYClient+Address.h"
#import "BUYClient+Routing.h"
#import "BUYClient+Internal.h"
#import "BUYCustomer.h"
#import "BUYAddress.h"
#import "BUYAssert.h"

@implementation BUYClient (Address)

- (NSOperation *)getAddressesCallback:(BUYDataAddressesBlock)block
{
	NSURL *route = [self urlForCustomersAddresses];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		NSArray<BUYAddress *> *addresses = nil;
		if (json && !error) {
			addresses = [self.modelManager insertAddresssWithJSONArray:json[@"addresses"]];
		}
		block(addresses, error);
	}];
}

- (NSOperation *)getAddressWithID:(NSNumber *)addressID callback:(BUYDataAddressBlock)block
{
	NSURL *route = [self urlForCustomersAddressWithAddressID:addressID];
	return [self getRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYAddress *address = nil;
		if (json && !error) {
			address = [self.modelManager insertAddressWithJSONDictionary:json[@"address"]];
		}
		block(address, error);
	}];
}

- (NSOperation *)createAddress:(BUYAddress *)address callback:(BUYDataAddressBlock)block
{
	NSURL *route = [self urlForCustomersAddresses];
	return [self postRequestForURL:route object:@{ @"address" : address.JSONDictionary } completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYAddress *address = nil;
		if (json && !error) {
			address = [self.modelManager insertAddressWithJSONDictionary:json[@"address"]];
		}
		block(address, error);
	}];
}

- (NSOperation *)updateAddress:(BUYAddress *)address callback:(BUYDataAddressBlock)block
{
	BUYAssert(address.identifier, @"Failed to update address. Address must have a valid identifier.");
	
	NSURL *route = [self urlForCustomersAddressWithAddressID:address.identifier];
	return [self putRequestForURL:route object:@{ @"address" : address.JSONDictionary } completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		BUYAddress *address = nil;
		if (json && !error) {
			address = [self.modelManager insertAddressWithJSONDictionary:json[@"address"]];
		}
		block(address, error);
	}];
}

- (NSOperation *)deleteAddressWithID:(NSNumber *)addressID callback:(BUYDataStatusBlock)block
{
	BUYAssert(addressID, @"Failed to update address. Address must have a valid identifier.");
	
	NSURL *route = [self urlForCustomersAddressWithAddressID:addressID];
	return [self deleteRequestForURL:route completionHandler:^(NSDictionary *json, NSHTTPURLResponse *response, NSError *error) {
		block(response.statusCode, error);
	}];
}

@end
