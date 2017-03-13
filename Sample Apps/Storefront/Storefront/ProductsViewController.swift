//
//  ProductsViewController.swift
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

import UIKit
import Buy

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: StorefrontCollectionView!
    
    var graph:      Graph!
    var collection: CollectionViewModel!
    
    fileprivate let columns:  Int = 2
    fileprivate var products: [ProductViewModel] = []
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Graph.shared.fetcProducts(in: self.collection) { products in
            if let products = products {
                self.products = products
                self.collectionView.reloadData()
            }
        }
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell       = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as! ProductCell
        let collection = self.products[indexPath.item]
        
        cell.configureFrom(collection)
        
        return cell
    }
}

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout         = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing    = layout.minimumInteritemSpacing * CGFloat(self.columns - 1)
        let sectionSpacing = layout.sectionInset.left + layout.sectionInset.right
        let length         = (collectionView.bounds.width - itemSpacing - sectionSpacing) / CGFloat(self.columns)
        
        return CGSize(
            width:  length,
            height: length
        )
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension ProductsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
