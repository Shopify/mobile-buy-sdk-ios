//
//  GraphQL.AbstractQueryTests.swift
//  BuyTests
//
//  Created by Shopify.
//  Copyright (c) 2021 Shopify Inc. All rights reserved.
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

class GraphQL_AbstractQueryTests: XCTestCase {
    
    func testQuery() {
        XCTAssertEqual(String(describing: RootQuery()), "query {shop{name,name__a:name}}")
    }
    
    func testQueryWithDirectives() {
        let query = RootQuery()
        query.directives = []
        XCTAssertEqual(String(describing: query), "query {shop{name,name__a:name}}")
        query.directives = [TestDirective(), TestDirectiveWithArgs()]
        XCTAssertEqual(String(describing: query), "query @test @testArgs(input: \"hello\") {shop{name,name__a:name}}")
    }
    
    private class RootQuery: GraphQL.AbstractQuery {
        override var description: String {
            return "query " + super.description
        }
        
        override init() {
            super.init()
            addField(field: "shop", subfields: ShopQuery())
        }
    }

    private class ShopQuery: GraphQL.AbstractQuery {
        override init() {
            super.init()
            addField(field: "name")
            addField(field: "name", aliasSuffix: "a")
        }
    }
    
    private class TestDirective: GraphQL.AbstractDirective {
        init() {
            super.init(name: "test")
        }
    }
    
    private class TestDirectiveWithArgs: GraphQL.AbstractDirective {
        init() {
            super.init(name: "testArgs", args: "(input: \"hello\")")
        }
    }
}
