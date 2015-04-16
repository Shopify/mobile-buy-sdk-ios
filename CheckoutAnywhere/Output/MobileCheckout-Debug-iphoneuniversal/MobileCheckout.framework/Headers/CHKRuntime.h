//
//  MERRuntime.h
//  Storefront
//
//  Created by Joshua Tessier on 2014-09-21.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKRuntime : NSObject

OBJC_EXTERN NSSet* __attribute__((overloadable)) class_getCHKProperties(Class clazz);

@end
