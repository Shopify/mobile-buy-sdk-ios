//
//  Card.ClientTests.swift
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

class Card_ClientTests: XCTestCase {

    let mockSession = MockSession()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let session = URLSession(configuration: .default)
        let client  = Card.Client(session: session)
        
        XCTAssertTrue(client.session === session)
    }
    
    // ----------------------------------
    //  MARK: - Requests -
    //
    func testRequestGeneration() {
        let card    = self.defaultCreditCard()
        let client  = self.defaultClient()
        let url     = self.defaultURL()
        let request = client.requestFor(card, to: url)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: card.dictionary(), options: [])
        
        XCTAssertEqual(request.url, url)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.httpBody, jsonData)
        XCTAssertFalse(request.httpShouldHandleCookies)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"),       "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
    
    // ----------------------------------
    //  MARK: - Vaulting -
    //
    func testVaultSuccess() {
        let card     = self.defaultCreditCard()
        let response = [
            "id": "token-123"
        ]
        
        let responseData = try! JSONSerialization.data(withJSONObject: response, options: [])
        
        self.testVaultUsing(card, configuration: { task in
            task.responseCode = 200
            task.responseData = responseData
        }, assertions: { token, error in
            XCTAssertEqual(token, "token-123")
            XCTAssertNil(error)
        })
    }
    
    func testVaultEmptyData() {
        let card = self.defaultCreditCard()
        
        self.testVaultUsing(card, configuration: { task in
            task.responseCode  = 200
            task.responseData  = nil
            task.responseError = ("No data", 890)
            
        }, assertions: { token, error in
            XCTAssertNil(token)
            XCTAssertNotNil(error)
            
            let vaultError = error! as NSError
            XCTAssertEqual(vaultError.domain, "No data")
            XCTAssertEqual(vaultError.code,   890)
        })
    }
    
    func testVaultInvalidJson() {
        let card = self.defaultCreditCard()
        
        self.testVaultUsing(card, configuration: { task in
            task.responseCode  = 200
            task.responseData  = "abc".data(using: .utf8)
            task.responseError = ("Invalid json", 400)
            
        }, assertions: { token, error in
            XCTAssertNil(token)
            XCTAssertNotNil(error)
            
            let vaultError = error! as NSError
            XCTAssertEqual(vaultError.domain, NSCocoaErrorDomain)
            XCTAssertEqual(vaultError.code,   3840)
        })
    }
    
    private func testVaultUsing(_ card: Card.CreditCard, configuration: (MockDataTask) -> Void, assertions: @escaping (String?, Error?) -> Void) {
        let e = self.expectation(description: "")
        
        let client  = self.defaultClient()
        let url     = self.defaultURL()
        let task    = client.vault(card, to: url) { token, error in
            assertions(token, error)
            e.fulfill()
        }
        
        configuration(task as! MockDataTask)
        
        task.resume()
        self.wait(for: [e], timeout: 10)
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func defaultURL() -> URL {
        return URL(string: "https://www.google.com")!
    }
    
    private func defaultClient() -> Card.Client {
        return Card.Client(session: self.mockSession)
    }
    
    private func defaultCreditCard() -> Card.CreditCard {
        return Card.CreditCard(
            firstName:        "John",
            lastName:         "Smith",
            number:           "1234567812345678",
            expiryMonth:      "07",
            expiryYear:       "19",
            verificationCode: "1234"
        )
    }
}
