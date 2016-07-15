//
//  BUYModelManager+ApplePay.h
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

@import PassKit;
#import <Buy/BUYModelManager.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYAddress;

@interface BUYModelManager (ApplePay)

/**
 *  Creates a BUYAddress from an ABRecordRef
 *
 *  @param record ABRecordRef to create a BUYAddress from
 *
 *  @return The BUYAddress created from an ABRecordRef
 */
- (BUYAddress *)buyAddressWithABRecord:(ABRecordRef)addressRecord NS_DEPRECATED_IOS(8_0, 9_0, "Use the CNContact backed `buyAddressWithContact:` instead");

/**
 *  Creates a BUYAddress from a PKContact
 *
 *  @param contact PKContact to create a BUYAddress from
 *
 *  @return The BUYAddress created from a PKContact
 */
- (BUYAddress *)buyAddressWithContact:(PKContact *)contact NS_AVAILABLE_IOS(9_0);

@end

NS_ASSUME_NONNULL_END
