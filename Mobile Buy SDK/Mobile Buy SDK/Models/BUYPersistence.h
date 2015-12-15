//
//  BUYPersistence.h
//  Mobile Buy SDK
//
//  Created by James G. Speth on 12/15/15.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BUYPersistence <NSObject>

+ (instancetype)instanceWithPlistDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)plistDictionary;

@end
