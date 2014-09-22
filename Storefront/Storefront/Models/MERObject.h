//
//  MERObject.h
//  Merchant
//
//  Created by Joshua Tessier on 2014-09-10.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MERObject : NSObject

@property (nonatomic, strong, readonly) NSNumber *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)convertJSONArray:(NSArray *)json block:(void (^)(id obj))createdBlock;
+ (NSArray *)convertJSONArray:(NSArray *)json;
+ (instancetype)convertObject:(id)object;

#pragma mark - Dirty Property Tracking

- (NSSet *)dirtyProperties;
- (void)markPropertyAsDirty:(NSString *)property;
+ (void)trackDirtyProperties;

@end
