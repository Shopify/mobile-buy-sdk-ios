//
//  TestModel.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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

@class Leaf, Nest, Researcher, Root;

@interface Bird : TestModel
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSString *colour;
@property (nonatomic) NSSet<Nest *> *nests;
@property (nonatomic) NSSet<Researcher *> *researchers;
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
@property (nonatomic) Branch *branch;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSSet<NSString *> *tags;
@end

@interface Nest : TestModel
@property (nonatomic) NSNumber *eggCount;
@property (nonatomic) Bird *bird;
@property (nonatomic) Branch *branch;
@end

@interface Researcher : TestModel
@property (nonatomic) NSString *name;
@property (nonatomic) NSSet<Bird *> *birds;
@end

@interface Root : TestModel
@property (nonatomic) NSNumber *identifier;
@property (nonatomic) NSDecimalNumber *age;
@property (nonatomic) NSString *name;
@property (nonatomic) NSURL *url;
@property (nonatomic) NSSet<Branch *> *branches;
@property (nonatomic) Forest *forest;
@end
