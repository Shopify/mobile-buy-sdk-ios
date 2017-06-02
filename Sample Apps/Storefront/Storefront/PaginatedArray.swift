//
//  Pageable.swift
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
