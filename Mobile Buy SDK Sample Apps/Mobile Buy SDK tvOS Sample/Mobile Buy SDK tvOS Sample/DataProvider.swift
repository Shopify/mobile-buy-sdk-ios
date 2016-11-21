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

public protocol DataProviderDelegate: class {
    func dataProviderDidFinishDownloadingCollections(_dataProvider: DataProvider, collections: Array<Any>)
    func dataProviderDidFinishDownloadingProducts(_dataProvider: DataProvider, collection: NSNumber, products: Array<Any>)
}

public class DataProvider {
    
    private(set) var client : BUYClient!
    weak var delegate: DataProviderDelegate?
    
    var collections: [BUYCollection] = []
    var products: [NSNumber: Array<BUYProduct>] = [:]
    
    public required init(client: BUYClient) {
        self.client = client
    }
    
    public func getCollections() {
        if self.collections.count > 0 {
            self.delegate?.dataProviderDidFinishDownloadingCollections(_dataProvider: self, collections: self.collections)
        } else {
            self.downloadCollections()
        }
    }
    
    public func getProducts(collection: BUYCollection) {
        let identifier = collection.identifier as NSNumber
        let collectionProducts = products[identifier]
        
        if (collectionProducts?.count)! > 0 {
            self.delegate?.dataProviderDidFinishDownloadingProducts(_dataProvider: self, collection: identifier, products: collectionProducts!)
        } else {
            self.downloadProducts(collection: identifier)
        }
    }
    
    private func downloadCollections() {
        self.client.getCollectionsPage(1) { [weak self] (collections, page, reachedEnd, error) in
            self?.collections = collections!
            self?.delegate?.dataProviderDidFinishDownloadingCollections(_dataProvider: self!, collections: collections!)
        }
    }
    
    private func downloadProducts(collection: NSNumber) {
        self.client.getProductsPage(1, inCollection: collection) { [weak self] (products, page, reachedEnd, error) in
            self?.products[collection] = products
            self?.delegate?.dataProviderDidFinishDownloadingProducts(_dataProvider: self!, collection: collection, products: products!)
        }
    }
}
