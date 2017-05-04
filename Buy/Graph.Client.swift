//
//  Graph.Client.swift
//  Buy
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

import Foundation

internal typealias JSON = [String : Any]

private struct Header {
    static var userAgent     = "User-Agent"
    static var accept        = "Accept"
    static var contentType   = "Content-Type"
    static var authorization = "X-Shopify-Storefront-Access-Token"
    static var sdkVersion    = "X-SDK-Version"
    static var sdkVariant    = "X-SDK-Variant"
}

extension Graph {
    
    /// A completion handler for GraphQL `query` requests.
    ///
    /// - parameters:
    ///     - query: A typed response model that will contain fields that match exactly the fields requested. Accessing a field that wasn't initially queried will raise a `fatalError`.
    ///     - error: An error encountered during the request.
    ///
    /// - Important:
    /// `query` and `error` are **not** mutually exclusive. In other words, it is valid for a request to return both a non-nil `query` and `error`. In this case, the `error` generally represents an issue with only a subset of the query.
    ///
    public typealias QueryCompletion = (_ query: Storefront.QueryRoot?, _ error: QueryError?) -> Void
    
    /// A completion handler for GraphQL `mutation` requests.
    ///
    /// - parameters:
    ///     - mutation: A typed response model that will contain fields that match exactly the fields requested. Accessing a field that wasn't initially queried will raise a `fatalError`.
    ///     - error:    An error encountered during the request.
    ///
    /// - Important:
    /// `mutation` and `error` are **not** mutually exclusive. In other words, it is valid for a request to return both a non-nil `mutation` and `error`. In this case, the `error` generally represents an issue with only a subset of the query.
    ///
    public typealias MutationCompletion = (_ mutation: Storefront.Mutation?, _ error: QueryError?) -> Void
    
    /// The `Client` is a network layer designed to abstract the communication with the Shopify GraphQL endpoint
    /// by handling the serialization and deserialization of GraphQL models for `query` and `mutation` requests.
    /// In addition, the `Client` will take care of appending the necessary headers for authorizing the network
    /// requests based on the provided `shopDomain` and `apiKey`.
    ///
    public class Client {
        
        /// The `URLSession` backing all `Client` network operations. You may provide your own session when initializing a new `Client`.
        public let session:  URLSession
        
        internal let apiURL:  URL
        internal let headers: [String : String]
        
        // ----------------------------------
        //  MARK: - Init -
        //
        /// Creates and initialized a new `Client`.
        ///
        /// - parameters:
        ///     - shopDomain: The domain of your shop (ex: "shopname.myshopify.com").
        ///     - apiKey:     The API key for you app, obtained from the Shopify admin.
        ///     - session:    A `URLSession` to use for this client. If left blank, a session with a `default` configuration will be created.
        ///
        public init(shopDomain: String, apiKey: String, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
            
            let shopURL  = Client.urlFor(shopDomain)
            self.apiURL  = Client.urlFor(shopDomain, path: "/api/graphql")
            self.session = session
            self.headers = [
                Header.userAgent     : Global.userAgent,
                Header.authorization : apiKey,
                Header.sdkVersion    : Global.frameworkVersion,
                Header.sdkVariant    : "ios",
            ]
            
            precondition(!apiKey.isEmpty, "API Key is required to the Buy SDK. You can obtain one by adding a Mobile App channel here: \(shopURL.appendingPathComponent("admin"))")
        }
        
        static func urlFor(_ shopDomain: String, path: String = "") -> URL {
            var components    = URLComponents()
            components.scheme = "https"
            components.host   = shopDomain
            components.path   = path
            
            return components.url!
        }

        // ----------------------------------
        //  MARK: - Queries -
        //
        /// Performs a GraphQL `query` request.
        ///
        /// - parameters:
        ///     - query:             A GraphQL query to execute, represented by a `QueryRootQuery` object.
        ///     - retryHandler:      An optional handler for subsequently retrying or polling. There are several Shopify resources that require polling until `resource.ready == true`. If provided, the `retryHandler` is executed for every response to access whether a request should continue retrying. The `completionHandler` won't be executed until the `retryHandler.condition` evaluates to `false`.
        ///     - completionHandler: A handler that will be executed after a failed or successful query request.
        
        /// - returns:
        /// A reference to a `Task` representing this query operation.
        ///
        /// - Important:
        /// The returned task is always in a `suspended` state. You must call `resume` to start the task:
        /// ````
        /// task.resume()
        /// ````
        ///
        public func queryGraphWith(_ query: Storefront.QueryRootQuery, retryHandler: RetryHandler<Storefront.QueryRoot>? = nil, completionHandler: @escaping QueryCompletion) -> Task {
            return self.graphRequestTask(query: query, retryHandler: retryHandler, completionHandler: completionHandler)
        }
        
        // ----------------------------------
        //  MARK: - Mutations -
        //
        /// Performs a GraphQL `mutation` request.
        ///
        /// - parameters:
        ///     - mutation:          A GraphQL mutation to execute, represented by a `MutationQuery` object.
        ///     - retryHandler:      An optional handler for subsequently retrying or polling. There are several Shopify resources that require polling until `resource.ready == true`. If provided, the `retryHandler` is executed for every response to access whether a request should continue retrying. The `completionHandler` won't be executed until the `retryHandler.condition` evaluates to `false`.
        ///     - completionHandler: A handler that will be executed after a failed or successful query request.
        
        /// - returns:
        /// A reference to a `Task` representing this mutation operation.
        ///
        /// - Important:
        /// The returned task is always in a `suspended` state. You must call `resume` to start the task:
        /// ````
        /// task.resume()
        /// ````
        ///
        public func mutateGraphWith(_ mutation: Storefront.MutationQuery, retryHandler: RetryHandler<Storefront.Mutation>? = nil, completionHandler: @escaping MutationCompletion) -> Task {
            return self.graphRequestTask(query: mutation, retryHandler: retryHandler, completionHandler: completionHandler)
        }
        
        // ----------------------------------
        //  MARK: - Request Management -
        //
        private func graphRequestTask<Q: GraphQL.AbstractQuery, R: GraphQL.AbstractResponse>(query: Q, retryHandler: RetryHandler<R>? = nil, completionHandler: @escaping (R?, QueryError?) -> Void) -> Task {
            
            var task: Task!
            
            let request  = self.graphRequestFor(query: query)
            let dataTask = self.session.graphTask(with: request) { (response: R?, error: QueryError?) in
                DispatchQueue.main.async {
                    
                    if var retryHandler = retryHandler, retryHandler.canRetry, retryHandler.condition(response, error) == true {
                        
                        /* ---------------------------------
                         ** A retry handler was provided and
                         ** the condition evaluated to true,
                         ** we have to retry the request.
                         */
                        retryHandler.repeatCount += 1
                        
                        let retryTask = self.graphRequestTask(query: query, retryHandler: retryHandler, completionHandler: completionHandler)
                        task.setTask(retryTask.task)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + retryHandler.interval) {
                            if task.task.state == .suspended {
                                task.resume()
                            }
                        }
                        
                    } else {
                        completionHandler(response, error)
                    }
                }
            }
            
            task = Task(representing: dataTask)
            return task
        }
        
        func graphRequestFor(query: GraphQL.AbstractQuery) -> URLRequest {
            var request = URLRequest(url: self.apiURL)
            
            request.httpMethod = "POST"
            request.httpBody = String(describing: query).data(using: .utf8)
            request.httpShouldHandleCookies = false
            request.setValue("application/json", forHTTPHeaderField: Header.accept)
            request.setValue("application/graphql", forHTTPHeaderField: Header.contentType)
            
            for (name, value) in self.headers {
                request.setValue(value, forHTTPHeaderField: name)
            }
            
            return request
        }
    }
}

// ----------------------------------
//  MARK: - URLRequest Hash -
//
extension URLRequest {
    
    var hash: Graph.Hash {
        precondition(self.httpBody != nil, "URLRequest requires a non-empty HTTP body to calculate cache key.")
        return self.httpBody!.md5
    }
}

// ----------------------------------
//  MARK: - Graph Data Task -
//
private extension URLSession {
    
    func graphTask<R: GraphQL.AbstractResponse>(with request: URLRequest, completionHandler: @escaping (R?, Graph.QueryError?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { json, error in
            
            if let json = json {
                
                do {
                    completionHandler(try R(fields: json), error)
                } catch let error {
                    completionHandler(nil, Graph.QueryError.schemaViolation(violation: error as! SchemaViolationError))
                }
                
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (JSON?, Graph.QueryError?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, error == nil else {
                completionHandler(nil, .request(error: error))
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, .http(statusCode: response.statusCode))
                return
            }
            
            guard let data = data else {
                completionHandler(nil, .noData)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                completionHandler(nil, .jsonDeserializationFailed(data: data))
                return
            }
            
            let graphResponse = json as? JSON
            let graphErrors   = graphResponse?["errors"] as? [JSON]
            let graphData     = graphResponse?["data"]   as? JSON
            
            /* ----------------------------------
             ** This should never happen. A valid
             ** GraphQL response will have either
             ** data or errors.
             */
            guard graphData != nil || graphErrors != nil else {
                completionHandler(nil, .invalidJson(json: json))
                return
            }
            
            /* ---------------------------------
             ** Extract any GraphQL errors found
             ** during execution of the query.
             */
            var queryError: Graph.QueryError?
            if let graphErrors = graphErrors {
                queryError = .invalidQuery(reasons: graphErrors.map {
                    Graph.QueryError.Reason(json: $0)
                })
            }
            
            completionHandler(graphData, queryError)
        }
    }
}
