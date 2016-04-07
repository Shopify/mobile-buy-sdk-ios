//
//  NSDictionary+BUYAdditions.m
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

#import "NSDictionary+BUYAdditions.h"
#import "NSString+BUYAdditions.h"

@implementation NSDictionary (BUYAdditions)

- (NSDictionary<NSString *, NSString *> *)buy_reverseDictionary
{
	return [NSDictionary dictionaryWithObjects:self.allKeys forKeys:self.allValues];
}

- (NSDictionary *)buy_dictionaryByMappingKeysWithBlock:(BUYStringMap)map
{
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	[self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		result[(map(key) ?: key)] = self[key];
	}];
	return result;
}

- (NSDictionary *)buy_dictionaryByMappingValuesWithBlock:(BUYObjectMap)map
{
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	[self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
		id newValue = map(self[key]);
		result[key] = newValue;
	}];
	return result;
}

- (id)buy_objectForKey:(NSString *)key
{
	return ([self[key] isKindOfClass:[NSNull class]]) ? nil : self[key];
}

- (NSDictionary *)jsonDictionaryForCheckout
{
	return self;
}

@end
