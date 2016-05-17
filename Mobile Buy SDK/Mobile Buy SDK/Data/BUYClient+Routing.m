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

#pragma mark - NSURL (Private Routing) -

@interface NSURL (PrivateRouting)

@end

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

- (NSURL *)routeForShopDomain
{
	return [NSURL URLWithFormat:@"https://%@", self.shopDomain];
}

- (NSURL *)routeForAPI
{
	return [[self routeForShopDomain] appendPath:@"/api"];
}

- (NSURL *)routeForApps
{
	return [[self routeForAPI] appendFormat:@"/apps/%@", self.appId];
}

#pragma mark - Storefront -

- (NSURL *)routeForShop
{
	return [[[self routeForShopDomain] appendPath:@"/meta"] appendExtension];
}

- (NSURL *)routeForProductListingsWithParameters:(NSDictionary *)parameters
{
	return [[[[self routeForApps] appendPath:@"/product_listings"] appendExtension] appendParameters:parameters];
}

- (NSURL *)routeForCollectionListingsWithParameters:(NSDictionary *)parameters
{
	return [[[[self routeForApps] appendPath:@"/collection_listings"] appendExtension] appendParameters:parameters];
}

#pragma mark - Checkout -

- (NSURL *)routeForCheckouts
{
	return [[[self routeForAPI] appendPath:@"/checkouts"] appendExtension];
}

- (NSURL *)routeForCheckoutsWithToken:(NSString *)token
{
	return [self _routeForCheckoutsAction:@"" withToken:token];
}

- (NSURL *)routeForCheckoutsProcessingWithToken:(NSString *)token
{
	return [self _routeForCheckoutsAction:@"/processing" withToken:token];
}

- (NSURL *)routeForCheckoutsCompletionWithToken:(NSString *)token
{
	return [self _routeForCheckoutsAction:@"/complete" withToken:token];
}

- (NSURL *)routeForCheckoutsShippingRatesWithToken:(NSString *)token parameters:(NSDictionary *)parameters
{
	return [[self _routeForCheckoutsAction:@"/shipping_rates" withToken:token] appendParameters:parameters];
}

- (NSURL *)routeForCheckoutsUsingGiftCard
{
	return [[[self routeForCheckouts] appendPath:@"/gift_cards"] appendExtension];
}

- (NSURL *)routeForCheckoutsUsingGiftCardWithToken:(NSString *)token
{
	return [[[[self routeForCheckouts] appendPath:token] appendPath:@"/gift_cards"] appendExtension];
}

- (NSURL *)routeForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token
{
	return [[[self routeForCheckoutsUsingGiftCardWithToken:token] appendIdentifier:giftCardID] appendExtension];
}

#pragma mark - Customers -

- (NSURL *)routeForCustomers
{
	return [[[self routeForAPI] appendPath:@"/customers"] appendExtension];
}

- (NSURL *)routeForCustomersOrders
{
	return [[[self routeForCustomers] appendPath:@"/orders"] appendExtension];
}

- (NSURL *)routeForCustomersWithID:(NSString *)identifier
{
	return [[[self routeForCustomers] appendPath:identifier] appendExtension];
}

- (NSURL *)routeForCustomersActivationWithID:(NSString *)identifier parameters:(NSDictionary *)parameters
{
	return [[[[self routeForCustomersWithID:identifier] appendPath:@"/activate"] appendParameters:parameters] appendExtension];
}

- (NSURL *)routeForCustomersToken
{
	return [[[self routeForCustomers] appendPath:@"/customer_token"] appendExtension];
}

- (NSURL *)routeForCustomersTokenRenewalWithID:(NSString *)customerID
{
	return [[[self routeForCustomersWithID:customerID] appendPath:@"/customer_token/renew"] appendExtension];
}

- (NSURL *)routeForCustomersPasswordRecovery
{
	return [[[self routeForCustomers] appendPath:@"/recover"] appendExtension];
}

- (NSURL *)routeForCustomersPasswordResetWithID:(NSString *)identifier parameters:(NSDictionary *)parameters
{
	return [[[[self routeForCustomersWithID:identifier] appendPath:@"/reset"] appendExtension] appendParameters:parameters];
}

#pragma mark - Utilities -

- (NSURL *)_routeForCheckoutsAction:(NSString *)action withToken:(NSString *)token
{
	return [[[[self routeForCheckouts] appendPath:token] appendPath:action] appendExtension];
}

@end
