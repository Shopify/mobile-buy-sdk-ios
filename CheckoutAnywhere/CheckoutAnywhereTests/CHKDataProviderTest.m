//
//  CHKDataProviderTest.m
//  Checkout
//
//  Created by Shopify on 2014-12-04.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "CHKDataProvider.h"
#import "CHKTestConstants.h"
#import "CHKCheckout.h"
#import "CHKCart.h"
#import "NSProcessInfo+Environment.h"

@interface TESTDataProvider : CHKDataProvider
@end

@implementation TESTDataProvider

- (void)startTask:(NSURLSessionDataTask *)task
{
	//Do nothing
}

@end

@interface CHKDataProviderTest : XCTestCase
@end

@implementation CHKDataProviderTest {
	CHKDataProvider *_dataProvider;
    
    NSString *shopDomain;
    NSString *apiKey;
    NSString *giftCardCode;
    NSString *expiredGiftCardCode;
    NSString *expiredGiftCardId;
}

- (void)setUp
{
	[super setUp];
	
	shopDomain = [NSProcessInfo environmentForKey:kCHKTestDomain];
	apiKey = [NSProcessInfo environmentForKey:kCHKTestAPIKey];
	giftCardCode = [NSProcessInfo environmentForKey:kCHKTestGiftCardCode];
	expiredGiftCardCode = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardCode];
	expiredGiftCardId = [NSProcessInfo environmentForKey:kCHKTestExpiredGiftCardID];
	
	XCTAssert([shopDomain length] > 0, @"You must provide a valid CHECKOUT_ANYWHERE_SHOP. This is your 'shopname.myshopify.com' address.");
	XCTAssert([apiKey length] > 0, @"You must provide a valid CHECKOUT_ANYHWERE_API_KEY. This is the API_KEY of your app.");
	
	_dataProvider = [[TESTDataProvider alloc] initWithShopDomain:shopDomain apiKey:apiKey];
}

- (void)testCheckoutSerialization
{
	CHKCart *cart = [[CHKCart alloc] init];
	CHKCheckout *checkout = [[CHKCheckout alloc] initWithCart:cart];
	NSURLSessionDataTask *task = [_dataProvider createCheckout:checkout completion:nil];
	XCTAssertNotNil(task);
	
	NSURLRequest *request = task.originalRequest;
	XCTAssertNotNil(request);
	
	NSData *data = request.HTTPBody;
	XCTAssertNotNil(data);
	
    NSDictionary *dict = @{@"checkout":
							   @{@"partial_addresses": @1,
								 @"line_items": @[]}};
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
	XCTAssertEqualObjects(dict, json);
}

@end
