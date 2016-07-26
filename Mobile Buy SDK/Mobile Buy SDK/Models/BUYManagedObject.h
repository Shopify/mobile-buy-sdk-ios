//
//  BUYManagedObject.h
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

#import <CoreData/CoreData.h>
#import <Buy/BUYObject.h>
NS_ASSUME_NONNULL_BEGIN

#if defined CORE_DATA_PERSISTENCE

#define BUYCachedObject BUYManagedObject

/**
 *  This is the base class for all Shopify persistent model objects.
 *  This class takes care of convertion .json responses into
 *  the associated subclass.
 *
 *  You will generally not need to interact with this class directly.
 */

@interface BUYManagedObject : NSManagedObject<BUYObject>

- (instancetype)init NS_UNAVAILABLE;

@end

#else

#define BUYCachedObject BUYObject

/**
 * Key-value coding API defined in NSManagedObject which is used by mogenerator generated accessors.
 * When persistence is not implemented, will/didAccess do nothing; primitive KVC maps to normal KVC.
 */
@interface BUYObject (BUYManagedObjectConformance)

- (void)willAccessValueForKey:(NSString *)key;
- (void)didAccessValueForKey:(NSString *)key;

@end
#endif

NS_ASSUME_NONNULL_END
