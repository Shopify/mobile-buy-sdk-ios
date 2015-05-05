//
//  NSProcessInfo+Environment.m
//  CheckoutAnywhere
//
//  Created by David Muzi on 2015-05-01.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "NSProcessInfo+Environment.h"

@implementation NSProcessInfo (Environment)

+ (id)environmentForKey:(id)key
{
    NSDictionary *environment = [[self processInfo] environment];
    return environment[key];
}


@end
