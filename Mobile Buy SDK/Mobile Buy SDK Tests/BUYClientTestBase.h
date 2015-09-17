//
//  BUYClientTestBase.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-09-15.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

@import XCTest;
#import <Buy/Buy.h>

@interface BUYClientTestBase : XCTestCase

@property (nonatomic, strong) NSString *shopDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *giftCardCode;
@property (nonatomic, strong) NSString *giftCardCode2;
@property (nonatomic, strong) NSString *giftCardCode3;
@property (nonatomic, strong) NSString *expiredGiftCardCode;
@property (nonatomic, strong) NSString *expiredGiftCardId;

@property (nonatomic, strong) BUYClient *client;

@end
