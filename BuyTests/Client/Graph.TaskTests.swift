//
//  Graph.TaskTests.swift
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

class Graph_TaskTests: XCTestCase {
    
    let cache = Graph.Cache()
    let url   = URL(string: "https://www.google.com")!
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let session = MockSession()
        let cache   = Graph.Cache()
        let payload = self.defaultQueryPayload()
        let request = self.defaultRequest(for: payload.query)
        let retry   = Graph.RetryHandler<Storefront.QueryRoot> { query, error in
            return error != nil
        }
        
        let completion: (Storefront.QueryRoot?, Graph.QueryError?) -> Void = { query, error in
            
        }
        
        let task = Graph.InternalTask<Storefront.QueryRoot>(
            session:      session,
            cache:        cache,
            request:      request,
            cachePolicy:  .networkOnly,
            retryHandler: retry,
            completion:   completion
        )
        
        XCTAssertTrue(task.session === session)
        XCTAssertTrue(task.cache   === cache)
        XCTAssertEqual(task.request, request)
        XCTAssertNotNil(task.retryHandler)
        XCTAssertNotNil(task.completion)
    }
    
    // ----------------------------------
    //  MARK: - Network Requests -
    //
    func testNetworkOnlySuccess() {
        self.cache.purge()
        
        let e1 = self.expectation(description: "Data task started")
        let e2 = self.expectation(description: "Task completion")
        
        let payload     = self.defaultQueryPayload()
        let task        = self.defaultTask(query: payload.query, cachePolicy: .networkOnly, configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 200
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    func testNetworkOnlyError() {
        self.cache.purge()
        
        let e1 = self.expectation(description: "Data task started")
        let e2 = self.expectation(description: "Task completion")
        
        let payload     = self.defaultQueryPayload()
        let task        = self.defaultTask(query: payload.query, cachePolicy: .networkOnly, configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 400
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNil(item)
            XCTAssertNil(query)
            XCTAssertNotNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    func testCacheOnly() {
        self.cache.purge()
        
        let payload = self.defaultQueryPayload()
        let e1      = self.expectation(description: "Task completion")
        
        self.cacheQuery(payload, timestampDelta: 30.0)
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .cacheOnly, configuration: { mock in
            
            XCTFail() // Should not start a network task
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e1.fulfill()
        })
        
        task.resume()
        
        XCTAssertNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1], timeout: 10)
    }
    
    func testCacheFirstValid() {
        self.cache.purge()
        
        let payload = self.defaultQueryPayload()
        let e1      = self.expectation(description: "Task completion")
        
        self.cacheQuery(payload, timestampDelta: 30.0)
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .cacheFirst(expireIn: 30), configuration: { mock in
            
            XCTFail() // Should not start a network task
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e1.fulfill()
        })
        
        task.resume()
        
        XCTAssertNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1], timeout: 10)
    }
    
    func testCacheFirstExpired() {
        self.cache.purge()
        
        let payload = self.defaultQueryPayload()
        let e1      = self.expectation(description: "Data task started")
        let e2      = self.expectation(description: "Task completion")
        
        self.cacheQuery(payload, timestampDelta: -60.0)
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .cacheFirst(expireIn: 30), configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 200
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    func testNetworkFirstSuccess() {
        self.cache.purge()
        
        let e1 = self.expectation(description: "Data task started")
        let e2 = self.expectation(description: "Task completion")
        
        let payload = self.defaultQueryPayload()
        let task    = self.defaultTask(query: payload.query, cachePolicy: .networkFirst(expireIn: 30), configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 200
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    func testNetworkFirstErrorValidCache() {
        self.cache.purge()
        
        let payload = self.defaultQueryPayload()
        let e1      = self.expectation(description: "Data task started")
        let e2      = self.expectation(description: "Task completion")
        
        self.cacheQuery(payload, timestampDelta: 30)
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .networkFirst(expireIn: 30), configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 400
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNotNil(item)
            XCTAssertNotNil(query)
            XCTAssertNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    func testNetworkFirstErrorExpiredCache() {
        self.cache.purge()
        
        let payload = self.defaultQueryPayload()
        let e1      = self.expectation(description: "Data task started")
        let e2      = self.expectation(description: "Task completion")
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .networkFirst(expireIn: 30), configuration: { mock in
            
            mock.responseJson = payload.response
            mock.responseCode = 400
            e1.fulfill()
            
        }, completion: { request, query, error in
            
            let item = self.cache.item(for: request.hash)
            XCTAssertNil(item)
            XCTAssertNil(query)
            XCTAssertNotNil(error)
            
            e2.fulfill()
        })
        
        task.resume()
        
        XCTAssertNotNil(task.task)
        XCTAssertTrue(task.isResumed)
        
        self.wait(for: [e1, e2], timeout: 10)
    }
    
    // ----------------------------------
    //  MARK: - Errors -
    //
    func testRequestError() {
        self.assertTaskWith(configuration: { mock in
            mock.isHTTPResponse = false
            
        }, errorHandler: { error in
            if case .request = error {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testStatusError() {
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 403
            
        }, errorHandler: { error in
            if case .http(let code) = error {
                XCTAssertEqual(code, 403)
            } else {
                XCTFail()
            }
        })
    }
    
    func testEmptyError() {
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 200
            mock.responseData = nil
            
        }, errorHandler: { error in
            if case .noData = error {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testJsonDeserializationError() {
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 200
            mock.responseData = "abc".data(using: .utf8)
            
        }, errorHandler: { error in
            if case .jsonDeserializationFailed = error {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    func testInvalidJsonError() {
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 200
            mock.responseData = "{}".data(using: .utf8)
            
        }, errorHandler: { error in
            if case .invalidJson(let json) = error {
                XCTAssertNotNil(json)
            } else {
                XCTFail()
            }
        })
    }
    
    func testInvalidQueryError() {
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
        
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 200
            mock.responseJson = errorsJson
            
        }, errorHandler: { error in
            if case .invalidQuery(let reasons) = error {
                XCTAssertEqual(reasons.count, 2)
                
                XCTAssertEqual(reasons[0].line,    7)
                XCTAssertEqual(reasons[0].column,  1)
                XCTAssertEqual(reasons[0].message, "Error 1")
                
                XCTAssertEqual(reasons[1].line,    13)
                XCTAssertEqual(reasons[1].column,  90)
                XCTAssertEqual(reasons[1].message, "Error 2")
            } else {
                XCTFail()
            }
        })
    }
    
    func testSchemaViolationError() {
        self.assertTaskWith(configuration: { mock in
            mock.responseCode = 200
            mock.responseJson = [
                "data": [
                    "shop": [
                        "title": "My Shop"
                    ]
                ]
            ]
            
        }, errorHandler: { error in
            if case .schemaViolation(let violation) = error, violation.field == "title" {
                XCTAssertTrue(true)
            } else {
                XCTFail()
            }
        })
    }
    
    private func assertTaskWith(configuration: @escaping MockSession.TaskConfigurationHandler, errorHandler: @escaping (Graph.QueryError) -> Void) {
        let e = self.expectation(description: "")
        
        let payload = self.defaultQueryPayload()
        let task    = self.defaultTask(query: payload.query, cachePolicy: .networkOnly, configuration: configuration, completion: { request, query, error in
            
            XCTAssertNil(query)
            XCTAssertNotNil(error)
            
            errorHandler(error!)
            
            e.fulfill()
        })
        
        task.resume()
        self.wait(for: [e], timeout: 5)
    }
    
    // ----------------------------------
    //  MARK: - Cache Policy -
    //
    func testForceCachePolicyWithRetry() {
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .infinite) { (result, error) -> Bool in
            return true
        }
        
        let payload = self.defaultQueryPayload()
        let task    = self.defaultTask(query: payload.query, cachePolicy: .cacheOnly, retryHandler: retry, configuration: { mock in
            // No configuration
        }, completion: { request, query, error in
            // No asserts
        })
        
        /* ---------------------------------
         ** Any non-nil retry handler should
         ** default to a .networkOnly cache
         ** policy.
         */
        XCTAssertEqual(task.cachePolicy, .networkOnly)
    }
    
    // ----------------------------------
    //  MARK: - Retry -
    //
    func testRetryHandler() {
        let e = self.expectation(description: "")
        
        let payload = self.defaultQueryPayload()
        
        let retryLimit = 3
        var retryCount = 0
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(retryLimit), interval: 0.05) { (result, error) -> Bool in
            retryCount += 1
            Log("Retrying...")
            return retryCount < retryLimit
        }
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .networkOnly, retryHandler: retry, configuration: { mock in
            // No configuration
        }, completion: { request, query, error in
            e.fulfill()
        })
        
        task.resume()
        self.wait(for: [e], timeout: 10)
        
        XCTAssertEqual(retryCount, retryLimit)
    }
    
    func testRetryCancel() {
        let e = self.expectation(description: "")
        
        let payload = self.defaultQueryPayload()
        
        var retryCount = 0
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(5), interval: 0.05) { (result, error) -> Bool in
            retryCount += 1
            return true
        }
        
        let task = self.defaultTask(query: payload.query, cachePolicy: .networkOnly, retryHandler: retry, configuration: { mock in
            // No configuration
        }, completion: { request, query, error in
            XCTFail()
        })
        
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
    //  MARK: - Cache -
    //
    private func cacheQuery(_ payload: (query: Storefront.QueryRootQuery, response: [String: Any]), timestampDelta: Double) {
        let request = self.defaultRequest(for: payload.query)
        let data    = try! JSONSerialization.data(withJSONObject: payload.response, options: [])
        let now     = Date().timeIntervalSince1970
        
        self.cache.set(.init(hash: request.hash, data: data, timestamp: now + timestampDelta))
    }
    
    // ----------------------------------
    //  MARK: - Private -
    //
    private func defaultClient() -> Graph.Client {
        return Graph.Client(shopDomain: "shop.domain.com", apiKey: "api-key", session: MockSession())
    }
    
    private func defaultRequest(for query: GraphQL.AbstractQuery) -> URLRequest {
        let client  = Graph.Client(shopDomain: "shop.myshopify.com", apiKey: "api-key")
        let request = client.graphRequestFor(query: query)
        
        return request
    }
    
    private func defaultTask(query: GraphQL.AbstractQuery, cachePolicy: Graph.CachePolicy, retryHandler: Graph.RetryHandler<Storefront.QueryRoot>? = nil, configuration: @escaping MockSession.TaskConfigurationHandler, completion: @escaping (URLRequest, Storefront.QueryRoot?, Graph.QueryError?) -> Void) -> Graph.InternalTask<Storefront.QueryRoot> {
        
        let request                  = self.defaultRequest(for: query)
        let session                  = MockSession()
        session.configurationHandler = configuration
        
        return Graph.InternalTask<Storefront.QueryRoot>(
            session:      session,
            cache:        self.cache,
            request:      request,
            cachePolicy:  cachePolicy,
            retryHandler: retryHandler,
            completion: { query, error in
                completion(request, query, error)
            }
        )
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
