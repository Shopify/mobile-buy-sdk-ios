//
//  Graph.swift
//  Storefront
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
import Buy

final class Graph {
    
    private static let shopDomain = "your-shop.myshopify.com"
    private static let apiKey     = "your-api-key"
    
    private let client: GraphClient = GraphClient(shopDomain: Graph.shopDomain, apiKey: Graph.apiKey)
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init() {
        
    }
    
    // ----------------------------------
    //  MARK: - Collections -
    //
    @discardableResult
    func fetchCollections(limit: Int = 25, after cursor: String? = nil, productLimit: Int = 25, productCursor: String? = nil, completion: @escaping ([CollectionViewModel]?) -> Void) -> URLSessionDataTask {
        
        let query = GraphQuery.queryForCollections(limit: limit, after: cursor, productLimit: productLimit, productCursor: productCursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            
            if let query = query {
                let collections = query.shop.collectionsArray().viewModels
                completion(collections)
            } else {
                print("Failed to load collections: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func fetcProducts(in collection: CollectionViewModel, limit: Int = 25, after cursor: String? = nil, completion: @escaping ([ProductViewModel]?) -> Void) -> URLSessionDataTask {
        
        let query = GraphQuery.queryForProducts(in: collection, limit: limit, after: cursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            
            if let query = query,
                let collection = query.node as? Storefront.Collection {
                
                let products = collection.products.edges.map { $0.node }.viewModels
                completion(products)
                
            } else {
                print("Failed to load products in collection (\(collection.model.id.rawValue)): \(error)")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
}
