//
//  ProductViewModel.swift
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

import Foundation
import Buy

struct ProductViewModel: ViewModel {
    
    typealias ModelType = Storefront.Product
    
    let model:    ModelType
    
    let title:    String
    let price:    String
    let imageURL: URL?
    let variants: [VariantViewModel]
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(from model: ModelType) {
        self.model    = model
        
        let variants = model.variants.edges.map { $0.node }.viewModels.sorted {
            $0.0.price < $0.1.price
        }
        
        let lowestPrice = variants.first?.price
        
        self.title    = model.title
        self.price    = lowestPrice == nil ? "No price" : Currency.stringFrom(lowestPrice!)
        self.imageURL = model.imagesArray().first?.src
        self.variants = variants
    }
}

extension Storefront.Product: ViewModeling {
    typealias ViewModelType = ProductViewModel
}
