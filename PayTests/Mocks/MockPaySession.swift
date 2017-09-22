//
//  MockPaySession.swift
//  PayTests
//
//  Created by Dima Bart on 2017-09-20.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import Foundation
import PassKit
@testable import Pay

@available(iOS 11.0, *)
class MockPaySession: PaySession {
    
    enum Status {
        case handled
        case unhandled
    }
    
    // ----------------------------------
    //  MARK: - iOS 11 -
    //
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
    
    // ----------------------------------
    //  MARK: - Delegate Callbacks -
    //
    var didSelectShippingContact: ((PKPaymentAuthorizationController, PKContact,        @escaping (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) -> Status)?
    var didSelectShippingMethod:  ((PKPaymentAuthorizationController, PKShippingMethod, @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) -> Status)?
    var didAuthorizePayment:      ((PKPaymentAuthorizationController, PKPayment,        @escaping (PKPaymentAuthorizationStatus) -> Void) -> Status)?
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingContact contact: PKContact, completion: @escaping (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        let status = self.didSelectShippingContact?(controller, contact, completion) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didSelectShippingContact: contact, completion: completion)
        }
    }
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        let status = self.didSelectShippingMethod?(controller, shippingMethod, completion) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didSelectShippingMethod: shippingMethod, completion: completion)
        }
    }
    
    override func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        let status = self.didAuthorizePayment?(controller, payment, completion) ?? .unhandled
        if status == .unhandled {
            super.paymentAuthorizationController(controller, didAuthorizePayment: payment, completion: completion)
        }
    }
}
