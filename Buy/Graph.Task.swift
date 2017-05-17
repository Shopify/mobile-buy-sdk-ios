//
//  Graph.Task.swift
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

/// Provides an interface for managing the `URLSessionDataTask` created by `Graph.Client`. Since the
/// underlying `URLSessionDataTask` can change (in the case of retried requests), `Task` provides
/// a single place to `cancel()` or `resume()` this underlying task.
///
public protocol Task {
    
    /// Starts the underlying task
    func resume()
    
    /// Cancel the underlying task
    func cancel()
}

extension URLSessionDataTask: Task {}

internal extension Graph {
    
    internal class InternalTask<R: GraphQL.AbstractResponse>: Task {
        
        typealias TaskCompletion = (R?, QueryError?) -> Void
        
        internal private(set) var isResumed:   Bool = false
        internal private(set) var isCancelled: Bool = false
        
        internal let cache:        Cache
        internal let session:      URLSession
        internal let request:      URLRequest
        internal let cachePolicy:  CachePolicy
        internal let retryHandler: RetryHandler<R>?
        internal let completion:   TaskCompletion
        
        internal var task:         URLSessionDataTask?
        
        // ----------------------------------
        //  MARK: - Init -
        //
        internal init(session: URLSession, cache: Cache, request: URLRequest, cachePolicy:  CachePolicy, retryHandler: RetryHandler<R>? = nil, completion: @escaping TaskCompletion) {
            self.cache        = cache
            self.session      = session
            self.request      = request
            self.cachePolicy  = retryHandler == nil ? cachePolicy : .networkOnly
            self.retryHandler = retryHandler
            self.completion   = completion
        }

        // ----------------------------------
        //  MARK: - Control -
        //
        func resume() {
            self.isResumed = true
            self.resume(using: self.cachePolicy)
        }
        
        private func resume(using cachePolicy: CachePolicy) {
            
            let completion = self.completion
            let hash       = self.request.hash
            
            switch cachePolicy {
            case .cacheFirst(let expireIn):
                Log("Exercising cache policy: CACHE_FIRST(\(expireIn))")
                
                self.cachedModelFor(hash, expireIn: expireIn) { response in
                    if let response = response {
                        completion(response, nil)
                        return
                    } else {
                        self.resume(using: .networkOnly)
                    }
                }
                
            case .cacheOnly:
                Log("Exercising cache policy: CACHE_ONLY")
                
                self.cachedModelFor(hash) { response in
                    completion(response, nil)
                    return
                }
                
            case .networkFirst(let expireIn):
                Log("Exercising cache policy: NETWORK_FIRST(\(expireIn))")
                
                self.task = self.graphTaskWith(self.request, retryHandler: self.retryHandler) { response, data, error in
                    
                    if let _ = response, let data = data {
                        self.cache(data, for: hash)
                        completion(response, error)
                        
                    } else {
                        
                        self.cachedModelFor(hash, expireIn: expireIn) { response in
                            if let response = response {
                                completion(response, nil)
                            } else {
                                completion(nil, error)
                            }
                        }
                    }
                }
                self.task?.resume()
                
            case .networkOnly:
                Log("Exercising cache policy: NETWORK_ONLY")
                
                self.task = self.graphTaskWith(self.request, retryHandler: self.retryHandler) { response, data, error in
                    
                    if let _ = response, let data = data {
                        self.cache(data, for: hash)
                    }
                    completion(response, error)
                }
                self.task?.resume()
            }
        }
        
        func cancel() {
            self.isCancelled = true
            self.task?.cancel()
        }

        // ----------------------------------
        //  MARK: - Cache -
        //
        private func cache(_ data: Data, for hash: Hash) {
            let cacheItem = CacheItem(hash: hash, data: data)
            self.cache.set(cacheItem)
        }
        
        private func cachedModelFor(_ hash: Hash, expireIn: Int? = nil, completion: @escaping (R?) -> Void) {
            guard let item = self.cache.item(for: hash) else {
                completion(nil)
                return
            }
            
            /* ---------------------------------
             ** If the expiry is provided, we'll
             ** need to validated that cached
             ** date isn't older than the allowed
             ** interval, otherwise return nil.
             */
            if let expireIn = expireIn {
                Log("Cache expiry interval set to: \(expireIn)")
                
                let now       = Int(Date().timeIntervalSince1970)
                let timestamp = Int(item.timestamp)
                
                guard timestamp + expireIn > now else {
                    Log("Cached item expiry exceeded by: Now: \(timestamp + expireIn - now)")
                    
                    /* ----------------------------------
                     ** Purge any expired items from disk
                     ** to avoid the overhead of loading
                     ** them just to find out they have
                     ** already expired.
                     */
                    self.cache.remove(for: hash)
                    
                    completion(nil)
                    return
                }
                
                Log("Cached item is still valid. Time remaining Now: \(timestamp + expireIn - now)")
            } else {
                Log("No cache expiry set.")
            }
            
            let response = HTTPURLResponse(
                url:          request.url!,
                statusCode:   200,
                httpVersion:  "HTTP/1.1",
                headerFields: nil
            )
            let (model, _) = self.processResponse(item.data, response, nil)
            
            completion(model)
        }
        
        // ----------------------------------
        //  MARK: - Session -
        //
        private func graphTaskWith(_ request: URLRequest, retryHandler: RetryHandler<R>? = nil, completion: @escaping (R?, Data?, QueryError?) -> Void) -> URLSessionDataTask {
            return self.session.dataTask(with: request) { data, response, error in
                
                let (model, error) = self.processResponse(data, response, error)
                
                DispatchQueue.main.async {
                    if var retryHandler = retryHandler, retryHandler.canRetry, retryHandler.condition(model, error) == true {
                        
                        /* ---------------------------------
                         ** A retry handler was provided and
                         ** the condition evaluated to true,
                         ** we have to retry the request.
                         */
                        retryHandler.repeatCount += 1
                        
                        self.task = self.graphTaskWith(request, retryHandler: retryHandler, completion: completion)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + retryHandler.interval) {
                            if self.task!.state == .suspended {
                                self.task!.resume()
                            }
                        }
                        
                    } else {
                        completion(model, data, error)
                    }
                }
            }
        }
        
        private func processResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> (model: R?, error: Graph.QueryError?) {
            
            guard let response = response as? HTTPURLResponse, error == nil else {
                return (nil, .request(error: error))
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                return (nil, .http(statusCode: response.statusCode))
            }
            
            guard let data = data else {
                return (nil, .noData)
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                return (nil, .jsonDeserializationFailed(data: data))
            }
            
            let graphResponse = json as? JSON
            let graphErrors   = graphResponse?["errors"] as? [JSON]
            let graphJson     = graphResponse?["data"]   as? JSON
            
            /* ----------------------------------
             ** This should never happen. A valid
             ** GraphQL response will have either
             ** data or errors.
             */
            guard graphJson != nil || graphErrors != nil else {
                return (nil, .invalidJson(json: json))
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
            
            if let json = graphJson {
                
                var model: R?
                
                do {
                    model = try R(fields: json)
                } catch let error {
                    queryError = Graph.QueryError.schemaViolation(violation: error as! SchemaViolationError)
                }
                return (model, queryError)
                
            } else {
                return (nil, queryError)
            }
        }
    }
}
