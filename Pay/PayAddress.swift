//
//  PayAddress.swift
//  Pay
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
import PassKit

/// Represents a partial address without street information.
///
public struct PayPostalAddress {
    
    /// City (ex: "Toronto")
    public let city: String?
    
    /// Country (ex: "Canada")
    public let country: String?
    
    /// Province (ex: "ON" or "Ontario")
    public let province: String?
    
    /// Zip or postal code (ex: "M5V 2J4")
    public let zip: String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(city: String? = nil,
         country:     String? = nil,
         province:    String? = nil,
         zip:         String? = nil) {
        
        self.city         = city
        self.country      = country
        self.province     = province
        self.zip          = zip
    }
}

/// Represents a complete address including first name, last name, phone and email address.
///
public struct PayAddress {
    
    /// First address line (ex: "Spadina 80")
    public let addressLine1: String?
    
    /// Second address line (ex: "Suite 400")
    public let addressLine2: String?
    
    /// City (ex: "Toronto")
    public let city: String?
    
    /// Country (ex: "Canada")
    public let country: String?
    
    /// Province (ex: "ON" or "Ontario")
    public let province: String?
    
    /// Zip or postal code (ex: "M5V 2J4")
    public let zip: String?
    
    /// First name (ex: "John")
    public let firstName: String?
    
    /// Last name (ex: "Smith")
    public let lastName: String?
    
    /// Phone number (ex: "1234567890")
    public let phone: String?
    
    /// Email address (ex: "john.smith@gmail.com")
    public let email: String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(addressLine1: String? = nil,
        addressLine2: String? = nil,
        city:         String? = nil,
        country:      String? = nil,
        province:     String? = nil,
        zip:          String? = nil,
        
        firstName:    String? = nil,
        lastName:     String? = nil,
        phone:        String? = nil,
        email:        String? = nil) {
        
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
        self.city         = city
        self.country      = country
        self.province     = province
        self.zip          = zip
        
        self.firstName    = firstName
        self.lastName     = lastName
        self.phone        = phone
        self.email        = email
    }
}

// ----------------------------------
//  MARK: - PassKit -
//
internal extension PayPostalAddress {
    
    init(with address: CNPostalAddress) {
        self.init(
            city:        address.city,
            country:     address.country,
            province:    address.state,
            zip:         address.postalCode
        )
    }
}

internal extension PayAddress {
    
    init(with contact: PKContact) {
        let street = contact.postalAddress!.street
        let lines  = street.components(separatedBy: .newlines)
        self.init(
            addressLine1: !street.isEmpty && lines.count > 0 ? lines[0] : nil,
            addressLine2: !street.isEmpty && lines.count > 1 ? lines[1] : nil,
            city:         contact.postalAddress!.city,
            country:      contact.postalAddress!.country,
            province:     contact.postalAddress!.state,
            zip:          contact.postalAddress!.postalCode,
            firstName:    contact.name?.givenName,
            lastName:     contact.name?.familyName,
            phone:        contact.phoneNumber?.stringValue,
            email:        contact.emailAddress
        )
    }
}
