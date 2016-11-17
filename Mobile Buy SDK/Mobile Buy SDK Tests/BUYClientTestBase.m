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
#import "NSDictionary+BUYAdditions.h"

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
NSString * const kBUYTestTags = @"tags";

NSString * const BUYShopDomain_Placeholder = @"test_shop";
NSString * const BUYAPIKey_Placeholder = @"api_key";
NSString * const BUYAppId_Placeholder = @"app_id";

static NSString *BUYDomainName = @"domain";
static NSString *BUYAPIKeyName = @"api_key";
static NSString *BUYAppIDName = @"app_id";
static NSString *BUYMerchantIDName = @"merchant_id";

@interface BUYClientTestBase ()
@property (nonatomic, readwrite) BOOL shouldUseMocks;

+ (NSDictionary *)testShopConfig;
@end

@implementation BUYClientTestBase

+ (NSDictionary *)JSONFromFile:(NSString *)fileName
{
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *jsonPath = [bundle pathForResource:fileName ofType:@"json"];
	NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
	
	return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

+ (NSDictionary *)configFromEnvironment
{
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];
	NSArray *configKeys = @[BUYDomainName, BUYAPIKeyName, BUYAppIDName, BUYMerchantIDName];
	NSDictionary *config = [[environment dictionaryWithValuesForKeys:configKeys] buy_removeNulls];
	return config.count == configKeys.count ? config : nil;
}

+ (NSDictionary *)testShopConfig
{
	static NSDictionary *testShopConfig;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		testShopConfig = [self configFromEnvironment] ?: [self JSONFromFile:@"test_shop_config"];
	});
	if (testShopConfig.count == 0) {
		NSLog(@"***** Using Mock Tests *****");
	}
	return testShopConfig;
}

+ (NSDictionary *)testShopData
{
	static NSDictionary *testShopData;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		testShopData = [self JSONFromFile:@"test_shop_data"];
	});
	return testShopData;
}

- (void)setUp
{
	[super setUp];
	[self setupClient];
}

- (void)setupClient
{
	NSDictionary *testShopConfig = [BUYClientTestBase testShopConfig];
	NSDictionary *testShopData = [BUYClientTestBase testShopData];

	if (testShopConfig.count > 0) {
		
		self.shopDomain = testShopConfig[BUYDomainName];
		self.apiKey = testShopConfig[BUYAPIKeyName];
		self.appId = testShopConfig[BUYAppIDName];
		self.merchantId = testShopConfig[BUYMerchantIDName];

		NSAssert(self.apiKey.length > 0, @"Missing API Key");
		NSAssert(self.appId.length > 0, @"Missing App ID");
		NSAssert(self.merchantId.length > 0, @"Missing Merchant ID");
	}
	else {
		self.shouldUseMocks = YES;
		
		self.shopDomain = BUYShopDomain_Placeholder;
		self.apiKey = BUYAPIKey_Placeholder;
		self.appId = BUYAppId_Placeholder;
		
		self.giftCardCode = @"rd11";
		self.giftCardCode2 = @"rd25";
		self.giftCardCode3 = @"rd50";
		self.giftCardCodeExpired = @"gibberish";
	}
	
	self.customerEmail = testShopData[@"customer_email"];
	self.customerPassword = testShopData[@"customer_password"];
	self.customerOrderIDs = testShopData[kBUYTestOrderIds];
	
	NSDictionary *giftCards = testShopData[@"gift_cards"];
	
	self.giftCardCode = giftCards[@"valid11"][@"code"];
	self.giftCardCode2 = giftCards[@"valid25"][@"code"];
	self.giftCardCode3 = giftCards[@"valid50"][@"code"];
	self.giftCardCodeExpired = giftCards[@"expired"][@"code"];
	
	self.giftCardCodeInvalid = giftCards[@"invalid"][@"code"];
	self.giftCardIdExpired = giftCards[@"expired"][@"id"];
	
	self.discountCodeValid = testShopData[@"discounts"][@"valid"][@"code"];
	self.discountCodeExpired = testShopData[@"discounts"][@"expired"][@"code"];
	
	self.productIds = testShopData[@"product_ids"];
	self.collectionIds = testShopData[@"collection_ids"];
	
	self.tags = testShopData[kBUYTestTags];

	self.client = [[BUYClient alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey appId:self.appId];
}

@end
