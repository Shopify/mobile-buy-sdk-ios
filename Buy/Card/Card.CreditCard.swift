//
//  Card.CreditCard.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
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

import Foundation

public extension Card {
    public struct CreditCard {
        
        /// First name as shown on the credit card
        public let firstName: String
        
        /// Middle name as shown on the credit card
        public let middleName: String?
        
        /// Last name as shown on the credit card
        public let lastName: String
        
        /// Credit card number without spaces, only digits
        public let number: String
        
        /// The last two digits of the credit card expiry month (ex: December would be "12" and July would be "7")
        public let expiryMonth: String
        
        /// The last two digits of the credit card expiry year (ex: 2019 would be "19")
        public let expiryYear: String
        
        /// The verification code displayed on the back or the front of the card
        public let verificationCode: String?
        
        // ----------------------------------
        //  MARK: - Init -
        //
        /// Creates and initializes a new credit card for submitting to the vaulting service.
        ///
        /// - parameters:
        ///     - firstName:    First name as shown on the credit card
        ///     - middleName:   Middle name as shown on the credit card
        ///     - lastName:     Last name as shown on the credit card
        ///     - number:       Credit card number without spaces, only digits
        ///     - expiryMonth:  The last two digits of the credit card expiry month (ex: December would be "12" and July would be "7")
        ///     - expiryYear:   The last two digits of the credit card expiry year (ex: 2019 would be "19")
        ///     - verification: The verification code displayed on the back or the front of the card
        ///
        public init(firstName: String, middleName: String? = nil, lastName: String, number: String, expiryMonth: String, expiryYear: String, verificationCode: String? = nil) {
            self.firstName        = firstName
            self.middleName       = middleName
            self.lastName         = lastName
            
            self.number           = number
            self.expiryMonth      = expiryMonth
            self.expiryYear       = expiryYear
            self.verificationCode = verificationCode
        }
        
        // ----------------------------------
        //  MARK: - Dictionary -
        //
        internal func dictionary() -> [String: Any] {
            
            var firstName = self.firstName
            if let middleName = self.middleName {
                firstName = "\(firstName) \(middleName)"
            }
            
            var json: [String : String] = [
                "number"             : self.number,
                "first_name"         : firstName,
                "last_name"          : self.lastName,
                "month"              : self.expiryMonth,
                "year"               : self.expiryYear,
            ]
            
            if let verificationCode = self.verificationCode {
                json["verification_value"] = verificationCode
            }
            
            return [
                "credit_card": json,
            ]
        }
    }
}
