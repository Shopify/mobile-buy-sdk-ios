//
//  MERObject.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@interface MERObject : NSObject

@property (nonatomic, strong, readonly) NSNumber *identifier;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz block:(void (^)(id obj))createdBlock;
+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz;
+ (id)convertObject:(id)object toMerObjectOfClass:(Class)clazz;

@end
