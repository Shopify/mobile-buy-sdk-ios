//
//  BUYClientTestBase.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-09-15.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

@import XCTest;
#import <Buy/Buy.h>

extern NSString * const BUYShopDomain_Placeholder;
extern NSString * const BUYAPIKey_Placeholder;
extern NSString * const BUYChannelId_Placeholder;

@interface BUYClientTestBase : XCTestCase

@property (nonatomic, strong) NSString *shopDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *giftCardCode;
@property (nonatomic, strong) NSString *giftCardCode2;
@property (nonatomic, strong) NSString *giftCardCode3;
@property (nonatomic, strong) NSString *giftCardCodeExpired;
@property (nonatomic, strong) NSString *giftCardIdExpired;
@property (nonatomic, strong) NSString *giftCardCodeInvalid;
@property (nonatomic, strong) NSString *discountCodeValid;
@property (nonatomic, strong) NSString *discountCodeExpired;
@property (nonatomic, strong) NSArray *productIds;

@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, assign) BOOL shouldUseMocks;

@end
