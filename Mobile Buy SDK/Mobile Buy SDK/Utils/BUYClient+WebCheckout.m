//
//  BUYClient+WebCheckout.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-28.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYClient+WebCheckout.h"
#import "BUYCheckout.h"

@implementation BUYClient (WebCheckout)

- (NSURL *)urlForCheckout:(BUYCheckout *)checkout
{
	NSString *checkoutToken = checkout.token;
	NSString *channel = self.channelId;
	
	NSURL *url = nil;

	if (checkoutToken.length) {
		
		NSString *urlString = [NSString stringWithFormat:@"https://checkout.shopify.com/%@/checkouts/%@/?channel=%@&marketing_attributions=platform-ios", @"2958581", checkoutToken, channel];
		
		url = [NSURL URLWithString:urlString];
	}
	

	return url;
}


@end
