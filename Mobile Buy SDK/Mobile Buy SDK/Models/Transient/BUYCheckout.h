//
//  BUYCheckout.h
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

#import <Buy/_BUYCheckout.h>
#import <Buy/_BUYProductVariant.h>
#import <Buy/BUYModelManager.h>
NS_ASSUME_NONNULL_BEGIN

@class BUYCart, BUYCartLineItem, BUYAddress, BUYGiftCard;

@interface BUYCheckout : _BUYCheckout {}

@property (nonatomic, readonly, copy) NSDate *createdAtDate;
@property (nonatomic, readonly, copy) NSDate *updatedAtDate;
@property (nonatomic, readonly, copy) NSDictionary *attributesDictionary;

@property (nonatomic) BOOL hasToken;

- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager cart:(BUYCart *)cart;
- (instancetype)initWithModelManager:(id<BUYModelManager>)modelManager cartToken:(NSString *)token;

- (NSArray<BUYGiftCard *> *)giftCardsArray;
- (NSArray<BUYCartLineItem *> *)lineItemsArray;

- (void)updateWithCart:(BUYCart *)cart;

- (nullable BUYGiftCard *)giftCardWithIdentifier:(NSNumber *)identifier;
- (void)addGiftCard:(BUYGiftCard *)giftCard;
- (void)removeGiftCardWithIdentifier:(NSNumber *)identifier;

@end

@interface BUYModelManager (BUYCheckoutCreating)

- (BUYCheckout *)checkout;
- (BUYCheckout *)checkoutWithCart:(BUYCart *)cart;
- (BUYCheckout *)checkoutWithVariant:(BUYProductVariant *)productVariant;
- (BUYCheckout *)checkoutwithCartToken:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
