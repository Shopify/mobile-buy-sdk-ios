//
//  BUYProductTests.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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

@import XCTest;
@import Buy;

@interface BUYProductTests : XCTestCase
@end

@implementation BUYProductTests

# pragma mark - Default Variant Checker Tests

- (void)testDefaultVariantCheckerWithCorrectOptionValues {
	XCTAssertTrue([self isDefaultVariantWithName:@"Title" value:@"Default" optionID:@1]);
	XCTAssertTrue([self isDefaultVariantWithName:@"Title" value:@"Default Title" optionID:@1]);
}

- (void)testDefaultVariantCheckerWithIncorrectOptionValues {
	XCTAssertFalse([self isDefaultVariantWithName:@"name1" value:@"value1" optionID:@1]);
}

- (BOOL)isDefaultVariantWithName:(NSString *)name value:(NSString *)value optionID:(NSNumber *)option_id {
	BUYModelManager *model = [BUYModelManager modelManager];
	BUYProduct *product = [[BUYProduct alloc] init];
	BUYProductVariant *variant = [[BUYProductVariant alloc] initWithModelManager:model
																  JSONDictionary:@{ @"id" : @1}];
	
	BUYOptionValue *option = [model buy_objectWithEntityName:[BUYOptionValue entityName] JSONDictionary:@{
																										  @"name"      : name,
																										  @"value"     : value,
																										  @"option_id" : option_id,
																										  }];
	variant.options = [[NSSet alloc] initWithArray:@[option]];
	product.variants = [[NSOrderedSet alloc] initWithArray:@[variant]];
	
	return [product isDefaultVariant];
}

- (void)testDefaultVariantCheckerWithEmptyProduct {
	BUYProduct *product = [[BUYProduct alloc] init];
	XCTAssertFalse([product isDefaultVariant]);
}

- (void)testMinimumPrices
{
	NSArray *variantsJSON = @[
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber one],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:100],
								  },
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber numberWithInt:25],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:44],
								  },
							  @{
								  @"id" : @1,
								  @"price" : [NSDecimalNumber numberWithInt:90],
								  @"compareAtPrice": [NSDecimalNumber numberWithInt:12],
								  },
							  ];
	NSDictionary *json = @{
						   @"id" : @1,
						   @"variants" : variantsJSON,
						   };
	BUYProduct *product = [[BUYModelManager modelManager] insertProductWithJSONDictionary:json];
	
	XCTAssertEqualObjects(product.minimumPrice, [NSDecimalNumber one]);
	XCTAssertEqualObjects(product.minimumCompareAtPrice, [NSDecimalNumber numberWithInt:12]);
}

@end
