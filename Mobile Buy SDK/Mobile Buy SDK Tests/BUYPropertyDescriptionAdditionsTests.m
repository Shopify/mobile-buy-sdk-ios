//
//  BUYPropertyDescriptionAdditionsTests.m
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

#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>

#import "BUYFlatCollectionTransformer.h"
#import "BUYDateTransformer.h"
#import "NSPropertyDescription+BUYAdditions.h"
#import "TestModel.h"

static NSString * const RootEntity = @"Root";
static NSString * const BranchEntity = @"Branch";
static NSString * const LeafEntity = @"Leaf";
static NSString * const NestEntity = @"Nest";
static NSString * const BirdEntity = @"Bird";

@interface BUYPropertyDescriptionAdditionsTests : XCTestCase
@property (nonatomic) NSManagedObjectModel *model;
@property (nonatomic) TestModelManager *modelManager;
@end

@implementation BUYPropertyDescriptionAdditionsTests

+ (void)initialize
{
	if (self == [BUYPropertyDescriptionAdditionsTests class]) {
		[NSValueTransformer setValueTransformer:[BUYFlatCollectionTransformer arrayTransformer] forName:@"Array"];
		[NSValueTransformer setValueTransformer:[BUYFlatCollectionTransformer setTransformer] forName:@"Set"];
	}
}

- (instancetype)initWithInvocation:(NSInvocation *)invocation
{
	self = [super initWithInvocation:invocation];
	if (self) {
		self.modelManager = [[TestModelManager alloc] init];
		self.model = self.modelManager.model;
	}
	return self;
}

- (NSEntityDescription *)entityForName:(NSString *)entityName
{
	return self.model.entitiesByName[entityName];
}

- (NSAttributeDescription *)attributeWithName:(NSString *)attributeName forEntity:(NSString *)entityName
{
	return [[self entityForName:entityName] attributesByName][attributeName];
}

- (NSRelationshipDescription *)relationshipWithName:(NSString *)propertyName forEntity:(NSString *)entityName
{
	return [[self entityForName:entityName] relationshipsByName][propertyName];
}

- (void)testJSONTransformerName
{
	XCTAssertEqualObjects(BUYDateTransformerName, [self attributeWithName:@"date" forEntity:LeafEntity].JSONValueTransformerName);
}

- (void)testJSONPropertyKey
{
	XCTAssertEqualObjects(@"createDate", [self attributeWithName:@"date" forEntity:LeafEntity].JSONPropertyKey);
}

- (void)testJSONValueTransformer
{
	XCTAssertEqualObjects([BUYFlatCollectionTransformer class], [[self attributeWithName:@"tags" forEntity:LeafEntity].JSONValueTransformer class]);
}

- (void)testInteger
{
	NSAttributeDescription *idAttribute = [self attributeWithName:@"identifier" forEntity:RootEntity];
	NSNumber *identifier = @10001;
	XCTAssertEqualObjects(identifier, [idAttribute buy_JSONForValue:identifier]);
	XCTAssertEqualObjects(identifier, [idAttribute buy_valueForJSON:identifier object:nil]);
}

- (void)testString
{
	NSAttributeDescription *stringAttribute = [self attributeWithName:@"name" forEntity:RootEntity];
	NSString *name = @"MyRoot";
	XCTAssertEqualObjects(name, [stringAttribute buy_JSONForValue:name]);
	XCTAssertEqualObjects(name, [stringAttribute buy_valueForJSON:name object:nil]);
}

- (void)testDecimalNumber
{
	NSAttributeDescription *decimalAttribute = [self attributeWithName:@"age" forEntity:RootEntity];
	NSString *ageString = @"145";
	NSDecimalNumber *age = [NSDecimalNumber decimalNumberWithString:ageString];
	XCTAssertEqualObjects(ageString, [decimalAttribute buy_JSONForValue:age]);
	XCTAssertEqualObjects(age, [decimalAttribute buy_valueForJSON:ageString object:nil]);
}

- (void)testDate
{
	NSAttributeDescription *dateAttribute = [self attributeWithName:@"date" forEntity:LeafEntity];
	NSString *dateString = @"1970-01-01T01:17:59+0000";
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:4679.0];
	XCTAssertEqualObjects(dateString, [dateAttribute buy_JSONForValue:date]);
	XCTAssertEqualObjects(date, [dateAttribute buy_valueForJSON:dateString object:nil]);
}

- (void)testURL
{
	// the Root.url attribute declares "attributeValueClass = NSURL; JSONTransformerName = BUYURL"
	NSAttributeDescription *urlAttribute = [self attributeWithName:@"url" forEntity:RootEntity];
	NSString *urlString = @"https://www.example.com/api/model.json?id=100";
	NSURL *url = [NSURL URLWithString:urlString];
	XCTAssertEqualObjects(urlString, [urlAttribute buy_JSONForValue:url]);
	XCTAssertEqualObjects(url, [urlAttribute buy_valueForJSON:urlString object:nil]);
}

- (void)testFlatArray
{
	NSAttributeDescription *arrayDescription = [self attributeWithName:@"ornaments" forEntity:BranchEntity];
	NSString *ornamentsString = @"one two three two one";
	NSArray *ornaments = @[@"one", @"two", @"three", @"two", @"one"];
	XCTAssertEqualObjects(ornamentsString, [arrayDescription buy_JSONForValue:ornaments]);
	XCTAssertEqualObjects(ornaments, [arrayDescription buy_valueForJSON:ornamentsString object:nil]);
}

- (void)testFlatSet
{
	NSAttributeDescription *setDescription = [self attributeWithName:@"tags" forEntity:LeafEntity];
	NSString *tagsString = @"blue green red";
	NSSet *tags = [NSSet setWithArray:@[@"red", @"green", @"blue"]];
	XCTAssertEqualObjects(tags, [setDescription buy_valueForJSON:tagsString object:nil]);

	NSString *jsonString = [setDescription buy_JSONForValue:tags];
	NSSet *actual = [NSSet setWithArray:[jsonString componentsSeparatedByString:@" "]];
	XCTAssertEqualObjects(actual, tags);
}

- (void)testRelationship
{
	Branch *branch = [self.modelManager buy_objectWithEntityName:BranchEntity JSONDictionary:nil];
	NSRelationshipDescription *nestRelationship = [self relationshipWithName:@"nest" forEntity:BranchEntity];
	NSDictionary *expected = @{ @"egg_count" : @2 };
	id<BUYObject> object = [nestRelationship buy_valueForJSON:expected object:branch];
	NSDictionary *actual = [nestRelationship buy_JSONForValue:object];
	XCTAssertEqualObjects(actual, expected);
}

- (void)testRecursiveRelationship
{
	Branch *branch = [self.modelManager buy_objectWithEntityName:BranchEntity JSONDictionary:nil];
	NSRelationshipDescription *nestRelationship = [self relationshipWithName:@"nest" forEntity:BranchEntity];
	NSDictionary *json = @{ @"bird_id" : @501 };
	id object = [nestRelationship buy_valueForJSON:json object:branch];
	XCTAssertEqualObjects(@501, [[object bird] identifier]);
	id actual = [nestRelationship buy_JSONForValue:object];
	XCTAssertEqualObjects(actual, json);
}

- (void)testToManyRelationship
{
	Branch *branch = [self.modelManager buy_objectWithEntityName:BranchEntity JSONDictionary:nil];
	NSRelationshipDescription *leafRelationship = [self relationshipWithName:@"leaves" forEntity:BranchEntity];
	id json = @[
				@{
					@"date" : @"2001-01-21T00:00:00 +0000",
					@"tags" : @"test one two"
					},
				@{
					@"date" : @"2010-06-11T00:00:00 +0000",
					@"tags" : @"phone"
					},
				@{
					@"date" : @"2013-11-03T00:00:00 +0000",
					@"tags" : @"song tune album"
					},
				];
	NSSet *object = [leafRelationship buy_valueForJSON:json object:branch];
	XCTAssertTrue([object isKindOfClass:[NSSet class]]);
	XCTAssertTrue([[object anyObject] isKindOfClass:[Leaf class]]);
	NSSet *expected = [NSSet setWithObjects:
					   [NSSet setWithObjects:@"test", @"one", @"two", nil],
					   [NSSet setWithObjects:@"phone", nil],
					   [NSSet setWithObjects:@"song", @"tune", @"album", nil],
					   nil];
	XCTAssertEqualObjects(expected, [object valueForKey:@"tags"]);
}

@end
