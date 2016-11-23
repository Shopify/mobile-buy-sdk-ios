//
//  DataProvider.swift
//  Mobile Buy SDK tvOS Sample App
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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

protocol DataProviderSetter: class {
    var dataProvider: DataProvider!{get set}
}

public class DataProvider {
    
    private(set) var client : BUYClient!
    
    var collections: [BUYCollection] = []
    var products: [NSNumber: [BUYProduct]] = [:]
    
    public required init(client: BUYClient) {
        self.client = client
    }
    
    public func getCollections(completion: @escaping ([BUYCollection]) -> Void) -> Operation {
        if self.collections.count > 0 {
            completion(self.collections)
        }
        return self.downloadCollections(completion: completion)
    }

    public func getProducts(collection: BUYCollection, completion: @escaping ([BUYProduct]) -> Void) -> Operation {
        let identifier = collection.identifier as NSNumber
        let collectionProducts = products[identifier]
        
        if (collectionProducts?.count)! > 0 {
            completion(collectionProducts!)
        }
        return self.downloadProducts(collection: identifier, completion:completion)
    }
    
    private func downloadCollections(completion: @escaping([BUYCollection]) -> Void) -> Operation {
        return self.client.getCollectionsPage(1) { [weak self] (collections, page, reachedEnd, error) in
            self?.collections = collections!
            completion(collections!)
        }
    }
    
    private func downloadProducts(collection: NSNumber, completion: @escaping([BUYProduct]) -> Void) -> Operation {
        return self.client.getProductsPage(1, inCollection: collection) { [weak self] (products, page, reachedEnd, error) in
            self?.products[collection] = products
            completion(products!)
        }
    }
}
