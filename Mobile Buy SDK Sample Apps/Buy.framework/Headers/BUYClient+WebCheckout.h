//
//  BUYClient+WebCheckout.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYClient.h"

@interface BUYClient (WebCheckout)

- (NSURL *)urlForCheckout:(BUYCheckout *)checkout;

@end
