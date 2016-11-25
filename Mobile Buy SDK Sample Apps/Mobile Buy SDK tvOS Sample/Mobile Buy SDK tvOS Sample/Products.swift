//
//  Products.swift
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

class Products {
    
    private var collection: BUYCollection?
    private var products: [BUYProduct] = []
    private var productsOperation: Operation?
    
    weak var collectionView: UICollectionView!
 
    var dataProvider: DataProvider!
    
    init(collection: BUYCollection, dataProvider: DataProvider) {
        self.collection = collection
        self.dataProvider = dataProvider
    }
    
    func count() -> Int {
        return self.products.count
    }
    
    func stopOperation() {
        self.productsOperation?.cancel()
    }
    
    private func getProducts (collection: BUYCollection) {
        self.productsOperation = self.dataProvider.getProducts(collection: collection) { (products) in
            self.products = products
            self.collectionView.reloadData()
        }
    }
}
