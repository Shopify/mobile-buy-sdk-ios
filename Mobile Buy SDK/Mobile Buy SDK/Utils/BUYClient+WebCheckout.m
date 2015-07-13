//
//  BUYClient+WebCheckout.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-05-28.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYClient+WebCheckout.h"
#import "BUYLineItem.h"
#import "BUYProductVariant.h"
#import "BUYCart.h"

@implementation BUYClient (WebCheckout)

- (NSURL *)urlForCart:(BUYCart *)cart
{
	NSMutableString *urlString = [[NSMutableString alloc] initWithFormat:@"https://%@/cart/", self.shopDomain];
	
	// Add line items
	NSMutableArray *lineItemStrings = [[NSMutableArray alloc] initWithCapacity:cart.lineItems.count];
	
	for (BUYLineItem *lineItem in cart.lineItems) {
		[lineItemStrings addObject:[NSString stringWithFormat:@"%@:%@", lineItem.variantId, lineItem.quantity]];
	}
	
	[urlString appendString:[lineItemStrings componentsJoinedByString:@","]];
	
	// Add channel
	[urlString appendFormat:@"?channel_id=%@", self.channelId];
	
	// Add marketing attributions
	NSString *appName = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self.applicationName, NULL, CFSTR(":/?#[]@!$&’()*+,;="), kCFStringEncodingUTF8));

	[urlString appendFormat:@"&marketing_attribution[medium]=iOS&marketing_attribution[source]=%@", appName];
	
	return [NSURL URLWithString:urlString];
}

@end
