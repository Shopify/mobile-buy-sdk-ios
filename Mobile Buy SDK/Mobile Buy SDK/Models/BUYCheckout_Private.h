//
//  BUYCheckout_Private.h
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

#import "BUYCheckout.h"

@interface BUYCheckout ()

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *cartToken;
@property (nonatomic, copy) NSNumber *orderId;
@property (nonatomic, assign) BOOL requiresShipping;
@property (nonatomic, assign) BOOL taxesIncluded;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, strong) NSString *paymentSessionId;
@property (nonatomic, strong) NSNumber *reservationTimeLeft;
@property (nonatomic, strong) NSDecimalNumber *paymentDue;
@property (nonatomic, strong) NSURL *webCheckoutURL;
@property (nonatomic, strong) NSURL *paymentURL;
@property (nonatomic, strong) NSDecimalNumber *subtotalPrice;
@property (nonatomic, strong) NSDecimalNumber *totalTax;
@property (nonatomic, strong) NSDecimalNumber *totalPrice;
@property (nonatomic, strong) NSURL *orderStatusURL;
@property (nonatomic, strong) NSArray *giftCards;
@property (nonatomic, copy) NSDate *createdAtDate;
@property (nonatomic, copy) NSDate *updatedAtDate;
@property (nonatomic, strong) BUYMaskedCreditCard *creditCard;
@property (nonatomic, strong) BUYOrder *order;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, strong) NSURL *privacyPolicyURL;
@property (nonatomic, strong) NSURL *refundPolicyURL;
@property (nonatomic, strong) NSURL *termsOfServiceURL;
@property (nonatomic, copy) NSString *sourceName;
@property (nonatomic, copy) NSString *sourceIdentifier;
@end
