//
//  BUYClientTestBase.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-09-15.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "BUYClientTestBase.h"
#import "BUYTestConstants.h"

NSString * const BUYShopDomain_Placeholder = @"test_shop";
NSString * const BUYAPIKey_Placeholder = @"channel_id";
NSString * const BUYChannelId_Placeholder = @"api_key";

@implementation BUYClientTestBase

- (void)setUp
{
	[super setUp];
	
	[self setupClient];
}

- (void)setupClient
{
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	NSString *jsonPath = [bundle pathForResource:@"test_shop_data" ofType:@"json"];
	NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
	NSDictionary *jsonConfig = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
	
	NSDictionary *environment = [[NSProcessInfo processInfo] environment];
	self.shopDomain = environment[kBUYTestDomain] ?: jsonConfig[kBUYTestDomain];
	self.apiKey = environment[kBUYTestAPIKey] ?: jsonConfig[kBUYTestAPIKey];
	self.channelId = environment[kBUYTestChannelId] ?: jsonConfig[kBUYTestChannelId];
	self.merchantId = environment[kBUYTestMerchantId] ?: jsonConfig[kBUYTestMerchantId];
	
	NSDictionary *giftCards = jsonConfig[@"gift_cards"];
	
	self.giftCardCode = environment[kBUYTestGiftCardCode11] ?: giftCards[@"valid11"][@"code"];
	self.giftCardCode2 = environment[kBUYTestGiftCardCode25] ?: giftCards[@"valid25"][@"code"];
	self.giftCardCode3 = environment[kBUYTestGiftCardCode50] ?: giftCards[@"valid50"][@"code"];
	self.giftCardCodeInvalid = environment[kBUYTestInvalidGiftCardCode] ?: giftCards[@"invalid"][@"code"];
	self.giftCardCodeExpired = environment[kBUYTestExpiredGiftCardCode] ?: giftCards[@"expired"][@"code"];
	self.giftCardIdExpired = environment[kBUYTestExpiredGiftCardID] ?: giftCards[@"expired"][@"id"];
	self.discountCodeValid = environment[kBUYTestDiscountCodeValid] ?: jsonConfig[@"discounts"][@"valid"][@"code"];
	self.discountCodeExpired = environment[kBUYTestDiscountCodeExpired] ?: jsonConfig[@"discounts"][@"expired"][@"code"];
	if (environment[kBUYTestProductIdsCommaSeparated]) {
		NSString *productIdsString = [environment[kBUYTestProductIdsCommaSeparated] stringByReplacingOccurrencesOfString:@" " withString:@""];
		self.productIds = [productIdsString componentsSeparatedByString:@","];
	} else {
		self.productIds = jsonConfig[@"product_ids"];
	}
	
	if ([self shouldUseMocks] == YES) {
		NSLog(@"***** Using Mock Tests *****");
		
		self.shopDomain = BUYShopDomain_Placeholder;
		self.apiKey = BUYAPIKey_Placeholder;
		self.channelId = BUYChannelId_Placeholder;
		
		self.giftCardCode = @"rd11";
		self.giftCardCode2 = @"rd25";
		self.giftCardCode3 = @"rd50";
		self.giftCardCodeExpired = @"1234";
		self.giftCardCodeExpired = @"gibberish";
	}
	
	self.client = [[BUYClient alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey channelId:self.channelId];
}

- (BOOL)shouldUseMocks
{	
	if (!self.shopDomain.length && !self.apiKey.length && !self.channelId.length) {
		_shouldUseMocks = YES;
	}
	
	return _shouldUseMocks;
}

@end
