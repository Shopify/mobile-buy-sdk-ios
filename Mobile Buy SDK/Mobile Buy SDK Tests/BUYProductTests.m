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
	[self testDefaultVariantCheckerWithName:@"Title" andValue:@"Default" withOptionID:@1 isValid:YES];
	[self testDefaultVariantCheckerWithName:@"Title" andValue:@"Default Title" withOptionID:@1 isValid:YES];
}

- (void)testDefaultVariantCheckerWithIncorrectOptionValues {
	[self testDefaultVariantCheckerWithName:@"name1" andValue:@"value1" withOptionID:@1 isValid:NO];
}

- (void)testDefaultVariantCheckerWithName:(NSString *)name andValue:(NSString *)value withOptionID:(NSNumber *)option_id isValid:(BOOL)valid {
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
	
	if (valid) {
		XCTAssertTrue([product isDefaultVariant]);
	} else {
		XCTAssertFalse([product isDefaultVariant]);
	}
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
