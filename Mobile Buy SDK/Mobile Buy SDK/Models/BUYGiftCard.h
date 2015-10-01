//
//  BUYGiftCard.h
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
#import "BUYSerializable.h"

@interface BUYGiftCard : BUYObject <BUYSerializable>

/**
 *  The gift card code. This is only used when applying a gift card and 
 *  is not visible on a BUYCheckout object synced with Shopify.
 */
@property (nonatomic, readonly, copy) NSString *code;

/**
 *  The last characters of the applied gift card code.
 */
@property (nonatomic, readonly, copy) NSString *lastCharacters;

/**
 *  The amount left on the gift card after being applied to this checkout.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *balance;

/**
 *  The amount of the gift card used by this checkout.
 */
@property (nonatomic, readonly, strong) NSDecimalNumber *amountUsed;

@end
