//
//  CollectionCell.swift
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

class CollectionCell: UITableViewCell, ViewModelConfigurable {
    
    typealias ViewModelType = CollectionViewModel
    
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var collectionView: StorefrontCollectionView!
    
    private(set) var viewModel: CollectionViewModel?
    
    func configureFrom(_ viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        
        self.titleImageView.setImageFrom(viewModel.imageURL)
        self.collectionView.reloadData()
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as! ProductCell
        let product = self.viewModel!.products[indexPath.row]
        
        cell.configureFrom(product)
        
        return cell
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension CollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// -----------------------------------------------
//  MARK: - UICollectionViewDelegateFlowLayout -
//
extension CollectionCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let length = collectionView.bounds.height - layout.sectionInset.top - layout.sectionInset.bottom
        
        return CGSize(
            width:  length,
            height: length
        )
    }
}
