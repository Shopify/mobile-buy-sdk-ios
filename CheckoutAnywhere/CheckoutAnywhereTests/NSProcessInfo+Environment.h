//
//  NSProcessInfo+Environment.h
//  CheckoutAnywhere
//
//  Created by David Muzi on 2015-05-01.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSProcessInfo (Environment)

+ (id)objectForKeyedSubscript:(NSString *)key;

+ (id)environmentForKey:(NSString *)key;

@end
