//
//  Fragment+ProductConnectionQuery.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension ApiSchema.ProductConnectionQuery {
    
    @discardableResult
    func fragmentForStandardProduct() -> ApiSchema.ProductConnectionQuery { return self
        .edges { $0
            .node { $0
                .images(first: 1) { $0
                    .fragmentForStandardProductImage()
                }
            }
        }
    }
}
