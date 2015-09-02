//
//  BUYMaskedCreditCard.h
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

#import <Buy/Buy.h>

/**
 *  This represents a masked credit card that has been applied to a checkout.
 */
@interface BUYMaskedCreditCard : BUYObject

/**
 *  The first name on the credit card
 */
@property (nonatomic, copy) NSString *firstName;

/**
 *  The last name on the credit card
 */
@property (nonatomic, copy) NSString *lastName;

/**
 *  The first digits of credit card number.
 */
@property (nonatomic, copy) NSString *firstDigits;

/**
 *  The last digits of credit card number.
 */
@property (nonatomic, copy) NSString *lastDigits;

/**
 *  The year the card expires
 */
@property (nonatomic, copy) NSNumber *expiryYear;

/**
 *  The two digits representing the month the card expires
 */
@property (nonatomic, copy) NSNumber *expiryMonth;

@end
