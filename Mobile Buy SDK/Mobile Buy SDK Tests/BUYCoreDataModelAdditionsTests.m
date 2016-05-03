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
#import "BUYIdentityTransformer.h"
#import "NSEntityDescription+BUYAdditions.h"
#import "NSPropertyDescription+BUYAdditions.h"
#import "TestModel.h"

static NSString * const RootEntity = @"Root";
static NSString * const BranchEntity = @"Branch";
static NSString * const LeafEntity = @"Leaf";
static NSString * const NestEntity = @"Nest";
static NSString * const BirdEntity = @"Bird";

@interface NSIndexSet (BUYTestAdditions)
+ (instancetype)indexSetWithIndexes:(NSArray *)indexes;
@end

@interface BUYCoreDataModelAdditionsTests : XCTestCase
@property (nonatomic) NSManagedObjectModel *model;
@property (nonatomic) TestModelManager *modelManager;
@end

@implementation BUYCoreDataModelAdditionsTests

+ (void)initialize
{
	if (self == [BUYCoreDataModelAdditionsTests class]) {
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
	XCTAssertEqualObjects(BUYIdentityTransformerName, [self attributeWithName:@"identifier" forEntity:RootEntity].JSONValueTransformerName);
}

- (void)testJSONPropertyKey
{
	XCTAssertEqualObjects(@"createDate", [self attributeWithName:@"date" forEntity:LeafEntity].JSONPropertyKey);
}

- (void)testJSONValueTransformer
{
	XCTAssertEqualObjects([BUYFlatCollectionTransformer class], [[self attributeWithName:@"tags" forEntity:LeafEntity].JSONValueTransformer class]);
}

- (void)testNilAttribute
{
	NSAttributeDescription *idAttribute = [self attributeWithName:@"identifier" forEntity:RootEntity];
	XCTAssertNil([idAttribute buy_JSONForValue:nil]);
	XCTAssertEqualObjects([idAttribute buy_valueForJSON:nil object:nil], [NSNull null]);
}

- (void)testNullAttribute
{
	NSAttributeDescription *idAttribute = [self attributeWithName:@"identifier" forEntity:RootEntity];
	XCTAssertEqualObjects([idAttribute buy_JSONForValue:[NSNull null]], [NSNull null]);
	XCTAssertEqualObjects([idAttribute buy_valueForJSON:[NSNull null] object:nil], [NSNull null]);
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

- (void)testNilRelationship
{
	Branch *branch = [self.modelManager buy_objectWithEntityName:BranchEntity JSONDictionary:nil];
	NSRelationshipDescription *nestRelationship = [self relationshipWithName:@"nest" forEntity:BranchEntity];
	XCTAssertNil([nestRelationship buy_valueForJSON:nil object:branch]);
}

- (void)testNullRelationship
{
	Branch *branch = [self.modelManager buy_objectWithEntityName:BranchEntity JSONDictionary:nil];
	NSRelationshipDescription *nestRelationship = [self relationshipWithName:@"nest" forEntity:BranchEntity];
	XCTAssertNil([nestRelationship buy_valueForJSON:[NSNull null] object:branch]);
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
	
	// Semi-random leaf objects
	branch.leaves = [NSSet setWithArray:@[[self leafWithDate:[self dateWithComponents:[self november4_1605]] tags:[self tagsWithIndexes:@[@1, @5, @11]]],
										  [self leafWithDate:[self dateWithComponents:[self june21_1970]] tags:[self tagsWithIndexes:@[@9]]],
										  [self leafWithDate:[self dateWithComponents:[self jan1_2000]] tags:[self tagsWithIndexes:@[@12, @0, @8, @4]]]]];
	id json = [leafRelationship buy_JSONForValue:branch.leaves];
	id actual = [leafRelationship buy_valueForJSON:json object:branch];
	XCTAssertEqualObjects(actual, branch.leaves);
}

- (void)testEntityIsPrivate
{
	NSEntityDescription *forestEntity = [self entityForName:[Forest entityName]];
	XCTAssertTrue([forestEntity buy_isPrivate]);
}

- (void)testFetchedProperty
{
	NSFetchedPropertyDescription *fetchedProperty = [[NSFetchedPropertyDescription alloc] init];
	XCTAssertNil([fetchedProperty buy_valueForJSON:nil object:nil]);
	XCTAssertNil([fetchedProperty buy_JSONForValue:nil]);
}

- (Leaf *)leafWithDate:(NSDate *)date tags:(NSSet *)tags
{
	Leaf *leaf = [self.modelManager buy_objectWithEntityName:[Leaf entityName] JSONDictionary:nil];
	leaf.date = date;
	leaf.tags = tags;
	return leaf;
}

- (NSSet *)tagsWithIndexes:(NSArray *)indexes
{
	static NSArray *tags;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		tags = @[@"one", @"two", @"three", @"hot", @"urgent", @"important", @"red", @"green", @"blue", @"animal", @"vegetable", @"mineral", @"fungus"];
	});
	return [NSSet setWithArray:[tags objectsAtIndexes:[NSIndexSet indexSetWithIndexes:indexes]]];
}

- (NSDate *)dateWithComponents:(NSDateComponents *)components
{
	return [[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:components];
}

- (NSDateComponents *)november4_1605
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = 1605;
	components.month = 11;
	components.day = 4;
	return components;
}

- (NSDateComponents *)june21_1970
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = 1970;
	components.month = 6;
	components.day = 21;
	return components;
}

- (NSDateComponents *)jan1_2000
{
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.year = 2000;
	components.month = 1;
	components.day = 1;
	components.second = 1;
	return components;
}

@end

@implementation NSIndexSet (BUYTestAdditions)

+ (instancetype)indexSetWithIndexes:(NSArray *)indexes
{
	NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
	for (NSNumber *index in indexes) {
		[indexSet addIndex:index.unsignedIntegerValue];
	}
	return indexSet;
}

@end
