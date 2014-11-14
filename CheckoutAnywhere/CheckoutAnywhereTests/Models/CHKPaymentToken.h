//
//  CHKPaymentToken.h
//  CheckoutAnywhere
//
//  Created by Allan Godding on 2014-11-05.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <PassKit/PassKit.h>

/**
 * Simple wrapper on PKPaymentToken to allow writing to the paymentData field for testing purposes
 */
@interface CHKPaymentToken : PKPaymentToken

- (id)initWithPaymentToken:(NSString *)paymentTokenString;

@end
