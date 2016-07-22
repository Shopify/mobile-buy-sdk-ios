//
//  BUYClient+Routing.m
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

#import "BUYClient+Routing.h"
#import "BUYCustomerToken.h"

#pragma mark - NSURL (Private Routing) -

@implementation NSURL (PrivateRouting)

+ (instancetype)URLWithFormat:(NSString *)format, ...
{
	va_list list;
	va_start(list, format);
	NSString *URLString = [[NSString alloc] initWithFormat:format arguments:list];
	va_end(list);
	
	return [[NSURL alloc] initWithString:URLString];
}

- (NSURL *)appendFormat:(NSString *)format, ...
{
	va_list list;
	va_start(list, format);
	NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:list];
	va_end(list);
	
	NSURL *trimmedURL = [self removeExtension];
	if (formattedString.length > 0) {
		return [trimmedURL URLByAppendingPathComponent:formattedString];
	}
	return trimmedURL;
}

- (NSURL *)appendPath:(NSString *)path
{
	return [self appendFormat:path];
}

- (NSURL *)appendIdentifier:(NSNumber *)identifier
{
	return [self appendFormat:@"%@", identifier];
}

- (NSURL *)appendParameters:(NSDictionary *)parameters
{
	NSURLComponents *components = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:NO];
	NSMutableArray *queryItems  = [NSMutableArray new];
	[parameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
		[queryItems addObject:[NSURLQueryItem queryItemWithName:key value:[NSString stringWithFormat:@"%@", value]]];
	}];
	
	[components setQueryItems:queryItems];
	return components.URL;
}

- (NSURL *)appendExtension {
	return [self URLByAppendingPathExtension:@"json"];
}

- (NSURL *)removeExtension {
	return [self URLByDeletingPathExtension];
}

@end

#pragma mark - BUYClient (Routing) -

@implementation BUYClient (Routing)

#pragma mark - API -

- (NSURL *)urlForShopDomain
{
	return [NSURL URLWithFormat:@"https://%@", self.shopDomain];
}

- (NSURL *)urlForAPI
{
	return [[self urlForShopDomain] appendPath:@"/api"];
}

- (NSURL *)urlForApps
{
	return [[self urlForAPI] appendFormat:@"/apps/%@", self.appId];
}

#pragma mark - Storefront -

- (NSURL *)urlForShop
{
	return [[[self urlForShopDomain] appendPath:@"/meta"] appendExtension];
}

- (NSURL *)urlForProductListingsWithParameters:(NSDictionary *)parameters
{
	return [[[[self urlForApps] appendPath:@"/product_listings"] appendExtension] appendParameters:parameters];
}

- (NSURL *)urlForCollectionListingsWithParameters:(NSDictionary *)parameters
{
	return [[[[self urlForApps] appendPath:@"/collection_listings"] appendExtension] appendParameters:parameters];
}

- (NSURL *)urlForProductTagsWithParameters:(NSDictionary *)parameters
{
	return [[[[self urlForApps] appendPath:@"/product_listings/tags"] appendExtension] appendParameters:parameters];;
}

#pragma mark - Checkout -

- (NSURL *)urlForCheckouts
{
	return [[[self urlForAPI] appendPath:@"/checkouts"] appendExtension];
}

- (NSURL *)urlForCheckoutsWithToken:(NSString *)token
{
	return [self _urlForCheckoutsAction:@"" withToken:token];
}

- (NSURL *)urlForCheckoutsProcessingWithToken:(NSString *)token
{
	return [self _urlForCheckoutsAction:@"/processing" withToken:token];
}

- (NSURL *)urlForCheckoutsCompletionWithToken:(NSString *)token
{
	return [self _urlForCheckoutsAction:@"/complete" withToken:token];
}

- (NSURL *)urlForCheckoutsShippingRatesWithToken:(NSString *)token parameters:(NSDictionary *)parameters
{
	return [[self _urlForCheckoutsAction:@"/shipping_rates" withToken:token] appendParameters:parameters];
}

- (NSURL *)urlForCheckoutsUsingGiftCard
{
	return [[[self urlForCheckouts] appendPath:@"/gift_cards"] appendExtension];
}

- (NSURL *)urlForCheckoutsUsingGiftCardWithToken:(NSString *)token
{
	return [[[[self urlForCheckouts] appendPath:token] appendPath:@"/gift_cards"] appendExtension];
}

- (NSURL *)urlForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token
{
	return [[[self urlForCheckoutsUsingGiftCardWithToken:token] appendIdentifier:giftCardID] appendExtension];
}

#pragma mark - Customers -

- (NSURL *)urlForCustomers
{
	return [[[self urlForAPI] appendPath:@"/customers"] appendExtension];
}

- (NSURL *)urlForCustomersToken
{
	return [[[self urlForCustomers] appendPath:@"/customer_token"] appendExtension];
}

- (NSURL *)urlForCustomersPasswordRecovery
{
	return [[[self urlForCustomers] appendPath:@"/recover"] appendExtension];
}

- (NSURL *)urlForLoggedInCustomer
{
	return [self urlForCustomersWithID:[self.customerToken.customerID stringValue]];
}

- (NSURL *)urlForLoggedInCustomerToken
{
	return [[[self urlForLoggedInCustomer] appendPath:@"/customer_token"] appendExtension];
}

#pragma mark - Customer With ID -

- (NSURL *)urlForCustomersWithID:(NSString *)identifier
{
	return [[[self urlForCustomers] appendPath:identifier] appendExtension];
}

- (NSURL *)urlForCustomersOrders
{
	return [[[self urlForLoggedInCustomer] appendPath:@"/orders"] appendExtension];
}

- (NSURL *)urlForCustomersOrdersWithOrderID:(NSNumber *)orderID
{
	return [[[self urlForCustomersOrders] appendIdentifier:orderID] appendExtension];
}

- (NSURL *)urlForCustomersActivationWithID:(NSString *)identifier parameters:(NSDictionary *)parameters
{
	return [[[[self urlForCustomersWithID:identifier] appendPath:@"/activate"] appendParameters:parameters] appendExtension];
}

- (NSURL *)urlForCustomersTokenRenewal
{
	return [[[self urlForLoggedInCustomer] appendPath:@"/customer_token/renew"] appendExtension];
}

- (NSURL *)urlForCustomersPasswordResetWithID:(NSString *)identifier parameters:(NSDictionary *)parameters
{
	return [[[[self urlForCustomersWithID:identifier] appendPath:@"/reset"] appendExtension] appendParameters:parameters];
}

#pragma mark - Customer Addresses -

- (NSURL *)urlForCustomersAddresses
{
	return [[[self urlForLoggedInCustomer] appendPath:@"/addresses"] appendExtension];
}

- (NSURL *)urlForCustomersAddressWithAddressID:(NSNumber *)addressID
{
	return [[[[self urlForLoggedInCustomer] appendPath:@"/addresses"] appendIdentifier:addressID] appendExtension];
}

#pragma mark - Utilities -

- (NSURL *)_urlForCheckoutsAction:(NSString *)action withToken:(NSString *)token
{
	return [[[[self urlForCheckouts] appendPath:token] appendPath:action] appendExtension];
}

@end
