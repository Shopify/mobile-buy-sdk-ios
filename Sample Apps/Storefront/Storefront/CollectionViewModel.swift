//
//  CollectionViewModel.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

struct CollectionViewModel: ViewModel {
    
    typealias ModelType = ApiSchema.Collection
    
    let imageURL: URL?
    let products: [ProductViewModel]
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(from model: ApiSchema.Collection) {
        if let source = model.image?.src {
            self.imageURL = URL(string: source)!
        } else {
            self.imageURL = nil
        }
        
        self.products = model.products().viewModels
    }
}

extension ApiSchema.Collection: ViewModeling {
    typealias ViewModelType = CollectionViewModel
}

