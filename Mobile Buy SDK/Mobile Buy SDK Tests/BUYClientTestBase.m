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
#import "BUYTestConstants.h"

NSString * const BUYShopDomain_Placeholder = @"test_shop";
NSString * const BUYAPIKey_Placeholder = @"api_key";
NSString * const BUYAppId_Placeholder = @"app_id";

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
	self.appId = environment[kBUYTestAppId] ?: jsonConfig[kBUYTestAppId];
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
		self.appId = BUYAppId_Placeholder;
		
		self.giftCardCode = @"rd11";
		self.giftCardCode2 = @"rd25";
		self.giftCardCode3 = @"rd50";
		self.giftCardCodeExpired = @"1234";
		self.giftCardCodeExpired = @"gibberish";
	}
	
	self.client = [[BUYClient alloc] initWithShopDomain:self.shopDomain apiKey:self.apiKey appId:self.appId];
}

- (BOOL)shouldUseMocks
{	
	if (!self.shopDomain.length && !self.apiKey.length && !self.appId.length) {
		_shouldUseMocks = YES;
	}
	
	return _shouldUseMocks;
}

@end
