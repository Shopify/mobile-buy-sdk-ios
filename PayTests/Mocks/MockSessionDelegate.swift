//
//  MockSessionDelegate.swift
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
import Pay

final class MockSessionDelegate: PaySessionDelegate {
    
    var didSelectShippingRate:    ((PaySession, PayShippingRate, PayCheckout, (PayCheckout?) -> Void) -> Void)?
    var didAuthorizePayment:      ((PaySession, PayAuthorization, PayCheckout, (PaySession.TransactionStatus) -> Void) -> Void)?
    var didRequestShippingRates:  ((PaySession, PayPostalAddress, PayCheckout, (PayCheckout?, [PayShippingRate]) -> Void) -> Void)?
    var didUpdateShippingAddress: ((PaySession, PayPostalAddress, PayCheckout, (PayCheckout?) -> Void) -> Void)?
    var didFinish:                ((PaySession) -> Void)?
    
    let session: PaySession
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(session: PaySession) {
        self.session          = session
        self.session.delegate = self
    }
    
    // ----------------------------------
    //  MARK: - Delegate -
    //
    func paySession(_ paySession: PaySession, didSelectShippingRate shippingRate: PayShippingRate, checkout: PayCheckout, provide: @escaping (PayCheckout?) -> Void) {
        self.didSelectShippingRate?(paySession, shippingRate, checkout, provide)
    }
    
    func paySession(_ paySession: PaySession, didAuthorizePayment authorization: PayAuthorization, checkout: PayCheckout, completeTransaction: @escaping (PaySession.TransactionStatus) -> Void) {
        self.didAuthorizePayment?(paySession, authorization, checkout, completeTransaction)
    }
    
    func paySession(_ paySession: PaySession, didRequestShippingRatesFor address: PayPostalAddress, checkout: PayCheckout, provide: @escaping (PayCheckout?, [PayShippingRate]) -> Void) {
        self.didRequestShippingRates?(paySession, address, checkout, provide)
    }
    
    func paySession(_ paySession: PaySession, didUpdateShippingAddress address: PayPostalAddress, checkout: PayCheckout, provide: @escaping (PayCheckout?) -> Void) {
        self.didUpdateShippingAddress?(paySession, address, checkout, provide)
    }
    
    func paySessionDidFinish(_ paySession: PaySession) {
        self.didFinish?(paySession)
    }
}
