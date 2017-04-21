//
//  PayCheckoutTests.swift
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

class PayCheckoutTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let discount = Models.createDiscount()
        let address  = Models.createAddress()
        let rate     = Models.createShippingRate()
        let checkout = PayCheckout(
            id: "123",
            lineItems: [
                PayLineItem(price: 10.0, quantity: 1),
                PayLineItem(price: 20.0, quantity: 1),
            ],
            discount:        discount,
            shippingAddress: address,
            shippingRate:    rate,
            subtotalPrice:   30.0,
            needsShipping:   true,
            totalTax:        15.0,
            paymentDue:      35.0
        )
        
        XCTAssertEqual(checkout.id,              "123")
        XCTAssertEqual(checkout.lineItems.count, 2)
        XCTAssertEqual(checkout.shippingAddress!.city, address.city)
        XCTAssertEqual(checkout.shippingRate!.handle,  rate.handle)
        XCTAssertEqual(checkout.discount!.amount, 20.0)
        XCTAssertEqual(checkout.subtotalPrice,    30.0)
        XCTAssertEqual(checkout.needsShipping,    true)
        XCTAssertEqual(checkout.totalTax,         15.0)
        XCTAssertEqual(checkout.paymentDue,       35.0)
    }
    
    // ----------------------------------
    //  MARK: - Summary Items -
    //
    func testSummaryItemsWithTaxes() {
        let checkout     = Models.createCheckout(requiresShipping: false)
        let summaryItems = checkout.summaryItems
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "TAXES")
        XCTAssertEqual(summaryItems[3].label, "TOTAL")
    }
    
    func testSummaryItemsWithShipping() {
        let address      = Models.createAddress()
        let rate         = Models.createShippingRate()
        let checkout     = Models.createCheckout(requiresShipping: true, shippingAddress: address, shippingRate: rate)
        let summaryItems = checkout.summaryItems
        
        XCTAssertEqual(summaryItems.count, 5)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "SHIPPING")
        XCTAssertEqual(summaryItems[3].label, "TAXES")
        XCTAssertEqual(summaryItems[4].label, "TOTAL")
    }
    
    func testSummaryItemsWithoutTax() {
        let checkout     = Models.createCheckout(requiresShipping: false, hasTax: false)
        let summaryItems = checkout.summaryItems
        
        XCTAssertEqual(summaryItems.count, 3)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "TOTAL")
    }
    
    func testSummaryItemsWithDiscount() {
        let discount     = Models.createDiscount()
        let checkout     = Models.createCheckout(requiresShipping: false, discount: discount, empty: true, hasTax: false)
        var summaryItems = checkout.summaryItems
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT (WIN20)")
        XCTAssertEqual(summaryItems[2].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[3].label, "TOTAL")
        
        let anonymousDiscount = Models.createAnonymousDiscount()
        let checkout2         = Models.createCheckout(requiresShipping: false, discount: anonymousDiscount, empty: true, hasTax: false)
        
        summaryItems = checkout2.summaryItems
        
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT")
    }
}
