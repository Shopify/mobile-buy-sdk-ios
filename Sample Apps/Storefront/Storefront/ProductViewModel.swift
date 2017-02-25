//
//  ProductViewModel.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

struct ProductViewModel: ViewModel {
    
    typealias ModelType = ApiSchema.Product
    
    let imageURL: URL?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(from model: ModelType) {
        if let image = model.images().first {
            self.imageURL = URL(string: image.src)!
        } else {
            self.imageURL = nil
        }
    }
}

extension ApiSchema.Product: ViewModeling {
    typealias ViewModelType = ProductViewModel
}
