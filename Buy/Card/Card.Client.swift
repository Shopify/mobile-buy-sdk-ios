//
//  Card.Client.swift
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

public extension Card {
    
    public typealias VaultCompletion = (_ token: String?, _ error: Error?) -> Void
    
    /// The `Vault.Client` is a network layer designed to abstract the communication with the Shopify's
    /// credit card server. For PCI-compliance reasons, this is a standalone service, separate from the
    /// main `Graph.Client` service.
    ///
    public class Client {
     
        /// The `URLSession` backing all `Client` network operations. You may provide your own session when initializing a new `Client`.
        public let session: URLSession
        
        // ----------------------------------
        //  MARK: - Init -
        //
        /// Creates and initialized a new `Client`.
        ///
        /// - parameters:
        ///     - session: A `URLSession` to use for this client. If left blank, a session with a `default` configuration will be created.
        ///
        public init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
            self.session = session
        }
        
        // ----------------------------------
        //  MARK: - Request Generation -
        //
        func requestFor(_ creditCard: CreditCard, to url: URL) -> URLRequest {
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            request.httpBody   = try! JSONSerialization.data(withJSONObject: creditCard.dictionary(), options: [])
            request.httpShouldHandleCookies = false
            
            request.setValue("application/json", forHTTPHeaderField: Header.accept)
            request.setValue("application/json", forHTTPHeaderField: Header.contentType)
            
            return request
        }
        
        // ----------------------------------
        //  MARK: - Vaulting -
        //
        /// Stores the raw credit data on Shopify's card server and exchanges it for a token 
        /// that can be used to complete a checkout.
        ///
        /// - parameters:
        ///     - creditCard: The credit card to vault
        ///     - url:        The `vaultUrl` obtained from a `Storefront.Checkout`
        ///     - completion: The completion handler that will be executed with the token after a card has has been vaulted.
        ///
        /// - returns:
        /// A reference to a `Task` representing this vault operation.
        ///
        public func vault(_ creditCard: CreditCard, to url: URL, completion: @escaping VaultCompletion) -> Task {
            let task = self.session.dataTask(with: self.requestFor(creditCard, to: url)) { data, response, error in
                
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                    let token  = object["id"] as! String
                    
                    completion(token, nil)
                    
                } catch let jsonError {
                    completion(nil, jsonError)
                }
            }
            
            return task
        }
    }
}
