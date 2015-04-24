//
//  CHKSerializable.h
//  Checkout
//
//  Created by Shopify on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@protocol CHKSerializable <NSObject>

//TODO: Should there be an optional 'PATCH' jsonDictionary?
- (NSDictionary *)jsonDictionaryForCheckout;

@end
