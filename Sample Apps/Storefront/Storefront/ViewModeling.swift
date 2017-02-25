//
//  ViewModeling.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

protocol ViewModeling {
    
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType { get }
}

extension ViewModeling where ViewModelType.ModelType == Self {
    
    var viewModel: ViewModelType {
        return ViewModelType(from: self)
    }
}

extension Array where Element: ViewModeling {
    
    var viewModels: [Element.ViewModelType] {
        return self.map { $0.viewModel }
    }
}
