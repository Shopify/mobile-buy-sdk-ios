//
//  BUYAccountCredentials.m
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

#import "BUYAccountCredentials.h"

@class BUYAccountCredentialItem;
@interface BUYAccountCredentials()
@property (strong, nonatomic) NSMutableDictionary<NSString *, BUYAccountCredentialItem *> *items;
@end

@implementation BUYAccountCredentials

+ (BUYAccountCredentials *)credentialsWithItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	BUYAccountCredentials *credentials = [BUYAccountCredentials new];
	NSMutableDictionary *keyedItems = [NSMutableDictionary dictionary];
	for (BUYAccountCredentialItem *item in items) {
		keyedItems[item.key] = item;
	}
	credentials.items = keyedItems;
	return credentials;
}

+ (BUYAccountCredentials *)credentialsWithItemKeys:(NSArray<NSString *> *)keys
{
	NSMutableArray *items = [NSMutableArray array];
	for (NSString *key in keys) {
		BUYAccountCredentialItem *item = [BUYAccountCredentialItem itemWithKey:key value:@""];
		[items addObject:item];
	}
	return [BUYAccountCredentials credentialsWithItems:items];
}

- (NSDictionary *)JSONRepresentation
{
	__block NSMutableDictionary *customer = [NSMutableDictionary dictionary];
	[self.items enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, BUYAccountCredentialItem * _Nonnull obj, BOOL * _Nonnull stop) {
		customer[key] = obj.value;
	}];
	return @{ @"customer": customer };
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError
{
	return [self.items[inKey] validateValue:ioValue forKey:inKey error:outError];
}

- (BUYAccountCredentialItem *)objectForKeyedSubscript:(NSString *)key
{
	return self.items[key];
}

- (void)setObject:(BUYAccountCredentialItem *)obj forKeyedSubscript:(NSString *)key
{
	self.items[key] = obj;
}

- (BOOL)validationForKey:(NSString *)key
{
	return [self.items[key] isValid];
}

- (BOOL)isValid
{
	__block BOOL valid = YES;
	[self.items enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, BUYAccountCredentialItem * _Nonnull obj, BOOL * _Nonnull stop) {
		valid = valid && [obj isValid];
	}];
	return valid;
}

@end

@implementation BUYAccountCredentialItem

+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value
{
	BUYAccountCredentialItem *item = [BUYAccountCredentialItem new];
	item.key = key;
	item.value = value;
	return item;
}

- (NSString *)value
{
	return _value ?: @"";
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError * _Nullable __autoreleasing *)outError
{
	self.value = *ioValue;
	self.valid = self.value.length > 0;
	return [self isValid];
}

@end
