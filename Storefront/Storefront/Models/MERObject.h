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
@property (nonatomic, readonly, getter=isDirty) BOOL dirty;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)updateWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)convertJSONArray:(NSArray *)json block:(void (^)(id obj))createdBlock;
+ (NSArray *)convertJSONArray:(NSArray *)json;
+ (instancetype)convertObject:(id)object;

#pragma mark - Dirty Property Tracking

- (NSSet *)dirtyProperties;
- (void)markPropertyAsDirty:(NSString *)property;
- (void)markAsClean;
+ (void)trackDirtyProperties;

@end
