//
//  Graph.ClientTests.swift
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

class Graph_ClientTests: XCTestCase {
    
    let shopDomain  = "testshop.myshopify.com"
    let apiKey      = "com.testing.api.key"
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let client = self.defaultClient()
        
        XCTAssertEqual(client.apiURL.absoluteString, "https://\(self.shopDomain)/api/graphql")
        XCTAssertEqual(client.cachePolicy, .networkOnly)
    }
    
    func testDomainGeneration() {
        let domain = "www.google.com"
        let path   = "/some/task"
        
        let url    = Graph.Client.urlFor(domain, path: path)
        
        XCTAssertEqual(url, URL(string: "https://www.google.com/some/task"))
    }
    
    func testInitialHeaders() {
        let client = self.defaultClient()
        
        XCTAssertEqual(client.headers.count, 4)
        XCTAssertEqual(client.headers["User-Agent"],    Global.userAgent)
        XCTAssertEqual(client.headers["X-SDK-Version"], Global.frameworkVersion)
        XCTAssertEqual(client.headers["X-SDK-Variant"], "ios")
        XCTAssertEqual(client.headers["X-Shopify-Storefront-Access-Token"], self.apiKey)
    }
    
    // ----------------------------------
    //  MARK: - Requests -
    //
    func testRequestGeneration() {
        let client  = self.defaultClient()
        let request = client.graphRequestFor(query: self.defaultQueryPayload().query)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertTrue(request.httpBody?.count ?? 0 > 0)
        XCTAssertFalse(request.httpShouldHandleCookies)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"),       "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/graphql")
        XCTAssertEqual(request.value(forHTTPHeaderField: "X-Query-Tag"),  MD5.hash(request.httpBody!))
        
        // Ensure that the client inserts defaults headers
        XCTAssertNotNil(request.value(forHTTPHeaderField: "User-Agent"))
        XCTAssertNotNil(request.value(forHTTPHeaderField: "X-Shopify-Storefront-Access-Token"))
    }
    
    // ----------------------------------
    //  MARK: - Queries -
    //
    func testQuery() {
        let client  = self.defaultClient()
        let payload = self.defaultQueryPayload()
        let request = client.graphRequestFor(query: payload.query)
        
        let task = client.queryGraphWith(payload.query, cachePolicy: .networkFirst(expireIn: 20)) { query, error in } as! Graph.InternalTask<Storefront.QueryRoot>
        
        XCTAssertTrue(task.session === client.session)
        XCTAssertTrue(task.cache   === client.cache)
        XCTAssertEqual(task.request, request)
        XCTAssertEqual(task.cachePolicy, .networkFirst(expireIn: 20))
        XCTAssertNil(task.retryHandler)
    }
    
    func testDefaultClientCachePolicyForQuery() {
        let client         = self.defaultClient()
        client.cachePolicy = .cacheOnly
        
        let payload = self.defaultQueryPayload()
        let task    = client.queryGraphWith(payload.query) { query, error in } as! Graph.InternalTask<Storefront.QueryRoot>
        
        XCTAssertEqual(task.cachePolicy, .cacheOnly)
    }
    
    func testMutation() {
        let client  = self.defaultClient()
        let payload = self.defaultMutationPayload()
        let request = client.graphRequestFor(query: payload.mutation)
        
        let task = client.mutateGraphWith(payload.mutation) { query, error in
            
        } as! Graph.InternalTask<Storefront.Mutation>
        
        XCTAssertTrue(task.session === client.session)
        XCTAssertTrue(task.cache   === client.cache)
        XCTAssertEqual(task.request, request)
        XCTAssertEqual(task.cachePolicy, .networkOnly)
        XCTAssertNil(task.retryHandler)
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func defaultClient() -> Graph.Client {
        return Graph.Client(shopDomain: self.shopDomain, apiKey: self.apiKey, session: MockSession())
    }
    
    private func defaultQueryPayload() -> (query: Storefront.QueryRootQuery, response: [String: Any]) {
        let query = Storefront.buildQuery { $0
            .shop { $0
                .name()
            }
        }
        
        let response = [
            "data": [
                "shop": [
                    "name": "My Shop"
                ]
            ]
        ]
        
        return (query, response)
    }
    
    private func defaultMutationPayload() -> (mutation: Storefront.MutationQuery, response: [String: Any]) {
        
        let mutation = Storefront.buildMutation { $0
            .checkoutEmailUpdate(checkoutId: GraphQL.ID(rawValue: "123"), email: "john.smith@gmail.com") { $0
                .userErrors { $0
                    .message()
                }
            }
        }
        
        let response = [
            "data": [
                "checkoutEmailUpdate": [
                    "userErrors": []
                ]
            ]
        ]
        
        return (mutation, response)
    }
}
