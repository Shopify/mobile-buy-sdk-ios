//
//  SHA256Tests.swift
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

class SHA256Tests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Hash -
    //
    func testDataHash() {
        let query = "query { shop { name } }".data(using: .utf8)!
        let hash  = SHA256.hash(query)
        
        XCTAssertEqual(hash, "81f5f157cf9744055c946cfd72c69557fe806a282991a9bcf7ba00ba70575dad")
    }
    
    func testStringHash() {
        let query = "query { shop { name } }"
        let hash  = SHA256.hash(query)
        
        XCTAssertEqual(hash, "81f5f157cf9744055c946cfd72c69557fe806a282991a9bcf7ba00ba70575dad")
    }
}
