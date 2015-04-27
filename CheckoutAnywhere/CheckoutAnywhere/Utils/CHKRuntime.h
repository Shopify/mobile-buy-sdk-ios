//
//  CHKRuntime.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKRuntime : NSObject

OBJC_EXTERN NSSet* __attribute__((overloadable)) class_getCHKProperties(Class clazz);

@end
