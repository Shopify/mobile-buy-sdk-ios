//
//  CHKSerializable.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

@protocol CHKSerializable <NSObject>

//TODO: Should there be an optional 'PATCH' jsonDictionary?
- (NSDictionary *)jsonDictionaryForCheckout;

@end
