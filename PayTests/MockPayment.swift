//
//  MockPayment.swift
//  PayTests
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
import PassKit

class MockPayment: PKPayment {
    
    override var token: PKPaymentToken {
        return self._token
    }
    
    override var billingContact: PKContact? {
        return self._billingContact
    }
    
    override var shippingContact: PKContact? {
        return self._shippingContact
    }
    
    override var shippingMethod: PKShippingMethod? {
        return self._shippingMethod
    }
    
    let _token:           MockPaymentToken
    let _billingContact:  PKContact?
    let _shippingContact: PKContact?
    let _shippingMethod:  PKShippingMethod?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(token: MockPaymentToken, billingContact: PKContact? = nil, shippingContact: PKContact? = nil, shippingMethod: PKShippingMethod? = nil) {
        self._token           = token
        self._billingContact  = billingContact
        self._shippingContact = shippingContact
        self._shippingMethod  = shippingMethod
    }
}
