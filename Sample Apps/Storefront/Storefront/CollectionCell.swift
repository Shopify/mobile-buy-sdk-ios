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

protocol CollectionCellDelegate: class {
    func cell(_ collectionCell: CollectionCell, didRequestProductsIn collection: CollectionViewModel, after product: ProductViewModel)
    func cell(_ collectionCell: CollectionCell, didSelectProduct product: ProductViewModel)
}

class CollectionCell: UITableViewCell, ViewModelConfigurable {
    
    typealias ViewModelType = CollectionViewModel
    
    weak var delegate: CollectionCellDelegate?
    
    @IBOutlet private weak var titleImageView: UIImageView!
    @IBOutlet private weak var collectionView: StorefrontCollectionView!
    
    private(set) var viewModel: CollectionViewModel?
    
    // ----------------------------------
    //  MARK: - Configure -
    //
    func configureFrom(_ viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        
        self.titleImageView.setImageFrom(viewModel.imageURL)
        self.collectionView.reloadData()
    }
    
    func appendProductsPage(from paginatedProducts: PageableArray<ProductViewModel>) {
        if let viewModel = self.viewModel, !paginatedProducts.items.isEmpty {
            print("Paging added \(paginatedProducts.items.count) products.")
            
            viewModel.products.appendPage(from: paginatedProducts)
            self.collectionView.reloadData()
            self.collectionView.completePaging()
        }
    }
    
    // ----------------------------------
    //  MARK: - Reuse -
    //
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.collectionView.contentOffset = CGPoint.zero
    }
    
    // ----------------------------------
    //  MARK: - Awake -
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.paginationDirection = .horizontal
        self.collectionView.paginationDelegate  = self
    }
    
    // ----------------------------------
    //  MARK: - Touch Queries -
    //
    func productFor(_ touch: CGPoint) -> (model: ProductViewModel, sourceRect: CGRect)? {
        
        let collectionTouch = self.collectionView.convert(touch, from: self)
        if let indexPath = self.collectionView.indexPathForItem(at: collectionTouch) {
            
            let cell      = self.collectionView.cellForItem(at: indexPath) as! ProductCell
            let cellFrame = self.collectionView.rectForItem(at: indexPath)!
            
            let product   = cell.viewModel!
            let frame     = self.convert(cellFrame, from: self.collectionView)
            
            return (product, frame)
        }
        return nil
    }
    
    func collectionFor(_ touch: CGPoint) -> (model: CollectionViewModel, sourceRect: CGRect)? {
        if self.titleImageView.frame.contains(touch) {
            return (self.viewModel!, self.titleImageView.frame)
        }
        return nil
    }
}

// ----------------------------------
//  MARK: - PaginationDelegate -
//
extension CollectionCell: StorefrontCollectionViewDelegate {
    
    func collectionViewShouldBeginPaging(_ collectionView: StorefrontCollectionView) -> Bool {
        print("Products have should begin paging: \(String(describing: self.viewModel?.products.hasNextPage))")
        return self.viewModel?.products.hasNextPage ?? false
    }
    
    func collectionViewWillBeginPaging(_ collectionView: StorefrontCollectionView) {
        if let collection = self.viewModel,
            let lastProduct = collection.products.items.last {
            
            self.delegate?.cell(self, didRequestProductsIn: collection, after: lastProduct)
        }
    }
    
    func collectionViewDidCompletePaging(_ collectionView: StorefrontCollectionView) {
        
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.products.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.className, for: indexPath) as! ProductCell
        let product = self.viewModel!.products.items[indexPath.row]
        
        cell.configureFrom(product)
        
        return cell
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDelegate -
//
extension CollectionCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.viewModel!.products.items[indexPath.row]
        self.delegate?.cell(self, didSelectProduct: product)
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
