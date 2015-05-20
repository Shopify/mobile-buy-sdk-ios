//
//  BUYCreditCard.h
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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
