//
//  Graph.RetryHandlerTests.swift
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

class Graph_RetryHandlerTests: XCTestCase {
    
    typealias MutationRetryHandler = Graph.RetryHandler<Storefront.Mutation>

    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let handler = self.createHandlerWith(endurance: .infinite)
        
        if case .infinite = handler.endurance {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
        
        XCTAssertEqual(handler.interval,    3.0)
        XCTAssertEqual(handler.repeatCount, 0)
        XCTAssertEqual(handler.canRetry,    true)
    }
    
    func testRepeatCount() {
        var handler = self.createHandlerWith(endurance: .finite(2))
        
        XCTAssertEqual(handler.repeatCount, 0)
        XCTAssertTrue(handler.canRetry)
        
        handler.repeatCount += 1
        
        XCTAssertEqual(handler.repeatCount, 1)
        XCTAssertTrue(handler.canRetry)
        
        handler.repeatCount += 1
        
        XCTAssertEqual(handler.repeatCount, 2)
        XCTAssertFalse(handler.canRetry)
    }
    
    // ----------------------------------
    //  MARK: - Handler Creation -
    //
    private func createHandlerWith(endurance: MutationRetryHandler.Endurance) -> MutationRetryHandler {
        return MutationRetryHandler(endurance: endurance, interval: 3.0) { (mutation, error) -> Bool in
            return true
        }
    }
}
