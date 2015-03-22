//
//  CHKDataProviderTest.m
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-12-04.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import UIKit;
@import XCTest;

#import "CHKDataProvider.h"
#import "CHKTestConstants.h"
#import "CHKCheckout.h"
#import "CHKCart.h"

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
}

- (void)setUp
{
	[super setUp];
	
	XCTAssert([CHECKOUT_ANYWHERE_SHOP length] > 0, @"You must provide a valid CHECKOUT_ANYWHERE_SHOP. This is your 'shopname.myshopify.com' address.");
	XCTAssert([CHECKOUT_ANYHWERE_API_KEY length] > 0, @"You must provide a valid CHECKOUT_ANYHWERE_API_KEY. This is the API_KEY of your app.");
	
	_dataProvider = [[TESTDataProvider alloc] initWithShopDomain:CHECKOUT_ANYWHERE_SHOP apiKey:CHECKOUT_ANYHWERE_API_KEY];
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
	
	NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	XCTAssertEqualObjects(@"{\"checkout\":{\"partial_addresses\":true,\"line_items\":[]}}", string);
}

@end
