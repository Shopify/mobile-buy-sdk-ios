//
//  PayLineItemTests.swift
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

class PayLineItemTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let item = PayLineItem(price: 10.0, quantity: 2)
        
        XCTAssertEqual(item.price, 10.0)
        XCTAssertEqual(item.quantity, 2)
    }
    
    // ----------------------------------
    //  MARK: - Collection Total -
    //
    func testCollectionTotalPrice() {
        let items = [
            PayLineItem(price: 10.0, quantity: 1),
            PayLineItem(price:  5.0, quantity: 5),
            PayLineItem(price: 12.0, quantity: 3),
            PayLineItem(price: 10.0, quantity: 0),
        ]
        
        XCTAssertEqual(items.totalPrice, 71.0)
    }
}
