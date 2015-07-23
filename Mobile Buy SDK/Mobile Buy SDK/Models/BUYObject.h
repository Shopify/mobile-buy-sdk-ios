//
//  BUYObject.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This is the base class for all Shopify model objects.
 *  This class takes care of convertion .json responses into
 *  the associated subclass.
 *
 *  You will generally not need to interact with this class directly.
 */
@interface BUYObject : NSObject

/**
 *  The identifier of any Shopify model object.
 */
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
