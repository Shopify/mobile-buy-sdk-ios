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
        var accumulator: Decimal = 0.0
        for item in self.items {
            accumulator += item.variant.price * Decimal(item.quantity)
        }
        return accumulator
    }
    
    var itemCount: Int {
        var accumulator = 0
        for item in self.items {
            accumulator += item.quantity
        }
        return accumulator
    }
    
    private let ioQueue    = DispatchQueue(label: "com.storefront.writeQueue")
    private var needsFlush = false
    private var cartURL: URL = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsURL  = URL(fileURLWithPath: documentsPath)
        let cartURL       = documentsURL.appendingPathComponent("cart.json")
        
        print("Cart URL: \(cartURL)")
        
        return cartURL
    }()
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.readCart { items in
            if let items = items {
                self.items = items
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - IO Management -
    //
    private func setNeedsFlush() {
        if !self.needsFlush {
            self.needsFlush = true
            
            DispatchQueue.main.async(execute: self.flush)
        }
    }
    
    private func flush() {
        let serializedItems = self.items.serialize()
        self.ioQueue.async {
            do {
                let data = try JSONSerialization.data(withJSONObject: serializedItems, options: [])
                try data.write(to: self.cartURL, options: [.atomic])
                
                print("Flushed cart to disk.")
                
            } catch let error {
                print("Failed to flush cart to disk: \(error)")
            }
            
            DispatchQueue.main.async {
                self.needsFlush = false
            }
        }
    }
    
    private func readCart(completion: @escaping ([CartItem]?) -> Void) {
        self.ioQueue.async {
            do {
                let data            = try Data(contentsOf: self.cartURL)
                let serializedItems = try JSONSerialization.jsonObject(with: data, options: [])
                
                let cartItems = [CartItem].deserialize(from: serializedItems as! [SerializedRepresentation])
                DispatchQueue.main.async {
                    completion(cartItems)
                }
                
            } catch let error {
                print("Failed to load cart from disk: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Item Management -
    //
    func updateQuantity(_ quantity: Int, at index: Int) -> Bool {
        let existingItem = self.items[index]
        
        if existingItem.quantity != quantity {
            existingItem.quantity = quantity
            
            self.setNeedsFlush()
            return true
        }
        return false
    }
    
    func incrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity += 1
        
        self.setNeedsFlush()
    }
    
    func decrementAt(_ index: Int) {
        let existingItem = self.items[index]
        existingItem.quantity -= 1
        
        self.setNeedsFlush()
    }
    
    func add(_ cartItem: CartItem) {
        if let index = self.items.index(of: cartItem) {
            self.incrementAt(index)
        } else {
            self.items.append(cartItem)
        }
        
        self.setNeedsFlush()
    }
    
    func removeAllQuantitiesFor(_ cartItem: CartItem) {
        if let index = self.items.index(of: cartItem) {
            self.items.remove(at: index)
            
            self.setNeedsFlush()
        }
    }
}
