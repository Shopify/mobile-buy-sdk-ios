//
//  Fragment+Shop.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension ApiSchema.Shop {
    
    func collections() -> [ApiSchema.Collection] {
        return self.collections.edges.map { $0.node }
    }
}
