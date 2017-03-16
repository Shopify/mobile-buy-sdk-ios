//
//  Pageable.swift
//  Storefront
//
//  Created by Dima Bart on 2017-03-15.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Buy

struct PageableArray<T: ViewModel> {
    
    private(set) var items: [T]
    
    var hasNextPage: Bool {
        return pageInfo.hasNextPage
    }
    
    var hasPreviousPage: Bool {
        return pageInfo.hasPreviousPage
    }
    
    private var pageInfo: Storefront.PageInfo
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(with items: [T], pageInfo: Storefront.PageInfo) {
        self.items    = items
        self.pageInfo = pageInfo
    }
    
    init<M>(with items: [M], pageInfo: Storefront.PageInfo) where M: ViewModeling, M.ViewModelType == T {
        self.items    = items.viewModels
        self.pageInfo = pageInfo
    }
    
    // ----------------------------------
    //  MARK: - Adding -
    //
    mutating func appendPage(from pageableArray: PageableArray<T>) {
        self.items.append(contentsOf: pageableArray.items)
        self.pageInfo = pageableArray.pageInfo
    }
}
