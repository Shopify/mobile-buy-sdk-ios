//
//  BUYPaymentController.m
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

#import "BUYPaymentController.h"

NSString *const BUYPaymentProviderWillStartCheckoutNotificationKey = @"BUYPaymentProviderWillStartCheckoutNotificationKey";
NSString *const BUYPaymentProviderDidDismissCheckoutNotificationKey = @"BUYPaymentProviderDidDismissCheckoutNotificationKey";
NSString *const BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey = @"BUYPaymentProviderDidFailToUpdateCheckoutNotificationKey";
NSString *const BUYPaymentProviderDidFailCheckoutNotificationKey = @"BUYPaymentProviderDidFailCheckoutNotificationKey";
NSString *const BUYPaymentProviderDidCompleteCheckoutNotificationKey = @"BUYPaymentProviderDidCompleteCheckoutNotificationKey";

@interface BUYPaymentController ()
@property (nonatomic, strong) NSMutableOrderedSet <id <BUYPaymentProvider>> *mutableProviders;
@end

@implementation BUYPaymentController

#pragma mark - Accessors -

- (NSSet <id <BUYPaymentProvider>> *)providers
{
	return [self.mutableProviders copy];
}

- (NSArray< id<BUYPaymentProvider> > *)providersArray
{
	return self.mutableProviders.array;
}

- (NSMutableOrderedSet *)mutableProviders
{
	if (_mutableProviders == nil) {
		_mutableProviders = [[NSMutableOrderedSet alloc] init];
	}
	
	return _mutableProviders;
}

#pragma mark - Tasks -

- (void)startCheckout:(BUYCheckout *)checkout withProviderType:(NSString *)typeIdentifier;
{
	id <BUYPaymentProvider> provider = [self providerForType:typeIdentifier];
	[provider startCheckout:checkout];
}

- (void)addPaymentProvider:(id <BUYPaymentProvider>)paymentProvider
{
	if ([self.mutableProviders containsObject:paymentProvider]) {
		NSLog(@"Payment provider %@ has already been added", paymentProvider.identifier);
	}
	
	[self.mutableProviders addObject:paymentProvider];
}

- (id <BUYPaymentProvider>)providerForType:(NSString *)type
{
	for (id <BUYPaymentProvider> provider in self.mutableProviders) {
		if ([provider.identifier isEqualToString: type]) {
			return provider;
		}
	}
	
	return nil;
}

@end
