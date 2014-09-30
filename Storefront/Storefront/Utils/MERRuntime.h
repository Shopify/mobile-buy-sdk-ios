//
//  MERRuntime.h
//  Storefront
//
//  Created by Joshua Tessier on 2014-09-21.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERRuntime : NSObject

OBJC_EXTERN NSSet* __attribute__((overloadable)) class_getMERProperties(Class clazz);

@end
