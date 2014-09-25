//
//  CHKCreditCard.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

@import Foundation;

#import "CHKSerializable.h"

/**
 * This represents raw credit card data that the user is posting. You **must** discard this object as soon as it has been posted
 * to Shopify's secure environment.
 */
@interface CHKCreditCard : NSObject <CHKSerializable>

/**
 * The full name on the credit card (First & Last in this format 'First Last').
 */
@property (nonatomic, copy) NSString *nameOnCard;

/**
 * The full credit card number. This should be a numerical value without spaces, dashes or any other special characters.
 */
@property (nonatomic, copy) NSString *number;

/**
 * The month that the credit card expires, as a numerical value (i.e. 12 for December).
 */
@property (nonatomic, copy) NSString *expiryMonth;

/**
 * The last two digits of the year in which the credit card expires (i.e. 2018 -> 18).
 */
@property (nonatomic, copy) NSString *expiryYear;

/**
 * The card verification value (or whichever card security code should be used for the card type).
 */
@property (nonatomic, copy) NSString *cvv;

@end
