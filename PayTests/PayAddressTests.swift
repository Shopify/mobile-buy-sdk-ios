//
//  PayAddressTests.swift
//  PayTests
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

import XCTest
@testable import Pay

#if canImport(PassKit)
import PassKit
#endif

@available(iOS 11.0, *)
class PayAddressTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInitPostalAddress() {
        let address = PayPostalAddress(
            city:        "Brooklyn",
            country:     "United States",
            countryCode: "US",
            province:    "NY",
            zip:         "11217"
        )
        
        XCTAssertEqual(address.city,        "Brooklyn")
        XCTAssertEqual(address.country,     "United States")
        XCTAssertEqual(address.province,    "NY")
        XCTAssertEqual(address.zip,         "11217")
        XCTAssertEqual(address.originalZip, "11217")
        XCTAssertEqual(address.isPadded,    false)
    }
    
    func testInitPostalAddressInUnitedStates() {
        let address = PayPostalAddress(
            city:        "Brooklyn",
            country:     "United States",
            countryCode: "US",
            province:    "NY",
            zip:         "112"
        )
        
        XCTAssertEqual(address.city,        "Brooklyn")
        XCTAssertEqual(address.country,     "United States")
        XCTAssertEqual(address.province,    "NY")
        XCTAssertEqual(address.zip,         "112")
        XCTAssertEqual(address.originalZip, "112")
        XCTAssertEqual(address.isPadded,    false)
    }
    
    func testInitPartialPostalAddressInCanada() {
        let address = PayPostalAddress(
            city:        "Toronto",
            country:     "Canada",
            countryCode: "CA",
            province:    "ON",
            zip:         "L5S "
        )
        
        XCTAssertEqual(address.city,        "Toronto")
        XCTAssertEqual(address.country,     "Canada")
        XCTAssertEqual(address.province,    "ON")
        XCTAssertEqual(address.zip,         "L5S 0Z0")
        XCTAssertEqual(address.originalZip, "L5S ")
        XCTAssertEqual(address.isPadded,    true)
    }
    
    func testInitPartialPostalAddressInUnitedKingdom() {
        let address = PayPostalAddress(
            city:        "London",
            country:     "United Kingdom",
            countryCode: "gb",
            province:    "ON",
            zip:         "W1A"
        )
        
        XCTAssertEqual(address.city,        "London")
        XCTAssertEqual(address.country,     "United Kingdom")
        XCTAssertEqual(address.province,    "ON")
        XCTAssertEqual(address.zip,         "W1A 0ZZ")
        XCTAssertEqual(address.originalZip, "W1A")
        XCTAssertEqual(address.isPadded,    true)
    }
    
    func testInitEmptyZipAddress() {
        let address = PayPostalAddress(
            city:        "London",
            country:     "United Kingdom",
            countryCode: nil,
            province:    "ON",
            zip:         nil
        )
        
        XCTAssertEqual(address.city,        "London")
        XCTAssertEqual(address.country,     "United Kingdom")
        XCTAssertEqual(address.province,    "ON")
        XCTAssertEqual(address.zip,         nil)
        XCTAssertEqual(address.originalZip, nil)
        XCTAssertEqual(address.isPadded,    false)
    }
    
    func testInitAddress() {
        let address = PayAddress(
            addressLine1: "123 Lakeshore Blvd.",
            addressLine2: "Unit 9876",
            city:         "Toronto",
            country:      "Canada",
            province:     "ON",
            zip:          "A1B 2C3",
            firstName:    "John",
            lastName:     "Smith",
            phone:        "1-123-456-7890",
            email:        "john.smith@gmail.com"
        )
        
        XCTAssertEqual(address.addressLine1, "123 Lakeshore Blvd.")
        XCTAssertEqual(address.addressLine2, "Unit 9876")
        XCTAssertEqual(address.city,         "Toronto")
        XCTAssertEqual(address.country,      "Canada")
        XCTAssertEqual(address.province,     "ON")
        XCTAssertEqual(address.zip,          "A1B 2C3")
        XCTAssertEqual(address.firstName,    "John")
        XCTAssertEqual(address.lastName,     "Smith")
        XCTAssertEqual(address.phone,        "1-123-456-7890")
        XCTAssertEqual(address.email,        "john.smith@gmail.com")
    }
    
    #if canImport(PassKit)
    
    // ----------------------------------
    //  MARK: - CNPostalAddress -
    //
    func testInitFromPassKitAddress() {
        let passKitAddress = Models.createPostalAddress()
        let address        = PayPostalAddress(with: passKitAddress)
        
        XCTAssertEqual(address.city,        "Toronto")
        XCTAssertEqual(address.country,     "Canada")
        XCTAssertEqual(address.province,    "ON")
        XCTAssertEqual(address.zip,         "M5V 2J4")
        XCTAssertEqual(address.originalZip, "M5V 2J4")
        XCTAssertEqual(address.isPadded,    false)
    }
    
    // ----------------------------------
    //  MARK: - PKContact -
    //
    func testInitFromPassKitContact() {
        let contact       = Models.createContact()
        let postalAddress = contact.postalAddress!.mutableCopy() as! CNMutablePostalAddress
        let address       = PayAddress(with: contact)
        
        XCTAssertEqual(address.addressLine1, "80 Spadina")
        XCTAssertEqual(address.addressLine2, nil)
        XCTAssertEqual(address.city,         "Toronto")
        XCTAssertEqual(address.country,      "Canada")
        XCTAssertEqual(address.province,     "ON")
        XCTAssertEqual(address.zip,          "M5V 2J4")
        XCTAssertEqual(address.firstName,    "John")
        XCTAssertEqual(address.lastName,     "Smith")
        XCTAssertEqual(address.phone,        "1234567890")
        XCTAssertEqual(address.email,        "john.smith@gmail.com")
        
        postalAddress.street  = "123 Lakeshore Blvd\nUnit 987"
        contact.postalAddress = postalAddress
        
        let address2 = PayAddress(with: contact)
        
        XCTAssertEqual(address2.addressLine1, "123 Lakeshore Blvd")
        XCTAssertEqual(address2.addressLine2, "Unit 987")
        
        postalAddress.street  = ""
        contact.postalAddress = postalAddress
        
        let address3 = PayAddress(with: contact)
        
        XCTAssertEqual(address3.addressLine1, nil)
        XCTAssertEqual(address3.addressLine2, nil)
    }
    
    #endif
}
