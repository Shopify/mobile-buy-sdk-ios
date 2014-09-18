//
//  CHKSerializable.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-18.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CHKSerializable <NSObject>

- (NSDictionary *)jsonDictionaryForCheckout;

@end
