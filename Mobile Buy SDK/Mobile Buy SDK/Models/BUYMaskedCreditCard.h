//
//  BUYMaskedCreditCard.h
//  Mobile Buy SDK
//
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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
