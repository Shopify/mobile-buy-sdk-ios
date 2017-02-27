//
//  CollectionCell.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
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
