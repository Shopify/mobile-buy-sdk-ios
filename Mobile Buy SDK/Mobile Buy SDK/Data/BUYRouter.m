//
//  BUYRouter.m
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

#import "BUYRouter.h"

#pragma mark - Route -

@interface BUYRoute ()

@property (strong, nonatomic) NSURLComponents *components;

@end

@implementation BUYRoute

+ (instancetype)routeWithFormat:(NSString *)format, ...
{
	
	va_list list;
	va_start(list, format);
	NSString *URLString = [[NSString alloc] initWithFormat:format arguments:list];
	va_end(list);
	
	return [[[self class] alloc] initWithURLString:URLString];
}

- (instancetype)initWithURLString:(NSString *)URLString
{
	self = [super init];
	if (self) {
		NSURL *url  = [NSURL URLWithString:URLString];
		_components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
	}
	return self;
}

- (void)setQueryItems:(NSDictionary *)queryItems
{
	_queryItems = queryItems;
	
	NSMutableArray *items = [NSMutableArray new];
	[queryItems enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
		[items addObject:[NSURLQueryItem queryItemWithName:key value:[NSString stringWithFormat:@"%@", value]]];
	}];
	
	[_components setQueryItems:items];
}

#pragma mark - Accessors -

- (NSURL *)URL
{
	/* ---------------------------------
	 * All API requests should end with
	 * a .json suffix.
	 */
	return [_components.URL URLByAppendingPathExtension:@"json"];
}

#pragma mark - Mutation -

- (BUYRoute *)appendFormat:(NSString *)format, ...
{
	va_list list;
	va_start(list, format);
	NSString *formattedString = [[NSString alloc] initWithFormat:format arguments:list];
	va_end(list);
	
	if (formattedString.length > 0) {
		_components.path = [_components.path stringByAppendingPathComponent:formattedString];
	}
	return self;
}

- (BUYRoute *)appendPath:(NSString *)path
{
	return [self appendFormat:path];
}

- (BUYRoute *)appendIdentifier:(NSNumber *)identifier
{
	return [self appendFormat:@"%@", identifier];
}

@end

#pragma mark - Router -

@interface BUYRouter ()

@property (strong, nonatomic) NSString *shopDomain;
@property (strong, nonatomic) NSString *appID;

@end

@implementation BUYRouter

#pragma mark - Init -

- (instancetype)initWithShopDomain:(NSString *)shopDomain appID:(NSString *)appID
{
	self = [super init];
	if (self) {
		_shopDomain = shopDomain;
		_appID      = appID;
	}
	return self;
}

#pragma mark - API -

- (BUYRoute *)routeForShopDomain
{
	return [BUYRoute routeWithFormat:@"https://%@", self.shopDomain];
}

- (BUYRoute *)routeForAPI
{
	return [[self routeForShopDomain] appendPath:@"/api"];
}

- (BUYRoute *)routeForApps
{
	return [[self routeForAPI] appendFormat:@"/apps/%@", self.appID];
}

#pragma mark - Storefront -

- (BUYRoute *)routeForShop
{
	return [[self routeForShopDomain] appendPath:@"/meta"];
}

- (BUYRoute *)routeForProductListings
{
	return [[self routeForApps] appendPath:@"/product_listings"];
}

- (BUYRoute *)routeForCollectionListings
{
	return [[self routeForApps] appendPath:@"/collection_listings"];
}

#pragma mark - Checkout -

- (BUYRoute *)routeForCheckouts
{
	return [[self routeForAPI] appendPath:@"/checkouts"];
}

- (BUYRoute *)routeForCheckoutsWithToken:(NSString *)token
{
	return [self routeForCheckoutsAction:@"" withToken:token];
}

- (BUYRoute *)routeForCheckoutsProcessingWithToken:(NSString *)token
{
	return [self routeForCheckoutsAction:@"/processing" withToken:token];
}

- (BUYRoute *)routeForCheckoutsCompletionWithToken:(NSString *)token
{
	return [self routeForCheckoutsAction:@"/complete" withToken:token];
}

- (BUYRoute *)routeForCheckoutsShippingRatesWithToken:(NSString *)token
{
	return [self routeForCheckoutsAction:@"/shipping_rates" withToken:token];
}

- (BUYRoute *)routeForCheckoutsUsingGiftCard
{
	return [[self routeForCheckouts] appendPath:@"/gift_cards"];
}

- (BUYRoute *)routeForCheckoutsUsingGiftCardWithToken:(NSString *)token
{
	return [[[self routeForCheckouts] appendPath:token] appendPath:@"/gift_cards"];
}

- (BUYRoute *)routeForCheckoutsUsingGiftCard:(NSNumber *)giftCardID token:(NSString *)token
{
	return [[self routeForCheckoutsUsingGiftCardWithToken:token] appendIdentifier:giftCardID];
}

#pragma mark - Customers -

- (BUYRoute *)routeForCustomers
{
	return [[self routeForAPI] appendPath:@"/customers"];
}

- (BUYRoute *)routeForCustomersOrders
{
	return [[self routeForCustomers] appendPath:@"/orders"];
}

- (BUYRoute *)routeForCustomersWithID:(NSString *)identifier
{
	return [[self routeForCustomers] appendPath:identifier];
}

- (BUYRoute *)routeForCustomersActivationWithID:(NSString *)identifier
{
	return [[self routeForCustomersWithID:identifier] appendPath:@"/activate"];
}

- (BUYRoute *)routeForCustomersToken
{
	return [[self routeForCustomers] appendPath:@"/customer_token"];
}

- (BUYRoute *)routeForCustomersTokenRenewalWithID:(NSString *)customerID
{
	return [[self routeForCustomersWithID:customerID] appendPath:@"/customer_token/renew"];
}

- (BUYRoute *)routeForCustomersPasswordRecovery
{
	return [[self routeForCustomers] appendPath:@"/recover"];
}

- (BUYRoute *)routeForCustomersPasswordResetWithID:(NSString *)identifier
{
	return [[self routeForCustomersWithID:identifier] appendPath:@"/reset"];
}

#pragma mark - Utilities -

- (BUYRoute *)routeForCheckoutsAction:(NSString *)action withToken:(NSString *)token
{
	return [[[self routeForCheckouts] appendPath:action] appendPath:token];
}

@end
