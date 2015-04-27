//
//  CHKObject.h
//  Checkout
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKObject : NSObject

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
