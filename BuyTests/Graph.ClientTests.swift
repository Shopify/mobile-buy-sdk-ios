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
    
    let mockSession = MockSession()
    let shopDomain  = "testshop.myshopify.com"
    let apiKey      = "com.testing.api.key"
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let client = self.defaultClient()
        
        XCTAssertEqual(client.apiURL.absoluteString, "https://\(self.shopDomain)/api/graphql")
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
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"),          "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"),    "application/graphql")
        
        // Ensure that the client inserts defaults headers
        XCTAssertNotNil(request.value(forHTTPHeaderField: "User-Agent"))
        XCTAssertNotNil(request.value(forHTTPHeaderField: "X-Shopify-Storefront-Access-Token"))
    }
    
    // ----------------------------------
    //  MARK: - Queries -
    //
    func testQuerySuccess() {
        let payload = self.defaultQueryPayload()
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseJson = payload.response
            
        }, assertions: { result, error in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        })
    }
    
    func testQueryInvalidResponse() {
        let payload = self.defaultQueryPayload()
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseJson   = nil
            task.isHTTPResponse = false
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .request(_) = error! {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testQueryHTTPError() {
        let payload = self.defaultQueryPayload()
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 400
            task.responseJson = payload.response
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .http(let code) = error!, code == 400 {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testQueryEmptyResponse() {
        let payload = self.defaultQueryPayload()
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseJson = nil
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .noData = error! {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testQueryInvalidData() {
        let payload     = self.defaultQueryPayload()
        let invalidData = "[}".data(using: .utf8)!
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseData = invalidData
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .jsonDeserializationFailed(let data) = error!, data == invalidData {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testQueryInvalidJSON() {
        let payload = self.defaultQueryPayload()
        
        let invalidJson: [String: Any] = [
            "not-data": [
                "value"
            ]
        ]
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseJson = invalidJson
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .invalidJson(let jsonObject) = error! {
                let json = jsonObject as? [String: Any]
                
                XCTAssertNotNil(json)
                XCTAssertEqual(json!["not-data"] as! [String], ["value"])
                
            } else {
                XCTFail()
            }
        })
    }
    
    func testQueryGraphErrors() {
        let payload = self.defaultQueryPayload()
        
        let errorsJson: [String: Any] = [
            "errors": [
                [
                    "line"    : 7,
                    "column"  : 1,
                    "message" : "Error 1",
                ],
                [
                    "line"    : 13,
                    "column"  : 90,
                    "message" : "Error 2",
                ]
            ]
        ]
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseJson = errorsJson
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .invalidQuery(let errors) = error! {
                XCTAssertEqual(errors.count, 2)
                
                XCTAssertEqual(errors[0].line,    7)
                XCTAssertEqual(errors[0].column,  1)
                XCTAssertEqual(errors[0].message, "Error 1")
                
                XCTAssertEqual(errors[1].line,    13)
                XCTAssertEqual(errors[1].column,  90)
                XCTAssertEqual(errors[1].message, "Error 2")
                
            } else {
                XCTFail()
            }
        })
    }
    
    func testQuerySchemaViolation() {
        let payload = self.defaultQueryPayload()
        
        self.testQueryUsing(payload.query, configuration: { task in
            task.responseCode = 200
            task.responseJson = [
                "data": [
                    "shop": [
                        "title": "My Shop"
                    ]
                ]
            ]
            
        }, assertions: { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            
            if case .schemaViolation(let violation) = error!, violation.field == "title" {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    private func testQueryUsing(_ query: Storefront.QueryRootQuery, configuration: (MockDataTask) -> Void, assertions: @escaping (Storefront.QueryRoot?, Graph.QueryError?) -> Void) {
        let e = self.expectation(description: "")
        
        let client  = self.defaultClient()
        let handle  = client.queryGraphWith(query) { result, error in
            assertions(result, error)
            e.fulfill()
        }
        
        configuration(handle.task as! MockDataTask)
        
        handle.resume()
        self.wait(for: [e], timeout: 10)
    }
    
    // ----------------------------------
    //  MARK: - Mutation -
    //
    func testMutation() {
        let payload = self.defaultMutationPayload()
        
        self.testMutationUsing(payload.mutation, configuration: { task in
            task.responseCode = 200
            task.responseJson = payload.response
            
        }, assertions: { result, error in
            XCTAssertNotNil(result)
            XCTAssertNil(error)
        })
    }
    
    private func testMutationUsing(_ mutation: Storefront.MutationQuery, configuration: (MockDataTask) -> Void, assertions: @escaping (Storefront.Mutation?, Graph.QueryError?) -> Void) {
        let e = self.expectation(description: "")
        
        let client  = self.defaultClient()
        let handle  = client.mutateGraphWith(mutation) { result, error in
            assertions(result, error)
            e.fulfill()
        }
        
        configuration(handle.task as! MockDataTask)
        
        handle.resume()
        self.wait(for: [e], timeout: 10)
    }
    
    // ----------------------------------
    //  MARK: - Retry -
    //
    func testRetryHandler() {
        let e = self.expectation(description: "")
        
        let client  = self.defaultClient()
        let payload = self.defaultQueryPayload()
        
        let retryLimit = 3
        var retryCount = 0
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(retryLimit), interval: 0.05) { (result, error) -> Bool in
            retryCount += 1
            print("Retrying...")
            return retryCount < retryLimit
        }
        
        let task = client.queryGraphWith(payload.query, retryHandler: retry) { (result, error) in
            e.fulfill()
        }
        
        task.resume()
        self.wait(for: [e], timeout: 10)
        
        XCTAssertEqual(retryCount, retryLimit)
    }
    
    func testRetryCancel() {
        let e = self.expectation(description: "")
        
        let client  = self.defaultClient()
        let payload = self.defaultQueryPayload()
        
        var retryCount = 0
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(5), interval: 0.05) { (result, error) -> Bool in
            retryCount += 1
            return true
        }
        
        let task = client.queryGraphWith(payload.query, retryHandler: retry) { (result, error) in
            XCTFail()
        }
        
        let initialDataTask = task.task
        
        task.resume()
        DispatchQueue.main.async {
            
            /* ---------------------------------
             ** Ensure that we're cancelling the
             ** new task, not the old one. That's
             ** critical for this test.
             */
            XCTAssertFalse(initialDataTask === task.task)
            task.cancel()
        }
        
        /* ----------------------------------
         ** We have to wait just a bit to see
         ** if the query completes (failing).
         */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            e.fulfill()
        }
        self.wait(for: [e], timeout: 10)
        
        XCTAssertEqual(retryCount, 1)
        XCTAssertFalse(initialDataTask === task.task)
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func defaultClient() -> Graph.Client {
        return Graph.Client(shopDomain: self.shopDomain, apiKey: self.apiKey, session: self.mockSession)
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
