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

    /// City (eg: "Toronto")
    public let city: String?

    /// Country (eg: "Canada")
    public let country: String?
    
    /// ISO country code (eg: "ca")
    public let countryCode: String?

    /// Province (eg: "ON" or "Ontario")
    public let province: String?

    /// Zip or postal code (eg: "M5V 2J4")
    public let zip: String?
    
    /// True if the zip or postal code has been padded. For example,
    /// if the value passed in was "M5V", this property will return
    /// `true` and `zip` will be "M5V 0Z0"
    public let isPadded: Bool
    
    /// The original, non-padded zip code that was used to create the address
    internal let originalZip: String?

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
        self.countryCode  = countryCode
        self.province     = province
        self.originalZip  = zip
        
        /* -----------------------------------
         ** If we're dealing with postal codes
         ** in Canada or United Kingdom, we are
         ** likely dealing with a partial code.
         ** We'll have to pad it to make it
         ** compatible with Shopify.
         */
        let countryCode = self.countryCode?.lowercased() ?? ""
        if let zip = zip {
            
            let trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedZip.count < 4 {
                let (zip, isPadded) = PayPostalAddress.paddedPostalCode(trimmedZip, for: countryCode)
                self.zip      = zip
                self.isPadded = isPadded
            } else {
                self.zip      = trimmedZip
                self.isPadded = false
            }
            
        } else {
            self.zip      = nil
            self.isPadded = false
        }
    }
    
    // ----------------------------------
    //  MARK: - Postal Code -
    //
    private static func paddedPostalCode(_ postalCode: String, for countryCode: String) -> (postalCode: String, isModified: Bool) {
        switch countryCode {
        case "ca":
            return ("\(postalCode) 0Z0", true)
        
        case "gb":
            return ("\(postalCode) 0ZZ", true)

        default:
            return (postalCode, false)
        }
    }
}

/// Represents a complete address including first name, last name, phone, and email address.
///
public struct PayAddress {

    /// First address line (eg: "Spadina 80")
    public let addressLine1: String?

    /// Second address line (eg: "Suite 400")
    public let addressLine2: String?

    /// City (eg: "Toronto")
    public let city: String?

    /// Country (eg: "Canada")
    public let country: String?

    /// Province (eg: "ON" or "Ontario")
    public let province: String?

    /// Zip or postal code (eg: "M5V 2J4")
    public let zip: String?

    /// First name (eg: "John")
    public let firstName: String?

    /// Last name (eg: "Smith")
    public let lastName: String?

    /// Phone number (eg: "1234567890")
    public let phone: String?

    /// Email address (eg: "john.smith@gmail.com")
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
            countryCode: address.isoCountryCode,
            province:    address.state,
            zip:         address.postalCode
        )
    }
}

internal extension PayAddress {

    init(with contact: PKContact) {
        
        var line1: String?
        var line2: String?
        
        if let address = contact.postalAddress {
            let street = address.street
            if !street.isEmpty {
                let lines  = street.components(separatedBy: .newlines)
                line1      = lines.count > 0 ? lines[0] : nil
                line2      = lines.count > 1 ? lines[1] : nil
            }
        }
        
        self.init(
            addressLine1: line1,
            addressLine2: line2,
            city:         contact.postalAddress?.city,
            country:      contact.postalAddress?.country,
            province:     contact.postalAddress?.state,
            zip:          contact.postalAddress?.postalCode,
            firstName:    contact.name?.givenName,
            lastName:     contact.name?.familyName,
            phone:        contact.phoneNumber?.stringValue,
            email:        contact.emailAddress
        )
    }
}
