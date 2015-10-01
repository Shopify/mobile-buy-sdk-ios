//
//  BUYRuntime.m
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

#import "BUYObject.h"
#import "BUYRuntime.h"
#import <objc/runtime.h>

NSSet* __attribute__((overloadable)) class_getBUYProperties(Class clazz, BOOL includeSuper)
{
	if (clazz == [NSObject class]) {
		return [[NSSet alloc] init];
	}
	else {
		NSMutableSet *propertyNames = [[NSMutableSet alloc] init];
		unsigned int outCount = 0;
		objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
		
		for (unsigned int i = 0; i < outCount; ++i) {
			objc_property_t property = properties[i];
			const char *propertyName = property_getName(property);
			if (propertyName != NULL) {
				[propertyNames addObject:@(propertyName)];
			}
		}
		
		free(properties);
		
		if (includeSuper) {
			Class superClass = class_getSuperclass(clazz);
			if (superClass) {
				[propertyNames unionSet:class_getBUYProperties(superClass)];
			}
		}
		return [propertyNames copy];
	}
}

NSSet* __attribute__((overloadable)) class_getBUYProperties(Class clazz)
{
	return class_getBUYProperties(clazz, YES);
}
