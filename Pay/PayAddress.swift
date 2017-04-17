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

public struct PayPostalAddress {
    
    public let city:         String?
    public let country:      String?
    public let province:     String?
    public let zip:          String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(city: String? = nil,
         country:     String? = nil,
         countryCode: String? = nil,
         province:    String? = nil,
         zip:         String? = nil) {
        
        self.city         = city
        self.country      = country
        self.province     = province
        self.zip          = zip
    }
}

public struct PayAddress {
    
    public let addressLine1: String?
    public let addressLine2: String?
    public let city:         String?
    public let country:      String?
    public let province:     String?
    public let zip:          String?
    
    public let firstName:    String?
    public let lastName:     String?
    public let phone:        String?
    public let email:        String?
    
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
        let lines = contact.postalAddress!.street.components(separatedBy: .newlines)
        self.init(
            addressLine1: lines.count > 0 ? lines[0] : nil,
            addressLine2: lines.count > 1 ? lines[1] : nil,
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
