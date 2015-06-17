//
//  BUYDataProvider.m
//  Mobile Buy SDK
//
//  Created by Shopify on 2014-09-17.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import "BUYAddress.h"
#import "BUYCart.h"
#import "BUYCheckout.h"
#import "BUYCreditCard.h"
#import "BUYClient.h"
#import "BUYGiftCard.h"
#import "BUYProduct.h"
#import "BUYShippingRate.h"
#import "BUYShop.h"

#define kGET @"GET"
#define kPOST @"POST"
#define kPATCH @"PATCH"
#define kDELETE @"DELETE"

#define kJSONType @"application/json"
#define kShopifyError @"shopify"
#define kMinSuccessfulStatusCode 200
#define kMaxSuccessfulStatusCode 299

@interface BUYClient () <NSURLSessionDelegate>

@property (nonatomic, strong) NSString *shopDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *merchantId;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation BUYClient

- (instancetype)initWithShopDomain:(NSString *)shopDomain apiKey:(NSString *)apiKey channelId:(NSString *)channelId
{
	if (shopDomain.length == 0) {
		NSException *exception = [NSException exceptionWithName:@"Bad shop domain" reason:@"Please ensure you initialize with a shop domain" userInfo:nil];
		@throw exception;
	}
	
	self = [super init];
	if (self) {
		self.shopDomain = shopDomain;
		self.apiKey = apiKey;
		self.channelId = channelId;
		self.applicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"] ?: @"";
		self.queue = [[NSOperationQueue alloc] init];
		
		NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
		NSString *versionString = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
		
		config.HTTPAdditionalHeaders = @{@"X-Shopify-Mobile-Buy-SDK-Version": [NSString stringWithFormat:@"iOS/%@", versionString]};
		
		self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:self.queue];
		self.pageSize = 25;
	}
	return self;
}

- (void)enableApplePayWithMerchantId:(NSString *)merchantId
{
	self.merchantId = merchantId;
}

- (BOOL)testIntegration
{
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	__block BOOL success = NO;
	
	NSString *urlString = [NSString stringWithFormat:@"http://%@/mobile_app/verify?api_key=%@&channel_id=%@", self.shopDomain, self.apiKey, self.channelId];
	
	if (self.merchantId.length > 0) {
		urlString = [urlString stringByAppendingFormat:@"&merchant_id=%@", self.merchantId];
	}
	
	[self performRequestForURL:urlString completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		success = ((NSHTTPURLResponse *)response).statusCode == 200;
		dispatch_semaphore_signal(semaphore);
	}];
	
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

	return success;
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
	return [self performRequestForURL:[NSString stringWithFormat:@"http://%@/meta.json", _shopDomain] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		BUYShop *shop = nil;
		if (json && error == nil) {
			shop = [[BUYShop alloc] initWithDictionary:json];
		}
		block(shop, error);
	}];
}

- (NSURLSessionDataTask *)getProductsPage:(NSUInteger)page completion:(BUYDataProductListBlock)block
{
	NSString *url = [NSString stringWithFormat:@"https://%@/api/channels/%@/product_publications.json?limit=%lu&page=%lu", self.shopDomain, self.channelId,  (unsigned long)self.pageSize, (unsigned long)page];
	
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		
		NSArray *products = nil;
		if (json && error == nil) {
			products = [BUYProduct convertJSONArray:json[@"product_publications"]];
		}
		block(products, page, [self hasReachedEndOfPage:products] || error, error);
	}];
}

- (NSURLSessionDataTask *)getProductById:(NSString *)productId completion:(BUYDataProductBlock)block;
{
	NSString *url = [NSString stringWithFormat:@"https://%@/api/channels/%@/product_publications.json?product_ids=%@", self.shopDomain, self.channelId, productId];
	return [self getRequestForURL:url completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {

		BUYProduct *product = nil;

		if (json && error == nil) {
			NSArray *products = [BUYProduct convertJSONArray:json[@"product_publications"]];
			product = [products firstObject];
		}
		block(product, error);
	}];
}

#pragma mark - Helpers

- (NSURLSessionDataTask *)performRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSURLSessionDataTask *task = [self.session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSDictionary *json = nil;
		if (error == nil) {
			id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
			json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
			error = [self extractErrorFromResponse:response json:json];
		}
		completionHandler(json, response, error);
	}];
	[task resume];
	return task;
}

- (NSError *)extractErrorFromResponse:(NSURLResponse *)response json:(NSDictionary *)json
{
	NSError *error = nil;
	NSInteger statusCode = [((NSHTTPURLResponse *) response) statusCode];
	if (statusCode < kMinSuccessfulStatusCode || statusCode > kMaxSuccessfulStatusCode) {
		error = [NSError errorWithDomain:NSURLErrorDomain code:statusCode userInfo:json];
	}
	return error;
}

#pragma mark - Checkout

- (void)handleCheckoutResponse:(NSDictionary *)json error:(NSError *)error block:(BUYDataCheckoutBlock)block
{
	BUYCheckout *checkout = nil;
	if (error == nil) {
		checkout = [[BUYCheckout alloc] initWithDictionary:json[@"checkout"]];
	}
	block(checkout, error);
}

- (NSDictionary *)marketingAttributions
{
	return @{@"platform": @"iOS", @"application_name": self.applicationName};
}

- (NSURLSessionDataTask *)createCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	checkout.channelId = self.channelId;
	checkout.marketingAttribution = self.marketingAttributions;
	
	return [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain] object:checkout completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)createCheckoutWithCartToken:(NSString *)cartToken completion:(BUYDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if (cartToken) {
		NSDictionary *body = @{ @"checkout" : @{ @"cart_token" : cartToken, @"channel_id": self.channelId, @"marketing_attribution": self.marketingAttributions} };
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
		
		if (data && error == nil) {
			task = [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts.json", _shopDomain] body:data completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
				[self handleCheckoutResponse:json error:error block:block];
			}];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)applyGiftCardWithCode:(NSString *)giftCardCode toCheckout:(BUYCheckout *)checkout completion:(BUYDataGiftCardBlock)block
{
	NSURLSessionDataTask *task = nil;
	if (checkout.hasToken && giftCardCode) {
		BUYGiftCard *giftCard = [[BUYGiftCard alloc] initWithDictionary:@{ @"code" : giftCardCode }];
		task = [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/gift_cards.json", _shopDomain, checkout.token] object:giftCard completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			BUYGiftCard *giftCard = nil;
			if (error == nil) {
				giftCard = [[BUYGiftCard alloc] initWithDictionary:json[@"gift_card"]];
			}
			block(giftCard, error);
		}];
	}
	
	return task;
}

- (NSURLSessionDataTask *)removeGiftCard:(BUYGiftCard *)giftCard fromCheckout:(BUYCheckout *)checkout completion:(BUYDataGiftCardBlock)block
{
	NSURLSessionDataTask *task = nil;
	if (giftCard.identifier) {
		task = [self deleteRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/gift_cards/%@.json", _shopDomain, checkout.token, giftCard.identifier] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			BUYGiftCard *giftCard = nil;
			if (error == nil) {
				giftCard = [[BUYGiftCard alloc] initWithDictionary:json[@"gift_card"]];
			}
			block(giftCard, error);
		}];
	}
	
	return task;
}

- (NSURLSessionDataTask *)getCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	return [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@.json", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)updateCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self patchRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@.json", _shopDomain, checkout.token] object:checkout completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			[self handleCheckoutResponse:json error:error block:block];
		}];
	}
	return task;
}

- (NSURLSessionDataTask*)completeCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken] && [checkout.paymentSessionId length] > 0) {
		NSDictionary *paymentJson = @{ @"payment_session_id" : checkout.paymentSessionId };
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:paymentJson options:0 error:&error];
		if (data && error == nil) {
			task = [self checkoutCompletionRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)completeCheckout:(BUYCheckout *)checkout withApplePayToken:(PKPaymentToken *)token completion:(BUYDataCheckoutBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken] && token) {
		NSString *tokenString = [[NSString alloc] initWithData:token.paymentData encoding:NSUTF8StringEncoding];
		NSDictionary *paymentJson = @{ @"payment_token" : @{ @"payment_data" : tokenString, @"type" : @"apple_pay" }};
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:paymentJson options:0 error:&error];
		if (data && error == nil) {
			task = [self checkoutCompletionRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

- (NSURLSessionDataTask *)checkoutCompletionRequestWithCheckout:(BUYCheckout *)checkout body:(NSData *)body completion:(BUYDataCheckoutBlock)block
{
	return [self postRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/complete.json", _shopDomain, checkout.token] body:body completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		[self handleCheckoutResponse:json error:error block:block];
	}];
}

- (NSURLSessionDataTask *)getCompletionStatusOfCheckout:(BUYCheckout *)checkout completion:(BUYDataCheckoutStatusBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/processing.json", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
			block(checkout, [BUYClient statusForStatusCode:statusCode error:error], error);
		}];
	}
	return task;
}

#pragma mark - Shipping Rates

- (NSURLSessionDataTask *)getShippingRatesForCheckout:(BUYCheckout *)checkout completion:(BUYDataShippingRatesBlock)block
{
	NSURLSessionDataTask *task = nil;
	if ([checkout hasToken]) {
		task = [self getRequestForURL:[NSString stringWithFormat:@"https://%@/anywhere/checkouts/%@/shipping_rates.json?checkout[partial_addresses]=true", _shopDomain, checkout.token] completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
			NSArray *shippingRates = nil;
			if (error == nil && json) {
				shippingRates = [BUYShippingRate convertJSONArray:json[@"shipping_rates"]];
			}
			
			NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
			block(shippingRates, [BUYClient statusForStatusCode:statusCode error:error], error);
		}];
	}
	return task;
}

#pragma mark - Payments

- (NSURLSessionDataTask *)storeCreditCard:(id <BUYSerializable>)creditCard checkout:(BUYCheckout *)checkout completion:(BUYDataCreditCardBlock)block
{
	NSURLSessionDataTask *task = nil;
	if (checkout.token && creditCard) {
		NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
		json[@"token"] = checkout.token;
		json[@"credit_card"] = [creditCard jsonDictionaryForCheckout];
		if (checkout.billingAddress) {
			json[@"billing_address"] = [checkout.billingAddress jsonDictionaryForCheckout];
		}
		
		NSError *error = nil;
		NSData *data = [NSJSONSerialization dataWithJSONObject:@{ @"checkout" : json } options:0 error:&error];
		if (data && error == nil) {
			task = [self postPaymentRequestWithCheckout:checkout body:data completion:block];
		}
	}
	return task;
}

#pragma mark - Helpers

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

- (NSError *)errorFromJSON:(NSDictionary *)errorDictionary statusCode:(NSInteger)statusCode
{
	return [[NSError alloc] initWithDomain:kShopifyError code:statusCode userInfo:errorDictionary];
}

- (NSURLSessionDataTask *)requestForURL:(NSString *)url method:(NSString *)method object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSDictionary *json = [object jsonDictionaryForCheckout];
	NSError *error = nil;
	NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&error];
	NSURLSessionDataTask *task = nil;
	if (error == nil && data) {
		task = [self requestForURL:url method:method body:data completionHandler:completionHandler];
	}
	return task;
}

- (void)startTask:(NSURLSessionDataTask *)task
{
	[task resume];
}

- (NSURLSessionDataTask *)requestForURL:(NSString *)url method:(NSString *)method body:(NSData *)body completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	request.HTTPBody = body;
	
	[request addValue:[self authorizationHeader] forHTTPHeaderField:@"Authorization"];
	[request addValue:kJSONType forHTTPHeaderField:@"Content-Type"];
	[request addValue:kJSONType forHTTPHeaderField:@"Accept"];
	
	request.HTTPMethod = method;
	NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
		NSDictionary *json = nil;
		BOOL unauthorized = statusCode == 401;
		BOOL failedValidation = statusCode == 422;
		
		if (unauthorized) {
			error = [[NSError alloc] initWithDomain:kShopifyError code:statusCode userInfo:nil];
		}
		else {
			//2 is the minimum amount of data {} for a JSON Object. Just ignore anything less.
			if ((error == nil || failedValidation) && [data length] > 2) {
				id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
				json = [jsonData isKindOfClass:[NSDictionary class]] ? jsonData : nil;
			}
			
			if (statusCode < kMinSuccessfulStatusCode || statusCode > kMaxSuccessfulStatusCode) {
				error = [self errorFromJSON:json statusCode:statusCode];
			}
		}
		completionHandler(json, response, error);
	}];
	[self startTask:task];
	return task;
}

- (NSURLSessionDataTask *)postPaymentRequestWithCheckout:(BUYCheckout *)checkout body:(NSData *)body completion:(BUYDataCreditCardBlock)block
{
	return [self requestForURL:[checkout.paymentURL absoluteString] method:kPOST body:body completionHandler:^(NSDictionary *json, NSURLResponse *response, NSError *error) {
		NSString *paymentSessionId = nil;
		if (error == nil) {
			paymentSessionId = json[@"id"];
			checkout.paymentSessionId = paymentSessionId;
		}
		block(checkout, paymentSessionId, error);
	}];
}

- (NSURLSessionDataTask *)getRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kGET body:nil completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)postRequestForURL:(NSString *)url object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPOST object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)postRequestForURL:(NSString *)url body:(NSData *)body completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPOST body:body completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)patchRequestForURL:(NSString *)url object:(id <BUYSerializable>)object completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kPATCH object:object completionHandler:completionHandler];
}

- (NSURLSessionDataTask *)deleteRequestForURL:(NSString *)url completionHandler:(void (^)(NSDictionary *json, NSURLResponse *response, NSError *error))completionHandler
{
	return [self requestForURL:url method:kDELETE body:nil completionHandler:completionHandler];
}

- (NSString *)authorizationHeader
{
	NSData *data = [_apiKey dataUsingEncoding:NSUTF8StringEncoding];
	return [NSString stringWithFormat:@"%@ %@", @"Basic", [data base64EncodedStringWithOptions:0]];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
	NSURLProtectionSpace *protectionSpace = [challenge protectionSpace];
	
	if (protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
		
		SecTrustResultType resultType;
		SecTrustEvaluate(protectionSpace.serverTrust, &resultType);
		
		BOOL trusted = (resultType == kSecTrustResultUnspecified) || (resultType == kSecTrustResultProceed);
		
#ifdef DEBUG
		trusted |= (resultType == kSecTrustResultInvalid); // TODO: CircleCI is using xctool which does not support Security.framework
#endif
		
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

@end
