//
//  CryptoTests.swift
//  CryptoTests
//
//  Created by Dima Bart on 2017-06-14.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import XCTest
import Crypto

class CryptoTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Hash -
    //
    func testDataHash() {
        let query = "query { shop { name } }".data(using: .utf8)!
        let hash  = (query as NSData).md5()
        
        XCTAssertEqual(hash, "37d3868e50b398dc12ddd14ba1cec315")
    }
    
    func testStringHash() {
        let query = "query { shop { name } }"
        let hash  = query.md5()
        
        XCTAssertEqual(hash, "37d3868e50b398dc12ddd14ba1cec315")
    }
}
