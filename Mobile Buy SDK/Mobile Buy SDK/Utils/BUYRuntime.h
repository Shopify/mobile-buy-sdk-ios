//
//  BUYRuntime.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUYRuntime : NSObject

OBJC_EXTERN NSSet* __attribute__((overloadable)) class_getBUYProperties(Class clazz);

@end
