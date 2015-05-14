//
//  BUYSerializable.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

@import Foundation;

@protocol BUYSerializable <NSObject>

- (NSDictionary *)jsonDictionaryForCheckout;

@end
