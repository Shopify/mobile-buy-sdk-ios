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
    ///     - mutation: A typed response model that will contain fields that match the fields requested. Accessing a field that wasn't initially queried will raise a `fatalError`.
    ///     - error:    An error encountered during the request.
    ///
    /// - Important:
    /// `mutation` and `error` are **not** mutually exclusive. In other words, it is valid for a request to return both a non-nil `mutation` and `error`. In this case, the `error` generally represents an issue with only a subset of the query.
    ///
    public typealias MutationCompletion = (_ mutation: Storefront.Mutation?, _ error: QueryError?) -> Void
    
    /// The `Graph.Client` is a network layer designed to abstract the communication with the Shopify GraphQL endpoint
    /// by handling the serialization and deserialization of GraphQL models for `query` and `mutation` requests.
    /// In addition, the `Client` will take care of appending the necessary headers for authorizing the network
    /// requests based on the provided `shopDomain` and `apiKey`.
    ///
    public class Client {
        
        /// Cache policy to use for all `query` operations produced by this instance of `Graph.Client` 
        public var cachePolicy: CachePolicy = .networkOnly
        
        /// The `URLSession` backing all `Client` network operations. You can provide your own session when initializing a new `Client`.
        public let session: URLSession
        
        internal let cache = Cache()
        
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
        ///     - cachePolicy:       An optional `Graph.CachePolicy` that determines whether or not the query should be loaded from cache or fetched over the network.
        ///     - retryHandler:      An optional handler for subsequently retrying or polling. There are several Shopify resources that require polling until `resource.ready == true`. If provided, the `retryHandler` is executed for every response to determine whether a request should continue retrying. The `completionHandler` won't be executed until the `retryHandler.condition` evaluates to `false`.
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
        public func queryGraphWith(_ query: Storefront.QueryRootQuery, cachePolicy: CachePolicy? = nil, retryHandler: RetryHandler<Storefront.QueryRoot>? = nil, completionHandler: @escaping QueryCompletion) -> Task {
            return self.graphRequestTask(
                query:             query,
                cachePolicy:       cachePolicy ?? self.cachePolicy,
                retryHandler:      retryHandler,
                completionHandler: completionHandler
            )
        }

        // ----------------------------------
        //  MARK: - Mutations -
        //
        /// Performs a GraphQL `mutation` request.
        ///
        /// - parameters:
        ///     - mutation:          A GraphQL mutation to execute, represented by a `MutationQuery` object.
        ///     - retryHandler:      An optional handler for subsequently retrying or polling. There are several Shopify resources that require polling until `resource.ready == true`. If provided, the `retryHandler` is executed for every response to determine whether a request should continue retrying. The `completionHandler` won't be executed until the `retryHandler.condition` evaluates to `false`.
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
            return self.graphRequestTask(
                query:             mutation,
                cachePolicy:       .networkOnly,
                retryHandler:      retryHandler,
                completionHandler: completionHandler
            )
        }

        // ----------------------------------
        //  MARK: - Request Management -
        //
        private func graphRequestTask<Q: GraphQL.AbstractQuery, R: GraphQL.AbstractResponse>(query: Q, cachePolicy: CachePolicy, retryHandler: RetryHandler<R>? = nil, completionHandler: @escaping (R?, QueryError?) -> Void) -> Task {
            
            let request = self.graphRequestFor(query: query)
            return InternalTask<R>(
                session:      self.session,
                cache:        self.cache,
                request:      request,
                cachePolicy:  cachePolicy,
                retryHandler: retryHandler,
                completion:   completionHandler
            )
        }

        func graphRequestFor(query: GraphQL.AbstractQuery) -> URLRequest {
            var request     = URLRequest(url: self.apiURL)
            let requestData = String(describing: query).data(using: .utf8)!
            
            request.httpMethod              = "POST"
            request.httpBody                = requestData
            request.httpShouldHandleCookies = false
            
            request.setValue("application/json",    forHTTPHeaderField: Header.accept)
            request.setValue("application/graphql", forHTTPHeaderField: Header.contentType)
            request.setValue(MD5.hash(requestData), forHTTPHeaderField: Header.queryTag)

            for (name, value) in self.headers {
                request.setValue(value, forHTTPHeaderField: name)
            }

            return request
        }
    }
}
