//
//  GraphQuery.swift
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

final class GraphQuery {

    static func queryForCollections(limit: Int, after cursor: String? = nil, productLimit: Int = 25, productCursor: String? = nil) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .shop { $0
                .collections(first: Int32(limit), after: cursor) { $0
                    .pageInfo { $0
                        .hasNextPage()
                    }
                    .edges { $0
                        .cursor()
                        .node { $0
                            .id()
                            .title()
                            .descriptionHtml()
                            .image { $0
                                .src()
                            }
                            
                            .products(first: Int32(productLimit), after: productCursor) { $0
                                .fragmentForStandardProduct()
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func queryForProducts(in collection: CollectionViewModel, limit: Int, after cursor: String? = nil) -> Storefront.QueryRootQuery {
        
        return Storefront.buildQuery { $0
            .node(id: collection.model.node.id) { $0
                .onCollection { $0
                    .products(first: Int32(limit), after: cursor) { $0
                        .fragmentForStandardProduct()
                    }
                }
            }
        }
    }
}
