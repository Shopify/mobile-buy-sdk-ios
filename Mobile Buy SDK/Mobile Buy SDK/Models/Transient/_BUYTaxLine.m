//
//  _BUYTaxLine.h
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
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BUYTaxLine.m instead.

#import "_BUYTaxLine.h"

const struct BUYTaxLineAttributes BUYTaxLineAttributes = {
	.createdAt = @"createdAt",
	.price = @"price",
	.rate = @"rate",
	.title = @"title",
	.updatedAt = @"updatedAt",
};

const struct BUYTaxLineRelationships BUYTaxLineRelationships = {
	.checkout = @"checkout",
};

const struct BUYTaxLineUserInfo BUYTaxLineUserInfo = {
	.Transient = @"YES",
	.documentation = @"BUYTaxLine represents a single tax line on a checkout. Use this to display an itemized list of taxes that a customer is being charged for.",
};

@implementation _BUYTaxLine

+ (NSString *)entityName {
	return @"TaxLine";
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@end

#pragma mark -

@implementation BUYModelManager (BUYTaxLineInserting)

- (BUYTaxLine *)insertTaxLineWithJSONDictionary:(NSDictionary *)dictionary
{
    return (BUYTaxLine *)[self buy_objectWithEntityName:@"TaxLine" JSONDictionary:dictionary];
}

- (NSArray<BUYTaxLine *> *)insertTaxLinesWithJSONArray:(NSArray <NSDictionary *> *)array
{
    return (NSArray<BUYTaxLine *> *)[self buy_objectsWithEntityName:@"TaxLine" JSONArray:array];
}

- (NSArray<BUYTaxLine *> *)allTaxLineObjects
{
    return (NSArray<BUYTaxLine *> *)[self buy_objectsWithEntityName:@"TaxLine" identifiers:nil];
}

- (BUYTaxLine *)fetchTaxLineWithIdentifierValue:(int64_t)identifier
{
    return (BUYTaxLine *)[self buy_objectWithEntityName:@"TaxLine" identifier:@(identifier)];
}

@end
