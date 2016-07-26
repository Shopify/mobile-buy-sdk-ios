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
#import "BUYAssert.h"

NSString * const BUYAccountFirstNameKey            = @"first_name";
NSString * const BUYAccountLastNameKey             = @"last_name";
NSString * const BUYAccountEmailKey                = @"email";
NSString * const BUYAccountPasswordKey             = @"password";

#pragma mark - BUYAccountCredentials -
@interface BUYAccountCredentials()

@property (strong, nonatomic) NSDictionary<NSString *, BUYAccountCredentialItem *> *credentialItems;

@end

@implementation BUYAccountCredentials

#pragma mark - Init -
+ (BUYAccountCredentials *)credentialsWithItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	return [[BUYAccountCredentials alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	self = [super init];
	if (self) {
		
		NSMutableDictionary *container = [NSMutableDictionary new];
		for (BUYAccountCredentialItem *item in items) {
			container[item.key] = item;
		}
		_credentialItems = [container copy];
	}
	return self;
}

#pragma mark - Adding Items -
- (BUYAccountCredentials *)credentialsByAddingItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	NSMutableArray *container = [self.items mutableCopy];
	[container addObjectsFromArray:items];
	return [BUYAccountCredentials credentialsWithItems:container];
}

#pragma mark - Accessors -
- (NSArray<BUYAccountCredentialItem *> *)items
{
	return self.credentialItems.allValues;
}

- (BUYAccountCredentialItem *)credentialItemForKey:(NSString *)key
{
	return _credentialItems[key];
}

- (NSUInteger)count
{
	return self.credentialItems.count;
}

- (BOOL)isValid
{
	__block BOOL valid = YES;
	[self.credentialItems enumerateKeysAndObjectsUsingBlock:^(NSString *key, BUYAccountCredentialItem *item, BOOL * _Nonnull stop) {
		if (!item.isValid) {
			valid = NO;
			*stop = YES;
		}
	}];
	return valid;
}

#pragma mark - Serialization -
- (NSDictionary *)JSONRepresentation
{
	__block NSMutableDictionary *customer = [NSMutableDictionary dictionary];
	[self.credentialItems enumerateKeysAndObjectsUsingBlock:^(NSString *key, BUYAccountCredentialItem *obj, BOOL *stop) {
		customer[key] = obj.value;
	}];
	return @{ @"customer": customer };
}

@end

#pragma mark - BUYAccountCredentialItem -
@implementation BUYAccountCredentialItem

#pragma mark - Init -
+ (instancetype)itemWithEmail:(NSString *)value
{
	return [BUYAccountCredentialItem itemWithKey:BUYAccountEmailKey value:value];
}

+ (instancetype)itemWithFirstName:(NSString *)value
{
	return [BUYAccountCredentialItem itemWithKey:BUYAccountFirstNameKey value:value];
}

+ (instancetype)itemWithLastName:(NSString *)value
{
	return [BUYAccountCredentialItem itemWithKey:BUYAccountLastNameKey value:value];
}

+ (instancetype)itemWithPassword:(NSString *)value
{
	return [BUYAccountCredentialItem itemWithKey:BUYAccountPasswordKey value:value];
}

+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:key value:value];
}

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value
{
	self = [super init];
	if (self) {
		BUYAssert(value, @"Cannot initialize BUYAccountCredentialItem with nil value.");
		
		_key   = key;
		_value = value;
		_valid = value.length > 0;
	}
	return self;
}

@end
