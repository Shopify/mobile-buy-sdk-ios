//
//  MockAuthorizationController.swift
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

final class MockAuthorizationController: PKPaymentAuthorizationController {
    
    private static var instances: [MockAuthorizationController] = []
    
    // ----------------------------------
    //  MARK: - Instance Management -
    //
    override init(paymentRequest request: PKPaymentRequest) {
        super.init(paymentRequest: request)
        
        type(of: self).instances.append(self)
    }
    
    // ----------------------------------
    //  MARK: - Disable Defaults -
    //
    override func present(completion: ((Bool) -> Void)? = nil) {
        // Do nothing
    }
    
    // ----------------------------------
    //  MARK: - Invoke Delegate Calls -
    //
    static func invokeDidSelectShippingContact(_ contact: PKContact, completion: @escaping (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        
        self.instances.forEach { authorizationController in
            authorizationController.delegate?.paymentAuthorizationController?(authorizationController, didSelectShippingContact: contact, completion: completion)
        }
    }
    
    static func invokeDidAuthorizePayment(_ payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        self.instances.forEach { authorizationController in
            authorizationController.delegate?.paymentAuthorizationController(authorizationController, didAuthorizePayment: payment, completion: completion)
        }
    }
    
    static func invokeDidFinish() {
        self.instances.forEach { authorizationController in
            authorizationController.delegate?.paymentAuthorizationControllerDidFinish(authorizationController)
        }
    }
    
    static func invokeDidSelectShippingMethod(_ shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        
        self.instances.forEach { authorizationController in
            authorizationController.delegate?.paymentAuthorizationController?(authorizationController, didSelectShippingMethod: shippingMethod, completion: completion)
        }
    }
    
    static func invokeDidSelectPaymentMethod(_ paymentMethod: PKPaymentMethod, completion: @escaping ([PKPaymentSummaryItem]) -> Void) {
        
        self.instances.forEach { authorizationController in
            authorizationController.delegate?.paymentAuthorizationController?(authorizationController, didSelectPaymentMethod: paymentMethod, completion: completion)
        }
    }
}
