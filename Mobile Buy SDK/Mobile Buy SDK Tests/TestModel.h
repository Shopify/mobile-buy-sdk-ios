//
//  TestModel.h
//  Mobile Buy SDK
//
//  Created by Brent Gulanowski on 2016-04-27.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUYObjectProtocol.h"
#import "BUYModelManagerProtocol.h"

@class NSManagedObjectModel;

@interface TestModelManager : NSObject<BUYModelManager>
@property (nonatomic) NSManagedObjectModel *model;
@end

@interface TestModel : NSObject<BUYObject>
@property (nonatomic, strong) TestModelManager *modelManager;
@end

@class Leaf, Nest, Root;

@interface Bird : TestModel
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSString *colour;
+ (instancetype)birdWithIdentifier:(NSNumber *)identifier;
@end

@interface Branch : TestModel
@property (nonatomic) NSArray<NSString *> *ornaments;
@property (nonatomic) NSSet<Leaf *> *leaves;
@property (nonatomic) Nest *nest;
@end

@interface Forest : TestModel
@property (nonatomic) NSSet<Root *> *trees;
@end

@interface Leaf : TestModel
@property (nonatomic) NSDate *date;
@property (nonatomic) NSSet<NSString *> *tags;
@end

@interface Nest : TestModel
@property (nonatomic) NSNumber *eggCount;
@property (nonatomic) Bird *bird;
@property (nonatomic) Branch *branch;
@end

@interface Root : TestModel
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSDecimalNumber *age;
@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *url;
@property (nonatomic) NSSet<Branch *> *branches;
@property (nonatomic) Forest *forest;
@end
