//
//  Fragment+CollectionQuery.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension ApiSchema.CollectionQuery {
    
    @discardableResult
    func fragmentForStandardImage() -> ApiSchema.CollectionQuery { return self
        .image { $0
            .src()
        }
    }
}

