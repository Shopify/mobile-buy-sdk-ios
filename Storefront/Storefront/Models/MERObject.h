//
//  MERObject.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

@protocol MERObject <NSObject>
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end

@interface MERObject : NSObject <MERObject>

@property (nonatomic, strong, readonly) NSNumber *identifier;

+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz block:(void (^)(id obj))createdBlock;
+ (NSArray*)convertJSONArray:(NSArray*)json toArrayOfClass:(Class)clazz;
+ (id <MERObject>)convertDictionary:(id)object toObjectOfClass:(Class)clazz;

@end
