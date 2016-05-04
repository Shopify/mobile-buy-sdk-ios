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

NSString * const BUYAccountFirstNameKey            = @"first_name";
NSString * const BUYAccountLastNameKey             = @"last_name";
NSString * const BUYAccountEmailKey                = @"email";
NSString * const BUYAccountPasswordKey             = @"password";
NSString * const BUYAccountPasswordConfirmationKey = @"password_confirmation";

#pragma mark - BUYAccountCredentials -
@interface BUYAccountCredentials()

@property (strong, nonatomic) NSMutableDictionary<NSString *, BUYAccountCredentialItem *> *items;

@end

@implementation BUYAccountCredentials

+ (BUYAccountCredentials *)credentialsWithItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	return [[BUYAccountCredentials alloc] initWithItems:items];
}

- (instancetype)initWithItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	self = [super init];
	if (self) {
		
		_items = [NSMutableDictionary new];
		if (items.count > 0) {
			[self setCredentialItems:items];
		}
	}
	return self;
}

#pragma mark - Accessors -
- (BOOL)isValid
{
	__block BOOL valid = YES;
	[self.items enumerateKeysAndObjectsUsingBlock:^(NSString *key, BUYAccountCredentialItem *item, BOOL * _Nonnull stop) {
		if (!item.isValid) {
			valid = NO;
			*stop = YES;
		}
	}];
	return valid;
}

- (void)setCredentialItems:(NSArray<BUYAccountCredentialItem *> *)items
{
	NSAssert(items, @"BUYAccountCredentialItem array cannot be nil.");
	for (BUYAccountCredentialItem *item in items) {
		[self setCredentialItem:item];
	}
}

- (void)setCredentialItem:(BUYAccountCredentialItem *)item
{
	NSAssert(item, @"BUYAccountCredentialItem cannot be nil.");
	self.items[item.key] = item;
}

#pragma mark - Serialization -
- (NSDictionary *)JSONRepresentation
{
	__block NSMutableDictionary *customer = [NSMutableDictionary dictionary];
	[self.items enumerateKeysAndObjectsUsingBlock:^(NSString *key, BUYAccountCredentialItem *obj, BOOL *stop) {
		customer[key] = obj.value;
	}];
	return @{ @"customer": customer };
}

@end

#pragma mark - BUYAccountCredentialItem -
@implementation BUYAccountCredentialItem

#pragma mark - Init -
+ (instancetype)itemEmailWithValue:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:BUYAccountEmailKey value:value];
}

+ (instancetype)itemFirstNameWithValue:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:BUYAccountFirstNameKey value:value];
}

+ (instancetype)itemLastNameWithValue:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:BUYAccountLastNameKey value:value];
}

+ (instancetype)itemPasswordWithValue:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:BUYAccountPasswordKey value:value];
}

+ (instancetype)itemPasswordConfirmationWithValue:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:BUYAccountPasswordConfirmationKey value:value];
}

+ (instancetype)itemWithKey:(NSString *)key value:(NSString *)value
{
	return [[BUYAccountCredentialItem alloc] initWithKey:key value:value];
}

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value
{
	self = [super init];
	if (self) {
		NSAssert(value, @"Cannot initialize BUYAccountCredentialItem with nil value.");
		
		_key   = key;
		_value = value;
		_valid = value.length > 0;
	}
	return self;
}

@end
