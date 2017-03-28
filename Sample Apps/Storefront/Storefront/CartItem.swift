//
//  CartItem.swift
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

class CartItem: Equatable, Hashable {
    
    let product: ProductViewModel
    let variant: VariantViewModel
    
    var quantity: Int
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(product: ProductViewModel, variant: VariantViewModel, quantity: Int = 1) {
        self.product  = product
        self.variant  = variant
        self.quantity = quantity
    }
}

// ----------------------------------
//  MARK: - Hashable -
//
extension CartItem {
    
    var hashValue: Int {
        return self.variant.id.hashValue
    }
}

// ----------------------------------
//  MARK: - Equatable -
//
extension CartItem {
    
    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.variant.id == rhs.variant.id && lhs.product.id == rhs.product.id
    }
}
