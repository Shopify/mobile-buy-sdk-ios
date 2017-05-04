//
//  DigestTests.swift
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

class DigestTests: XCTestCase {

    // ----------------------------------
    //  MARK: - Digest -
    //
    func testDigest() {
        let query = "query { shop { name } }"
        let bytes = Digest.md5(query.data(using: .utf8)!)
        
        XCTAssertEqual(bytes[0], 55)
        XCTAssertEqual(bytes[1], 211)
        XCTAssertEqual(bytes[2], 134)
        XCTAssertEqual(bytes[3], 142)
        XCTAssertEqual(bytes[4], 80)
        XCTAssertEqual(bytes[5], 179)
        XCTAssertEqual(bytes[6], 152)
        XCTAssertEqual(bytes[7], 220)
        XCTAssertEqual(bytes[8], 18)
        XCTAssertEqual(bytes[9], 221)
        XCTAssertEqual(bytes[10], 209)
        XCTAssertEqual(bytes[11], 75)
        XCTAssertEqual(bytes[12], 161)
        XCTAssertEqual(bytes[13], 206)
        XCTAssertEqual(bytes[14], 195)
        XCTAssertEqual(bytes[15], 21)
    }
    
    // ----------------------------------
    //  MARK: - Hex -
    //
    func testHex() {
        let hex = "f687ae568e"
        let bytes: [UInt8] = [
            0xf6,
            0x87,
            0xae,
            0x56,
            0x8e,
        ]
        
        XCTAssertEqual(bytes.hex, hex)
    }
    
    // ----------------------------------
    //  MARK: - Extensions -
    //
    func testStringExtensions() {
        let query = "query { shop { name } }"
        
        XCTAssertEqual(query.md5, "37d3868e50b398dc12ddd14ba1cec315")
    }
}
