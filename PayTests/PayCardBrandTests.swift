//
//  PayCardBrandTests.swift
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

class PayCardBrandTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Init -
    //
    func testValues() {
        XCTAssertEqual(PayCardBrand.visa.rawValue,            "VISA")
        XCTAssertEqual(PayCardBrand.masterCard.rawValue,      "MASTERCARD")
        XCTAssertEqual(PayCardBrand.discover.rawValue,        "DISCOVER")
        XCTAssertEqual(PayCardBrand.americanExpress.rawValue, "AMERICAN_EXPRESS")
        XCTAssertEqual(PayCardBrand.dinersClub.rawValue,      "DINERS_CLUB")
        XCTAssertEqual(PayCardBrand.jcb.rawValue,             "JCB")
    }
    
    // ----------------------------------
    //  MARK: - Conversion -
    //
    func testPaymentNetworkConversion() {
        XCTAssertEqual(PayCardBrand.visa.paymentNetwork,            .visa)
        XCTAssertEqual(PayCardBrand.masterCard.paymentNetwork,      .masterCard)
        XCTAssertEqual(PayCardBrand.discover.paymentNetwork,        .discover)
        XCTAssertEqual(PayCardBrand.americanExpress.paymentNetwork, .amex)
        XCTAssertEqual(PayCardBrand.dinersClub.paymentNetwork,      nil)
        XCTAssertEqual(PayCardBrand.jcb.paymentNetwork,             .JCB)
    }
    
    func testNetworksConversion() {
        let cardBrands: [PayCardBrand] = [
            .visa,
            .masterCard,
        ]
        
        let networks = cardBrands.paymentNetworks
        
        XCTAssertEqual(networks.count, 2)
        XCTAssertEqual(networks[0], .visa)
        XCTAssertEqual(networks[1], .masterCard)
    }
}
