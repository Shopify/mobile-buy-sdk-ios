//
//  Card.CreditCardTests.swift
//  BuyTests
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
@testable import Buy

class Card_CreditCardTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Init -
    //
    func testInitComplete() {
        let card = self.creditCard()
        
        XCTAssertEqual(card.firstName,        "John")
        XCTAssertEqual(card.middleName,       "Singleton")
        XCTAssertEqual(card.lastName,         "Smith")
        XCTAssertEqual(card.number,           "1234567812345678")
        XCTAssertEqual(card.expiryMonth,      "07")
        XCTAssertEqual(card.expiryYear,       "19")
        XCTAssertEqual(card.verificationCode, "1234")
    }
    
    func testInitPartial() {
        let card = self.partialCreditCard()
        
        XCTAssertNil(card.middleName)
        XCTAssertNil(card.verificationCode)
    }
    
    // ----------------------------------
    //  MARK: - Serialization -
    //
    func testSerializationComplete() {
        let card       = self.creditCard()
        let dictionary = card.dictionary()
        
        XCTAssertEqual(dictionary.count, 1)
        
        let creditCard = dictionary["credit_card"] as! JSON
        
        XCTAssertEqual(creditCard.count, 6)
        XCTAssertEqual(creditCard["number"]             as! String, "1234567812345678")
        XCTAssertEqual(creditCard["first_name"]         as! String, "John Singleton")
        XCTAssertEqual(creditCard["last_name"]          as! String, "Smith")
        XCTAssertEqual(creditCard["month"]              as! String, "07")
        XCTAssertEqual(creditCard["year"]               as! String, "19")
        XCTAssertEqual(creditCard["verification_value"] as! String, "1234")
    }
    
    func testSerializationPartial() {
        let card       = self.partialCreditCard()
        let dictionary = card.dictionary()
        
        XCTAssertEqual(dictionary.count, 1)
        
        let creditCard = dictionary["credit_card"] as! JSON
        
        XCTAssertEqual(creditCard.count, 5)
        XCTAssertEqual(creditCard["number"]     as! String, "1234567812345678")
        XCTAssertEqual(creditCard["first_name"] as! String, "John")
        XCTAssertEqual(creditCard["last_name"]  as! String, "Smith")
        XCTAssertEqual(creditCard["month"]      as! String, "07")
        XCTAssertEqual(creditCard["year"]       as! String, "19")
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func creditCard() -> Card.CreditCard {
        return Card.CreditCard(
            firstName:        "John",
            middleName:       "Singleton",
            lastName:         "Smith",
            number:           "1234567812345678",
            expiryMonth:      "07",
            expiryYear:       "19",
            verificationCode: "1234"
        )
    }
    
    private func partialCreditCard() -> Card.CreditCard {
        return Card.CreditCard(
            firstName:        "John",
            lastName:         "Smith",
            number:           "1234567812345678",
            expiryMonth:      "07",
            expiryYear:       "19"
        )
    }
}
