//
//  ProductCell.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell, ViewModelConfigurable {

    typealias ViewModelType = ProductViewModel
    
    @IBOutlet private weak var imageView: UIImageView!
    
    private(set) var viewModel: ProductViewModel?
    
    func configureFrom(_ viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        self.imageView.setImageFrom(viewModel.imageURL)
    }
}
