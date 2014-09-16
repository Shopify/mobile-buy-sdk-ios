//
//  CHKCreditCard.h
//  CheckoutAnywhere
//
//  Created by Joshua Tessier on 2014-09-15.
//  Copyright (c) 2014 Shopify Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKCreditCard : NSObject

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
