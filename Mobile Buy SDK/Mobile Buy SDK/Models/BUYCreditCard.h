//
//  BUYCreditCard.h
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

@import Foundation;
#import "BUYSerializable.h"

/**
 *  This represents raw credit card data that the user is posting. You MUST discard this object as soon as it has been posted
 *  to Shopify's secure environment.
 */
@interface BUYCreditCard : NSObject <BUYSerializable>

/**
 *  The full name on the credit card
 *  First and Last in this format: 'First Last'.
 */
@property (nonatomic, copy) NSString *nameOnCard;

/**
 *  The full credit card number.
 *  This should be a numerical value without spaces, dashes or any other special characters.
 */
@property (nonatomic, copy) NSString *number;

/**
 *  The month that the credit card expires, as a numerical value (i.e. 12 for December).
 */
@property (nonatomic, copy) NSString *expiryMonth;

/**
 *  The last two digits of the year in which the credit card expires (i.e. 18 for 2018).
 */
@property (nonatomic, copy) NSString *expiryYear;

/**
 *  The Card Verification Value number (or whichever card security code should be used for the card type).
 */
@property (nonatomic, copy) NSString *cvv;

@end
