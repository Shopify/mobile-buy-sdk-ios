//
//  Fragment+VariantConnectionQuery.swift
//  Storefront
//
//  Created by Dima Bart on 2017-03-15.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Buy

extension Storefront.ProductVariantConnectionQuery {
    
    @discardableResult
    func fragmentForStandardVariant() -> Storefront.ProductVariantConnectionQuery { return self
        .pageInfo { $0
            .hasNextPage()
        }
        .edges { $0
            .cursor()
            .node { $0
                .title()
                .price()
            }
        }
    }
}
