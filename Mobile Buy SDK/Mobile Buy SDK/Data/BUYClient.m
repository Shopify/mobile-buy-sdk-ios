//
//  BUYDataClient.m
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

#import "BUYClient_Internal.h"

#import "BUYAssert.h"
#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCheckout.h"
#import "BUYCreditCard.h"
#import "BUYCreditCardToken.h"
#import "BUYCollection.h"
#import "BUYError.h"
#import "BUYGiftCard.h"
#import "BUYModelManager.h"
#import "BUYOrder.h"
#import "BUYProduct.h"
#import "BUYPaymentToken.h"
#import "BUYShippingRate.h"
#import "BUYShop.h"
#import "BUYShopifyErrorCodes.h"
#import "NSDecimalNumber+BUYAdditions.h"
#import "NSDictionary+BUYAdditions.h"
#import "NSURLComponents+BUYAdditions.h"
#import "BUYRouter.h"

#define kGET @"GET"
#define kPOST @"POST"
#define kPATCH @"PATCH"
#define kPUT @"PUT"
#define kDELETE @"DELETE"

#define kJSONType @"application/json"
#define kMinSuccessfulStatusCode 200
#define kMaxSuccessfulStatusCode 299

#define BUYAssertCheckout(checkout) BUYAssert([(checkout) hasToken], @"Checkout assertion failed. Checkout must have a valid token associated with it.")

NSString * const BUYVersionString = @"1.3";

NSString *const kShopifyError = @"shopify";

static NSString *const kBUYClientPathProductPublications = @"product_listings";
static NSString *const kBUYClientPathCollectionPublications = @"collection_listings";

NSString *const BUYClientCustomerAccessToken = @"X-Shopify-Customer-Access-Token";

@interface BUYClient () <NSURLSessionDelegate>

@property (nonatomic, strong) NSString *shopDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appId;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) BUYRouter *router;

@end

@implementation BUYClient

#pragma mark - Init

- (instancetype)init {
	BUYAssert(NO, @"BUYClient must be initialized using the designated initializer.");
	return nil;
}

- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey appId:(NSString *)appId
{
	BUYAssert(shopDomain.length > 0, @"Bad shop domain. Please ensure you initialize with a shop domain.");
	BUYAssert(apiKey.length > 0,     @"Bad API key. Please ensure you initialize with a valid API key.");
	BUYAssert(appId.length > 0,      @"Bad app ID. Please ensure you initialize with a valid App ID.");
	
	self = [super init];
	if (self) {
		self.router = [[BUYRouter alloc] initWithShopDomain:shopDomain appID:appId];
		self.modelManager = [BUYModelManager modelManager];
		self.shopDomain = shopDomain;
		self.apiKey = apiKey;
		self.appId = appId;
		self.applicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"] ?: @"";
		self.queue = dispatch_get_main_queue();
		self.session = [self urlSession];
		self.pageSize = 25;
	}
	return self;
}

- (NSURLSession *)urlSession
{
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	
	NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
	
	config.HTTPAdditionalHeaders = @{@"User-Agent": [NSString stringWithFormat:@"Mobile Buy SDK iOS/%@/%@", BUYVersionString, bundleIdentifier]};
	
	return [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
}

#pragma mark - Storefront

- (void)setPageSize:(NSUInteger)pageSize
{
	_pageSize = MAX(MIN(pageSize, 250), 1);
}

- (BOOL)hasReachedEndOfPage:(NSArray *)lastFetchedObjects
{
	return [lastFetchedObjects count] < self.pageSize;
}

- (NSURLSessionDataTask *)getShop:(BUYDataShopBlock)block
{
	return [self getRequestForURL:[self.router routeForShop].URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		BUYShop *shop = nil;
		if (json && !error) {
			shop = [self.modelManager insertShopWithJSONDictionary:json];
		}
		block(shop, error);
	}];
}

- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block
{
	BUYRoute *route  = [self.router routeForProductListings];
	route.queryItems = @{
						 @"limit" : @(self.pageSize),
						 @"page"  : @(page),
						 };
	
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager insertProductsWithJSONArray:json[kBUYClientPathProductPublications]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

- (NSURLSessionDataTask *)getProductById:(NSString *)productId completion:(BUYDataProductBlock)block;
{
	BUYAssert(productId, @"Failed to get product by ID. Product ID must not be nil.");
	
	return [self getProductsByIds:@[productId] completion:^(NSArray *products, NSError *error) {
		if (products.count > 0) {
			block(products[0], error);
		} else {
			if (!error) {
				error = [NSError errorWithDomain:kShopifyError code:BUYShopifyError_InvalidProductID userInfo:@{ NSLocalizedDescriptionKey : @"Product ID is not valid. Confirm the product ID on your shop's admin and also ensure that the visibility is on for the Mobile App channel." }];
			}
			block(nil, error);
		}
	}];
}

- (NSURLSessionDataTask *)getProductsByIds:(NSArray *)productIds completion:(BUYDataProductsBlock)block
{
	BUYAssert(productIds, @"Failed to get product by IDs. Product IDs array must not be nil.");
	
	BUYRoute *route  = [self.router routeForProductListings];
	route.queryItems = @{
						 @"product_ids" : [productIds componentsJoinedByString:@","],
						 };
	
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager insertProductsWithJSONArray:json[kBUYClientPathProductPublications]];
		}
		if (!error && products.count == 0) {
			error = [NSError errorWithDomain:kShopifyError code:BUYShopifyError_InvalidProductID userInfo:@{ NSLocalizedDescriptionKey : @"Product IDs are not valid. Confirm the product IDs on your shop's admin and also ensure that the visibility is on for the Mobile App channel." }];
		}
		block(products, error);
	}];
}

- (NSURLSessionDataTask *)getCollections:(BUYDataCollectionsBlock)block
{
	return [self getCollectionsPage:1 completion:^(NSArray<BUYCollection *> *collections, NSUInteger page, BOOL reachedEnd, NSError *error) {
		block(collections, error);
	}];
}

- (NSURLSessionDataTask *)getCollectionsPage:(NSUInteger)page completion:(BUYDataCollectionsListBlock)block
{
	BUYRoute *route  = [self.router routeForCollectionListings];
	route.queryItems = @{
						 @"limit" : @(self.pageSize),
						 @"page"  : @(page),
						 };
	
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *collections = nil;
		if (json && !error) {
			collections = [self.modelManager buy_objectsWithEntityName:[BUYCollection entityName] JSONArray:json[kBUYClientPathCollectionPublications]];
		}
		block(collections, page, [self hasReachedEndOfPage:collections], error);
	}];
}

- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId completion:(BUYDataProductListBlock)block
{
	return [self getProductsPage:page inCollection:collectionId sortOrder:BUYCollectionSortCollectionDefault completion:block];
}

- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page inCollection:(NSNumber *)collectionId sortOrder:(BUYCollectionSort)sortOrder completion:(BUYDataProductListBlock)block
{
	BUYAssert(collectionId, @"Failed to get products page. Invalid collectionID.");
	
	BUYRoute *route  = [self.router routeForProductListings];
	route.queryItems = @{
						 @"collection_id" : collectionId,
						 @"limit"         : @(self.pageSize),
						 @"page"          : @(page),
						 @"sort_by"       : [BUYCollection sortOrderParameterForCollectionSort:sortOrder]
						 };
	
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && !error) {
			products = [self.modelManager buy_objectsWithEntityName:[BUYProduct entityName] JSONArray:json[kBUYClientPathProductPublications]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

#pragma mark - Checkout

- (void)handleCheckoutResponse:(NSDictionary *)json error:(NSError *)error block:(BUYDataCheckoutBlock)block
{
	BUYCheckout *checkout = nil;
	if (!error) {
		checkout = [self.modelManager insertCheckoutWithJSONDictionary:json[@"checkout"]];
	}
	block(checkout, error);
}

- (void)configureCheckout:(BUYCheckout *)checkout
{
	checkout.marketingAttribution = @{@"medium": @"iOS", @"source": self.applicationName};
	checkout.sourceName = @"mobile_app";
	if (self.urlScheme || checkout.webReturnToURL) {
		checkout.webReturnToURL = checkout.webReturnToURL ?: [NSURL URLWithString:self.urlScheme];
		checkout.webReturnToLabel = checkout.webReturnToLabel ?: [@"Return to " stringByAppendingString:self.applicationName];
	}
}

- (NSURLSessionDataTask *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(checkout, @"Failed to create checkout. Invalid checkout object.");
	
	// Inject channel and marketing attributions
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (NSURLSessionDataTask *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssert(cartToken, @"Failed to create checkout. Invalid cart token");
	BUYCheckout *checkout = [self.modelManager checkoutwithCartToken:cartToken];
	[self configureCheckout:checkout];
	
	NSDictionary *json = [checkout jsonDictionaryForCheckout];
	return [self postCheckout:json completion:block];
}

- (NSURLSessionDataTask *)postCheckout:(NSDictionary *)checkoutJSON completion:(BUYDataCheckoutBlock)block
{
	return [self postRequestForURL:[self.router routeForCheckouts].URL object:checkoutJSON completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)applyGiftCardWithCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCardCode.length > 0, @"Failed to apply gift card code. Invalid gift card code.");
	
	BUYGiftCard *giftCard = [self.modelManager giftCardWithCode:giftCardCode];
	BUYRoute *route = [self.router routeForCheckoutsUsingGiftCardWithToken:checkout.token];
	
	return [self postRequestForURL:route.URL object:giftCard completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (json && !error) {
			[self updateCheckout:checkout withGiftCardDictionary:json[@"gift_card"] addingGiftCard:YES];
		}
		block(checkout, error);
	}];
}

- (NSURLSessionDataTask *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	BUYAssert(giftCard.identifier, @"Failed to remove gift card. Gift card must have a valid identifier.");
	
	BUYRoute *route = [self.router routeForCheckoutsUsingGiftCard:giftCard.identifier token:checkout.token];
	return [self deleteRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		if (!error) {
			[self updateCheckout:checkout withGiftCardDictionary:json[@"gift_card"] addingGiftCard:NO];
		}
		block(checkout, error);
	}];
}

- (void)updateCheckout:(BUYCheckout *)checkout withGiftCardDictionary:(NSDictionary *)giftCardDictionary addingGiftCard:(BOOL)addingGiftCard
{
	if (addingGiftCard) {
		BUYGiftCard *giftCard = [self.modelManager insertGiftCardWithJSONDictionary:giftCardDictionary];
		[checkout.giftCardsSet addObject:giftCard];
	} else {
		[checkout removeGiftCardWithIdentifier:giftCardDictionary[@"id"]];
	}
	
	checkout.paymentDue = [NSDecimalNumber buy_decimalNumberFromJSON:giftCardDictionary[@"checkout"][@"payment_due"]];

	// Marking the checkout as clean. The properties we have updated above we don't need to re-sync with Shopify.
	// There's also an issue with gift cards where syncing the gift card JSON won't work since the update endpoint
	// doesn't accept the gift card without a gift card code (which we do not have).
	[checkout markAsClean];
}

- (NSURLSessionDataTask *)getCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	BUYRoute *route = [self.router routeForCheckoutsWithToken:checkout.token];
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	BUYRoute *route = [self.router routeForCheckoutsWithToken:checkout.token];
	return [self patchRequestForURL:route.URL object:checkout completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask*)completeCheckout:(BUYCheckout *)checkout paymentToken:(id<BUYPaymentToken>)paymentToken completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	BOOL isFree = (checkout.paymentDue && checkout.paymentDue.floatValue == 0);
	
	BUYAssert(paymentToken || isFree, @"Failed to complete checkout. Checkout must have a payment token or have a payment value equal to $0.00");
	
	BUYRoute *route = [self.router routeForCheckoutsCompletionWithToken:checkout.token];
	return [self postRequestForURL:route.URL object:[paymentToken JSONDictionary] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutStatusBlock)block
{
	BUYAssertCheckout(checkout);
	
	return [self getCompletionStatusOfCheckoutToken:checkout.token completion:block];
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckoutURL:(NSURL *)url completion:(BUYDataCheckoutStatusBlock)block
{
	NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
	
	NSString *token = nil;
	for (NSURLQueryItem *item in components.queryItems) {
		if ([item.name isEqualToString:@"checkout[token]"]) {
			token = item.value;
			break;
		}
	}
	
	BUYAssert(token, @"Failed to get completion status of checkout. Checkout URL must have a valid token associated with it.");
	
	return [self getCompletionStatusOfCheckoutToken:token completion:block];
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckoutToken:(NSString *)token completion:(BUYDataCheckoutStatusBlock)block
{
	BUYRoute *route = [self.router routeForCheckoutsProcessingWithToken:token];
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		block([BUYClient statusForStatusCode:statusCode error:error], error);
	}];
}

#pragma mark - Shipping Rates

- (NSURLSessionDataTask *)getShippingRatesForCheckout:(BUYCheckout *)checkout completion:(BUYDataShippingRatesBlock)block
{
	BUYAssertCheckout(checkout);
	
	BUYRoute *route  = [self.router routeForCheckoutsShippingRatesWithToken:checkout.token];
	route.queryItems = @{
						 @"checkout" : @"",
						 };
	
	return [self getRequestForURL:route.URL completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSArray *shippingRates = nil;
		if (json && !error) {
			shippingRates = [self.modelManager insertShippingRatesWithJSONArray:json[@"shipping_rates"]];
		}
		
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		block(shippingRates, [BUYClient statusForStatusCode:statusCode error:error], error);
	}];
}

#pragma mark - Payments

- (NSURLSessionDataTask *)storeCreditCard:(BUYCreditCard *)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)completion
{
	BUYAssertCheckout(checkout);
	BUYAssert(creditCard, @"Failed to store credit card. No credit card provided.");
	
	NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
	json[@"token"]            = checkout.token;
	json[@"credit_card"]      = [creditCard jsonDictionaryForCheckout];
	if (checkout.billingAddress) {
		json[@"billing_address"] = [checkout.billingAddress jsonDictionaryForCheckout];
	}
	
	return [self postRequestForURL:checkout.paymentURL object:@{ @"checkout" : json } completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		id<BUYPaymentToken> token = nil;
		if (!error) {
			token = [[BUYCreditCardToken alloc] initWithPaymentSessionID:json[@"id"]];
		}
		completion(checkout, token, error);
	}];
}

- (NSURLSessionDataTask *)removeProductReservationsFromCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	BUYAssertCheckout(checkout);
	
	checkout.reservationTime = @0;
	return [self updateCheckout:checkout completion:block];
}

#pragma mark - Error

+ (BUYStatus)statusForStatusCode:(NSUInteger)statusCode error:(NSError *)error
{
	BUYStatus status = BUYStatusUnknown;
	if (statusCode == BUYStatusPreconditionFailed) {
		status = BUYStatusPreconditionFailed;
	}
	else if (statusCode == BUYStatusNotFound) {
		status = BUYStatusNotFound;
	}
	else if (error || statusCode == BUYStatusFailed) {
		status = BUYStatusFailed;
	}
	else if (statusCode == BUYStatusProcessing) {
		status = BUYStatusProcessing;
	}
	else if (statusCode == BUYStatusComplete) {
		status = BUYStatusComplete;
	}
	return status;
}

- (NSError *)errorFromJSON:(NSDictionary *)json response:(NSURLResponse *)response
{
	NSInteger statusCode = [((NSHTTPURLResponse *) response) statusCode];
	if (statusCode < kMinSuccessfulStatusCode || statusCode > kMaxSuccessfulStatusCode) {
		return [[NSError alloc] initWithDomain:kShopifyError code:statusCode userInfo:json];
	}
	return nil;
}

#pragma mark - Convenience Requests

- (NSURLSessionDataTask *)getRequestForURL:(NSURL *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kGET object:nil completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)postRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPOST object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)putRequestForURL:(NSURL *)url object:(id<BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPUT object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)patchRequestForURL:(NSURL *)url object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPATCH object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)deleteRequestForURL:(NSURL *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kDELETE object:nil completionHandler:completionHandler];
}

#pragma mark - Generic Requests

- (void)startTask:(NSURLSessionDataTask *)task
{
	[task resume];
}

- (NSString *)authorizationHeader
{
	NSData *data = [_apiKey dataUsingEncoding:NSUTF8StringEncoding];
	return [NSString stringWithFormat:@"%@ %@", @"Basic", [data base64EncodedStringWithOptions:0]];
}

- (NSURLSessionDataTask *)requestForURL:(NSURL *)url method:(NSString *)method object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
	if (object) {
		request.HTTPBody = [NSJSONSerialization dataWithJSONObject:[object jsonDictionaryForCheckout] options:0 error:nil];
	}
	
	[request addValue:[self authorizationHeader] forHTTPHeaderField:@"Authorization"];
	[request addValue:kJSONType forHTTPHeaderField:@"Content-Type"];
	[request addValue:kJSONType forHTTPHeaderField:@"Accept"];
	
	if (self.customerToken) {
		[request addValue:self.customerToken forHTTPHeaderField:BUYClientCustomerAccessToken];
	}
	
	request.HTTPMethod = method;
	NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		NSDictionary *json = nil;
		if (data.length > 2) { // 2 is the minimum amount of data {} for a JSON Object. Just ignore anything less.
			json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		}
		
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		BOOL isSuccessful    = (statusCode / 100) == 2;
		if (!isSuccessful && !error) { // Only generate error if request failed
			error = [self errorFromJSON:json response:response];
		}
		
		dispatch_async(self.queue, ^{
			completionHandler(json, response, error);
		});
	}];
	
	[self startTask:task];
	return task;
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
	NSURLProtectionSpace *protectionSpace = [challenge protectionSpace];
	
	if (protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
		
		SecTrustResultType resultType;
		SecTrustEvaluate(protectionSpace.serverTrust, &resultType);
		
		BOOL trusted = (resultType == kSecTrustResultUnspecified) || (resultType == kSecTrustResultProceed);
		
		if (trusted) {
			NSURLCredential *credential = [NSURLCredential credentialForTrust:protectionSpace.serverTrust];
			completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
		}
		else {
			completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, NULL);
		}
		
	}
	else {
		completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, NULL);
	}
}

#pragma mark - Deprecations

- (void)enableApplePayWithMerchantId:(NSString *)merchantId
{
	self.merchantId = merchantId;
}

@end
