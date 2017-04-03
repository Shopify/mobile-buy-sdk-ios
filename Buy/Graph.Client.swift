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
    static var authorization = "Authorization"
    static var accept        = "Accept"
    static var contentType   = "Content-Type"
}

extension Graph {
    public class Client {
        
        public let session:  URLSession
        
        private let apiURL:  URL
        private let headers: [String : String]
        
        // ----------------------------------
        //  MARK: - Init -
        //
        public init(shopDomain: String, apiKey: String, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
            
            let shopURL  = Client.urlFor(shopDomain)
            self.apiURL  = Client.urlFor(shopDomain, path: "/api/graphql")
            self.session = session
            self.headers = [
                Header.userAgent     : Global.userAgent,
                Header.authorization : "Basic \(Client.tokenFor(apiKey))"
            ]
            
            precondition(!apiKey.isEmpty, "API Key is required to the Buy SDK. You can obtain one by adding a Mobile App channel here: \(shopURL.appendingPathComponent("admin"))")
        }
        
        static func tokenFor(_ apiKey: String) -> String {
            return apiKey.data(using: .utf8)!.base64EncodedString()
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
        public func queryGraphWith(_ query: Storefront.QueryRootQuery, retryHandler: RetryHandler<Storefront.QueryRoot>? = nil, completionHandler: @escaping (Storefront.QueryRoot?, QueryError?) -> Void) -> Task {
            return self.graphRequestTask(query: query, retryHandler: retryHandler, completionHandler: completionHandler)
        }
        
        // ----------------------------------
        //  MARK: - Mutations -
        //
        public func mutateGraphWith(_ mutation: Storefront.MutationQuery, retryHandler: RetryHandler<Storefront.Mutation>? = nil, completionHandler: @escaping (Storefront.Mutation?, QueryError?) -> Void) -> Task {
            return self.graphRequestTask(query: mutation, retryHandler: retryHandler, completionHandler: completionHandler)
        }
        
        // ----------------------------------
        //  MARK: - Request Management -
        //
        private func graphRequestTask<Q: GraphQL.AbstractQuery, R: GraphQL.AbstractResponse>(query: Q, retryHandler: RetryHandler<R>? = nil, completionHandler: @escaping (R?, QueryError?) -> Void) -> Task {
            
            var task: Task!
            
            let request  = self.graphRequest(query: query)
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
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + retryHandler.repeatInterval) {
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
        
        private func graphRequest(query: GraphQL.AbstractQuery) -> URLRequest {
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
//  MARK: - Graph Data Task -
//
private extension URLSession {
    
    func graphTask<R: GraphQL.AbstractResponse>(with request: URLRequest, completionHandler: @escaping (R?, Graph.QueryError?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { json, error in
            
            if let json = json {
                
                do {
                    completionHandler(try R(fields: json), error)
                } catch {
                    let violation = error as? SchemaViolationError ?? SchemaViolationError(type: R.self, field: "data", value: json)
                    completionHandler(nil, Graph.QueryError.schemaViolationError(violation: violation))
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
                queryError = .queryError(reasons: graphErrors.map {
                    Graph.QueryError.Reason(json: $0)
                })
            }
            
            completionHandler(graphData, queryError)
        }
    }
}
