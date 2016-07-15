//
//  buymodel_tests.m
//  buymodel tests
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

#import "BUYManagedObject.h"

#import "BUYCollection.h"
//#import "BUYCustomer.h"
#import "BUYProduct.h"
#import "BUYProductVariant.h"
#import "BUYShop.h"

#import "BUYAddress.h"
#import "BUYCheckout.h"
#import "BUYLineItem.h"

#import "BUYModelManager.h"

#import <CoreData/CoreData.h>

@interface BUYModelManager (buymodel_tests)
- (BUYCollection *)newTestCollection;
- (BUYCollection *)newTestCollectionWithProducts:(NSArray *)products;
- (BUYProduct *)newTestProduct;
- (BUYProduct *)newTestProductWithVariants:(NSArray *)variants;
- (BUYProductVariant *)newTestVariant;
@end

@interface NSJSONSerialization (buymodel_tests)
+ (NSDictionary *)JSONDictionaryWithData:(NSData *)data;
+ (NSDictionary *)JSONDictionaryWithString:(NSString *)string;
@end

@interface BUYModelManagerTests : XCTestCase {
	BUYModelManager *_modelManager;
}

@end

static NSDictionary *sampleJSON;

@implementation BUYModelManagerTests

+ (void)initialize
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURL *jsonURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"mocked_responses" withExtension:@"json"];
		NSData *jsonData = [NSData dataWithContentsOfURL:jsonURL];
		sampleJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
	});
}

- (NSManagedObjectModel *)buyModel
{
	NSBundle *bundle = [NSBundle bundleForClass:[BUYObject class]];
	XCTAssertNotNil(bundle, @"Cannot find bundle for BUYManagedObject");
	NSURL *url = [bundle URLForResource:@"Mobile Buy SDK" withExtension:@"momd"];
	XCTAssertNotNil(url);
	return [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
}

- (void)setUp
{
	[super setUp];
	_modelManager = [[BUYModelManager alloc] initWithManagedObjectModel:[self buyModel]];
	
}

- (void)tearDown
{
	_modelManager = nil;
}

- (void)testCoreDataModelDefinitions
{
	NSManagedObjectModel *model = _modelManager.model;
	NSDictionary *entities = [model entitiesByName];
	
	XCTAssertGreaterThan(entities.count, 0, @"No entities found in model %@", model);
	
	NSArray *persistentEntities = [model entitiesForConfiguration:@"persistent"];
	NSArray *transientEntities = [model entitiesForConfiguration:@"transient"];
	
	XCTAssertEqual((persistentEntities.count + transientEntities.count), entities.count, @"Some entities in model not included in configurations");
}

- (void)testConvertJSON
{
	NSString *JSONString = sampleJSON[@"testGetShop_0"][@"body"];
	NSDictionary *expected = [NSJSONSerialization JSONDictionaryWithString:JSONString];
	
	id<BUYObject> object = [_modelManager buy_objectWithEntityName:@"Shop" JSONDictionary:expected];
	NSDictionary *actual = object.JSONDictionary;
	XCTAssertEqualObjects(actual, expected, @"generated dictionary was incorrect");
}

#if 0
- (void)testTransformFromJSONTransient
{

}

- (void)testTransformFromJSONPersistent
{
	
}

- (void)testTransformFromJSONPersistentUnique
{
	
}

- (void)testTransformtoJSONTransient
{
	
}

- (void)testTransformToJSONPersistent
{
	
}
#endif

- (BUYCheckout *)newTestCheckout
{
	return [self newTestCheckoutWithLineItems:@[[self newTestLineItem], [self newTestLineItem], [self newTestLineItem]]];
}

- (BUYCheckout *)newTestCheckoutWithLineItems:(NSArray *)lineItems
{
	static NSUInteger checkoutId = 0;
	++checkoutId;
	NSDictionary *props = @{
							@"identifier" : @(checkoutId),
							};
	BUYCheckout *checkout = [[BUYCheckout alloc] initWithModelManager:_modelManager JSONDictionary:props];
	checkout.lineItems = [NSOrderedSet orderedSetWithArray:lineItems];
	return checkout;
}

- (BUYLineItem *)newTestLineItem
{
	return [self newTestLineItemWithVariant:[_modelManager newTestVariant]];
}

- (BUYLineItem *)newTestLineItemWithVariant:(BUYProductVariant *)variant
{
	static NSUInteger lineItemId = 0;
	++lineItemId;
	NSDictionary *props = @{
							@"identifier" : @(lineItemId),
							};
	BUYLineItem *lineItem = [[BUYLineItem alloc] initWithModelManager:_modelManager JSONDictionary:props];
	lineItem.variantId = variant.identifier;
	return lineItem;
}

@end

@implementation BUYModelManager (buymodel_tests)

- (BUYCollection *)newTestCollection
{
	return [self newTestCollectionWithProducts:@[[self newTestProduct], [self newTestProduct]]];
}

- (BUYCollection *)newTestCollectionWithProducts:(NSArray *)products
{
	static NSUInteger collectionId = 0;
	++collectionId;
	NSDictionary *props = @{
							BUYCollectionAttributes.identifier : @(collectionId),
							BUYCollectionAttributes.title : [NSString stringWithFormat:@"Collection-%tu", collectionId],
							};
	BUYCollection *collection = [self insertCollectionWithJSONDictionary:props];
	collection.products = [NSOrderedSet orderedSetWithArray:products];
	return collection;
}

- (BUYProduct *)newTestProduct
{
	return [self newTestProductWithVariants:@[[self newTestVariant], [self newTestVariant]]];
}

- (BUYProduct *)newTestProductWithVariants:(NSArray *)variants
{
	static NSUInteger productId = 0;
	++productId;
	
	int32_t order = 0;
	for (BUYProductVariant *variant in variants) {
		variant.positionValue = order++;
	}
	
	NSDictionary *props = @{
							BUYProductAttributes.identifier : @(productId),
							BUYProductAttributes.title : [NSString stringWithFormat:@"Product-%tu", productId],
							};
	BUYProduct *product = [self insertProductWithJSONDictionary:props];
	product.variants = [NSOrderedSet orderedSetWithArray:variants];
	return product;
}

- (BUYProductVariant *)newTestVariant
{
	static NSUInteger variantId = 0;
	++variantId;
	NSDictionary *props = @{
							BUYProductVariantAttributes.identifier : @(variantId),
							BUYProductVariantAttributes.available : @YES,
							BUYProductVariantAttributes.requiresShipping : @YES,
							BUYProductVariantAttributes.title : [NSString stringWithFormat:@"Variant-%tu", variantId],
							BUYProductVariantAttributes.price : [NSDecimalNumber decimalNumberWithString:@"9.95"]
							};
	return [self insertProductVariantWithJSONDictionary:props];
}

@end

@implementation NSJSONSerialization (buymodel_tests)

+ (NSDictionary *)JSONDictionaryWithData:(NSData *)data
{
	NSError *error = nil;
	NSDictionary *dictionary = [self JSONObjectWithData:data options:0 error:&error];
	if (nil == dictionary) {
		NSLog(@"Failed to decode %tu bytes of data; error: %@", data.length, error);
	}
	return dictionary;
}

+ (NSDictionary *)JSONDictionaryWithString:(NSString *)string
{
	return [self JSONDictionaryWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
