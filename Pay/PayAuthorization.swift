//
//  PayAuthorization.swift
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

/// Encapsulates the encrypted JSON payload provided by Apple Pay after an authorized payment request. In addition to
/// the `token`, this structure includes final information that is available *only* after payment authorization,
/// such as `billingAddress` and a complete `shippingAddress`.
///
public struct PayAuthorization {

    /// Encrypted JSON payment data represented by a string
    public let token: String

    /// Billing address that was selected by the user
    public let billingAddress: PayAddress

    /// Shipping address that was selected by the user
    public let shippingAddress: PayAddress

    /// Shipping rate that was selected by the user
    public let shippingRate: PayShippingRate?

    // ----------------------------------
    //  MARK: - Init -
    //
    internal init(paymentData: Data, billingAddress: PayAddress, shippingAddress: PayAddress, shippingRate: PayShippingRate?) {
        self.token           = String(data: paymentData, encoding: .utf8)!
        self.billingAddress  = billingAddress
        self.shippingAddress = shippingAddress
        self.shippingRate    = shippingRate
    }
}
