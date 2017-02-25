//
//  ViewModel.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation

protocol ViewModel {
    
    associatedtype ModelType
    
    init(from model: ModelType)
}
