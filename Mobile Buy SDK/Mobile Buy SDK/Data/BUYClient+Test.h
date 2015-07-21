//
//  BUYClient+Test.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYClient (Test)

/**
 *  Test the integration with your shop.  This should not be shipped in production code.  This is a syncronous network call.
 *  @param merchantId the merchant ID setup for Apple Pay in the Integration page of the Mobile Channel
 *
 *  @return YES on success
 */
- (BOOL)testIntegrationWithMerchantId:(NSString *)merchantId;

@end
