//
//  CryptoTests.swift
//  CryptoTests
//
//  Created by Dima Bart on 2017-06-14.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import XCTest
@testable import Buy

class CryptoTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Hash -
    //
    func testDataHash() {
        let query = "query { shop { name } }".data(using: .utf8)!
        XCTAssertEqual(query.md5, "37d3868e50b398dc12ddd14ba1cec315")
    }
    
    func testStringHash() {
        let query = "query { shop { name } }"
        XCTAssertEqual(query.md5, "37d3868e50b398dc12ddd14ba1cec315")
    }
}
