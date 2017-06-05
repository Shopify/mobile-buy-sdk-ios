//
//  PayShippingRateTests.swift
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
import PassKit
@testable import Pay

class PayShippingRateTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Init -
    //
    func testShippingRateInit() {
        let range = Models.createDeliveryRangeFromSingle().range
        let rate  = PayShippingRate(handle: "abc-123", title: "UPS", price: 15.0, deliveryRange: range)
        
        XCTAssertEqual(rate.handle, "abc-123")
        XCTAssertEqual(rate.title,  "UPS")
        XCTAssertEqual(rate.price,  15.0)
        XCTAssertEqual(rate.deliveryRange!.from, range.from)
        XCTAssertEqual(rate.deliveryRange!.to,   range.to)
    }
    
    // ----------------------------------
    //  MARK: - Delivery Range -
    //
    func testDeliveryRangeSingle() {
        let result = Models.createDeliveryRangeFromSingle()
        let date   = result.orderDate
        let range  = result.range
        
        let description = range.descriptionFrom(date)
        
        XCTAssertNotNil(range.from)
        XCTAssertNil(range.to)
        XCTAssertEqual(description, "1 day")
    }
    
    func testDeliveryRangeMulti() {
        let result = Models.createDeliveryRangeFromMulti()
        let date   = result.orderDate
        let range  = result.range
        
        let description = range.descriptionFrom(date)
        
        XCTAssertNotNil(range.from)
        XCTAssertNil(range.to)
        XCTAssertEqual(description, "2 days")
    }
    
    func testDeliveryRange() {
        let result = Models.createDeliveryRange()
        let date   = result.orderDate
        let range  = result.range
        
        let description = range.descriptionFrom(date)
        
        XCTAssertNotNil(range.from)
        XCTAssertNotNil(range.to)
        XCTAssertEqual(description, "1 - 6 days")
    }
    
    // ----------------------------------
    //  MARK: - PassKit -
    //
    func testSummaryItem() {
        let rate = Models.createShippingRate()
        let item = rate.summaryItem
        
        XCTAssertEqual(item.label,      "UPS Standard")
        XCTAssertEqual(item.amount,     12.0 as NSDecimalNumber)
        XCTAssertEqual(item.identifier, "shipping-rate")
        XCTAssertEqual(item.detail,     "No delivery estimate provided.")
    }
    
    func testSummaryItemWithDeliveryRange() {
        let tomorrow = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 86400)
        let range    = PayShippingRate.DeliveryRange(from: tomorrow)
        let rate     = PayShippingRate(handle: "shipping-rate", title: "UPS Standard", price: 12.0, deliveryRange: range)
        let item     = rate.summaryItem
        
        XCTAssertEqual(item.label,      "UPS Standard")
        XCTAssertEqual(item.amount,     12.0 as NSDecimalNumber)
        XCTAssertEqual(item.identifier, "shipping-rate")
        XCTAssertEqual(item.detail,     "1 day")
    }
    
    func testSummaryItemsCollection() {
        let rates = Models.createShippingRates()
        let items = rates.summaryItems
        
        XCTAssertEqual(items.count, 3)
        XCTAssertEqual(items[0].identifier, rates[0].handle)
        XCTAssertEqual(items[1].identifier, rates[1].handle)
        XCTAssertEqual(items[2].identifier, rates[2].handle)
    }
    
    func testFindShippingRateForMethod() {
        let rates  = Models.createShippingRates()
        let method = Models.createShippingMethod(identifier: "234")
        
        let rate = rates.shippingRateFor(method)
        
        XCTAssertNotNil(rate)
        XCTAssertEqual(rate!.handle, "234")
    }
}
