//
//  Fragment+ImageConnectionQuery.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import Buy

extension ApiSchema.ImageConnectionQuery {
    
    @discardableResult
    func fragmentForStandardProductImage() -> ApiSchema.ImageConnectionQuery { return self
        .edges { $0
            .node { $0
                .id()
                .src()
                .altText()
            }
        }
    }
}
