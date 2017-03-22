//
//  CartController.swift
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

class CartController {

    static let shared = CartController()
    
    private(set) var items: [CartItem] = []
    
    var subtotal: Decimal {
        var value: Decimal = 0.0
        for item in self.items {
            value += item.variant.price * Decimal(item.quantity)
        }
        return value
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        
    }
    
    // ----------------------------------
    //  MARK: - Item Management -
    //
    func incrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity += 1
    }
    
    func decrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity -= 1
    }
    
    func add(_ cartItem: CartItem) {
        if let index = self.items.index(of: cartItem) {
            self.incrementAt(index)
        } else {
            self.items.append(cartItem)
        }
    }
    
    func removeAllQuantitiesFor(_ cartItem: CartItem) {
        if let index = self.items.index(of: cartItem) {
            self.items.remove(at: index)
        }
    }
}
