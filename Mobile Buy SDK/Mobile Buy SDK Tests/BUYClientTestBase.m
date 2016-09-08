//
//  BUYClientTestBase.m
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

#import "BUYClientTestBase.h"
#import "NSArray+BUYAdditions.h"

NSString * const kBUYTestEmail = @"customer_email";
NSString * const kBUYTestPassword = @"customer_password";
NSString * const kBUYTestOrderIds = @"customer_order_ids";
NSString * const kBUYTestGiftCardCode11 = @"gift_card_code_11";
NSString * const kBUYTestGiftCardCode25 = @"gift_card_code_25";
NSString * const kBUYTestGiftCardCode50 = @"gift_card_code_50";
NSString * const kBUYTestInvalidGiftCardCode = @"invalid_gift_card_code";
NSString * const kBUYTestExpiredGiftCardCode = @"expired_gift_card_code";
NSString * const kBUYTestExpiredGiftCardID = @"expired_gift_card_id";
NSString * const kBUYTestDiscountCodeValid = @"discount_valid";
NSString * const kBUYTestDiscountCodeExpired = @"discount_expired";
NSString * const kBUYTestProductIdsCommaSeparated = @"product_ids_comma_separated";
NSString * const kBUYTestCollectionIds = @"collection_ids";

NSString * const BUYShopDomain_Placeholder = @"test_shop";
NSString * const BUYAPIKey_Placeholder = @"api_key";
NSString * const BUYAppId_Placeholder = @"app_id";

static NSString *BUYDomainName = @"SHOP_DOMAIN";
static NSString *BUYAPIKeyName = @"API_KEY";
static NSString *BUYAppIDName = @"APP_ID";
static NSString *BUYMerchantIDName = @"MERCHANT_ID";

@interface BUYClientTestBase ()
@property (nonatomic, readwrite) BOOL shouldUseMocks;
@property (nonatomic, readwrite) NSDictionary *shopConfiguration;
@end

@implementation BUYClientTestBase

- (NSString *)apiKeyFromEnvironment
{
	return [[NSProcessInfo processInfo] environment][BUYAPIKeyName];
}

- (NSDictionary *)shopConfiguration
{
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *jsonPath = [bundle pathForResource:@"test_shop_data" ofType:@"json"];
	NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
	
	return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

- (void)setUp
{
	[super setUp];
	[self setupClient];
}

- (void)setupClient
{
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];

	NSDictionary *configuration = self.shopConfiguration;
	
	self.customerEmail = configuration[@"customer_email"];
	self.customerPassword = configuration[@"customer_password"];

	self.shopDomain = environment[BUYDomainName];

	if (self.shopDomain.length > 0) {
		
		self.apiKey = environment[BUYAPIKeyName];
		self.appId = environment[BUYAppIDName];
		self.merchantId = environment[BUYMerchantIDName];

		NSAssert(self.apiKey.length > 0, @"Missing API Key");
		NSAssert(self.appId.length > 0, @"Missing App ID");
		NSAssert(self.merchantId.length > 0, @"Missing Merchant ID");
	}
	else {

		NSLog(@"***** Using Mock Tests *****");
		self.shouldUseMocks = YES;
		
		self.shopDomain = BUYShopDomain_Placeholder;
		self.apiKey = BUYAPIKey_Placeholder;
		self.appId = BUYAppId_Placeholder;
		
		self.giftCardCode = @"rd11";
		self.giftCardCode2 = @"rd25";
		self.giftCardCode3 = @"rd50";
		self.giftCardCodeExpired = @"gibberish";
	}
	
	self.customerOrderIDs = configuration[kBUYTestOrderIds];
	
	NSDictionary *giftCards = configuration[@"gift_cards"];
	
	self.giftCardCode = giftCards[@"valid11"][@"code"];
	self.giftCardCode2 = giftCards[@"valid25"][@"code"];
	self.giftCardCode3 = giftCards[@"valid50"][@"code"];
	self.giftCardCodeExpired = giftCards[@"expired"][@"code"];
	
	self.giftCardCodeInvalid = giftCards[@"invalid"][@"code"];
	self.giftCardIdExpired = giftCards[@"expired"][@"id"];
	self.discountCodeValid = configuration[@"discounts"][@"valid"][@"code"];
	self.discountCodeExpired = configuration[@"discounts"][@"expired"][@"code"];
	
	self.productIds = configuration[@"product_ids"];
	self.collectionIds = configuration[@"collection_ids"];

	self.client = [[BUYClient alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey appId:self.appId];
}

@end
