//
//  BUYFlatCollectionTransformer.m
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

#import "BUYFlatCollectionTransformer.h"
#import "BUYIdentityTransformer.h"

#import "NSArray+BUYAdditions.h"

@interface BUYFlatCollectionTransformer ()
@property (nonatomic, weak) Class collectionClass;
@property (nonatomic, strong) NSValueTransformer *elementTransformer;
@property (nonatomic, strong) NSString *separator;
@end

@implementation BUYFlatCollectionTransformer

+ (instancetype)collectionTransformerWithClass:(Class)klass elementTransformer:(NSValueTransformer *)elementTransformer separator:(NSString *)separator
{
	BUYFlatCollectionTransformer *transformer = [[BUYFlatCollectionTransformer alloc] init];
	transformer.collectionClass = klass;
	transformer.separator = separator;
	transformer.elementTransformer = elementTransformer;
	return transformer;
}

+ (instancetype)arrayTransformerWithElementTransformer:(NSValueTransformer *)elementTransformer separator:(NSString *)separator
{
	return [self collectionTransformerWithClass:[NSArray class] elementTransformer:elementTransformer separator:separator];
}

+ (instancetype)arrayTransformer
{
	return [self arrayTransformerWithElementTransformer:[[BUYIdentityTransformer alloc] init] separator:@" "];
}

+ (instancetype)arrayTransformerWithSeparator:(NSString *)separator
{
	return [self arrayTransformerWithElementTransformer:[[BUYIdentityTransformer alloc] init] separator:separator];
}

+ (instancetype)setTransformerWithElementTransformer:(NSValueTransformer *)elementTransformer separator:(NSString *)separator
{
	return [self collectionTransformerWithClass:[NSSet class] elementTransformer:elementTransformer separator:separator];
}

+ (instancetype)setTransformerWithSeparator:(NSString *)separator
{
	return [self setTransformerWithElementTransformer:[[BUYIdentityTransformer alloc] init] separator:separator];
}

+ (instancetype)setTransformer
{
	return [self setTransformerWithSeparator:@" "];
}

+ (instancetype)orderedSetTransformerWithElementTransformer:(NSValueTransformer *)elementTransformer separator:(NSString *)separator
{
	return [self collectionTransformerWithClass:[NSOrderedSet class] elementTransformer:elementTransformer separator:separator];
}

+ (instancetype)orderedSetTransformerWithSeparator:(NSString *)separator
{
	return [self orderedSetTransformerWithElementTransformer:[[BUYIdentityTransformer alloc] init] separator:separator];
}

+ (Class)transformedValueClass
{
	return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

- (NSString *)transformedValue:(id)value
{
	return [[[value buy_array] buy_map:^(id element) {
		return [_elementTransformer transformedValue:element];
	}] componentsJoinedByString:self.separator];
}

- (id)reverseTransformedValue:(NSString *)value
{
	NSArray *array = [[value componentsSeparatedByString:self.separator] buy_map:^(NSString *string) {
		return [_elementTransformer reverseTransformedValue:string];
	}];
	return [_collectionClass buy_convertArray:array];
}

@end
