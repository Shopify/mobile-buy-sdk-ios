//
//  PayAuthorizationTests.swift
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

#if canImport(PassKit)

import XCTest
@testable import Pay

@available(iOS 11.0, *)
class PayAuthorizationTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let paymentData   = "123".data(using: .utf8)!
        let address       = Models.createAddress()
        let rate          = Models.createShippingRate()
        let authorization = PayAuthorization(
            paymentData:     paymentData,
            billingAddress:  address,
            shippingAddress: address,
            shippingRate:    rate
        )
        
        XCTAssertEqual(authorization.token, "123")
        XCTAssertEqual(authorization.billingAddress.firstName,  address.firstName)
        XCTAssertEqual(authorization.shippingAddress.firstName, address.firstName)
        XCTAssertEqual(authorization.shippingRate!.handle,      rate.handle)
    }
}

#endif
