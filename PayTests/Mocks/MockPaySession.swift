//
//  MockPaySession.swift
//  PayTests
//
//  Created by Dima Bart on 2017-09-20.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

#if canImport(PassKit)

import Foundation
import PassKit
@testable import Pay

@available(iOS 11.0, *)
class MockPaySession: PaySession {
    
    enum Status {
        case handled
        case unhandled
    }
    
    var didSelectShippingContactHandler: ((PKPaymentAuthorizationController, PKContact,        @escaping (PKPaymentRequestShippingContactUpdate) -> Void) -> Status)?
    var didSelectShippingMethodHandler:  ((PKPaymentAuthorizationController, PKShippingMethod, @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) -> Status)?
    var didAuthorizePaymentHandler:      ((PKPaymentAuthorizationController, PKPayment,        @escaping (PKPaymentAuthorizationResult) -> Void) -> Status)?
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingContact contact: PKContact, handler: @escaping (PKPaymentRequestShippingContactUpdate) -> Void) {
        let status = self.didSelectShippingContactHandler?(controller, contact, handler) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didSelectShippingContact: contact, handler: handler)
        }
    }
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod, handler: @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) {
        let status = self.didSelectShippingMethodHandler?(controller, shippingMethod, handler) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didSelectShippingMethod: shippingMethod, handler: handler)
        }
    }
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let status = self.didAuthorizePaymentHandler?(controller, payment, handler) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didAuthorizePayment: payment, handler: handler)
        }
    }
    
}

#endif
