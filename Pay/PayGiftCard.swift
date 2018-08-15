//
//  PayGiftCard.swift
//  Pay
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

/// Represents a gift card to be applied to the checkout.
///
public struct PayGiftCard {
    
    /// Globally unique identifier.
    public let id: String
    
    /// The amount left on the Gift Card.
    public let balance: Decimal
    
    /// The amount that was used taken from the Gift Card by applying it.
    public let amount: Decimal
    
    /// The last characters of the Gift Card code
    public let lastCharacters: String
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(id: String, balance: Decimal, amount: Decimal, lastCharacters: String) {
        self.id             = id
        self.balance        = balance
        self.amount         = amount
        self.lastCharacters = lastCharacters
    }
}
