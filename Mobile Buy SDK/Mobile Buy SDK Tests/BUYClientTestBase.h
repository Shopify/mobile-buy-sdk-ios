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

@import XCTest;
@import Buy;

extern NSString * const BUYShopDomain_Placeholder;
extern NSString * const BUYAPIKey_Placeholder;
extern NSString * const BUYAppId_Placeholder;
extern NSString * const BUYFakeCustomerToken;

@interface BUYClientTestBase : XCTestCase

@property (nonatomic, strong) NSString *shopDomain;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *customerEmail;
@property (nonatomic, strong) NSString *customerPassword;
@property (nonatomic, strong) NSString *giftCardCode;
@property (nonatomic, strong) NSString *giftCardCode2;
@property (nonatomic, strong) NSString *giftCardCode3;
@property (nonatomic, strong) NSString *giftCardCodeExpired;
@property (nonatomic, strong) NSNumber *giftCardIdExpired;
@property (nonatomic, strong) NSString *giftCardCodeInvalid;
@property (nonatomic, strong) NSString *discountCodeValid;
@property (nonatomic, strong) NSString *discountCodeExpired;

@property (nonatomic, strong) NSArray<NSNumber *> *customerOrderIDs;
@property (nonatomic, strong) NSArray *productIds;
@property (nonatomic, strong) NSArray *collectionIds;

@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, strong) BUYClient *client;

@property (nonatomic, readonly) BOOL shouldUseMocks;

@end
