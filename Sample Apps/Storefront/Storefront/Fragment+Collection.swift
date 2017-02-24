//
//  Fragment+Collection.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension ApiSchema.Collection {
    
    func products() -> [ApiSchema.Product] {
        return self.products.edges.map { $0.node }
    }
}
