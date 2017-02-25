//
//  ViewModelConfigurable.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get }
    
    func configureFrom(_ viewModel: ViewModelType)
}
