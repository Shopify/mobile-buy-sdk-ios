//
//  Graph.CachePolicyTests.swift
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

class Graph_CachePolicyTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Equality -
    //
    func testEquality() {
        XCTAssertEqual(Graph.CachePolicy.cacheOnly,                  Graph.CachePolicy.cacheOnly)
        XCTAssertEqual(Graph.CachePolicy.networkOnly,                Graph.CachePolicy.networkOnly)
        XCTAssertEqual(Graph.CachePolicy.cacheFirst(expireIn: 10),   Graph.CachePolicy.cacheFirst(expireIn: 10))
        XCTAssertEqual(Graph.CachePolicy.networkFirst(expireIn: 10), Graph.CachePolicy.networkFirst(expireIn: 10))
        
        XCTAssertNotEqual(Graph.CachePolicy.cacheFirst(expireIn: 10),   Graph.CachePolicy.cacheFirst(expireIn: 15))
        XCTAssertNotEqual(Graph.CachePolicy.networkFirst(expireIn: 10), Graph.CachePolicy.networkFirst(expireIn: 15))
    }
}
