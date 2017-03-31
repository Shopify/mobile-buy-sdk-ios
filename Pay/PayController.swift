//
//  PayController.swift
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
import PassKit

public protocol PayControllerDelegate: class {
    func payController(_ payController: PayController, didRequestShippingRatesFor address: PayPostalAddress, provide: @escaping (PayCheckout, [PayShippingRate]) -> Void)
    func payController(_ payController: PayController, didSelectShippingRate shippingRate: PayShippingRate, provide: @escaping  (PayCheckout) -> Void)
    func payController(_ payController: PayController, didCompletePayment token: Data, checkout: PayCheckout, completeTransaction: @escaping (PayController.TransactionStatus) -> Void)
    func payControllerDidFinish(_ payController: PayController)
}

public class PayController: NSObject {
    
    public enum TransactionStatus {
        case success
        case failure
    }
    
    public weak var delegate: PayControllerDelegate?
    
    public let merchantID: String
    
    public fileprivate(set) var currency:      PayCurrency?
    public fileprivate(set) var checkout:      PayCheckout?
    public fileprivate(set) var shippingRates: [PayShippingRate]?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(merchantID: String) {
        self.merchantID = merchantID
    }
    
    // ----------------------------------
    //  MARK: - Begin Checkout -
    //
    public func authorizePaymentUsing(_ checkout: PayCheckout, currency: PayCurrency) {
        self.checkout = checkout
        self.currency = currency
        
        let paymentRequest  = self.paymentRequestUsing(checkout, currency: currency, merchantID: self.merchantID)
        let controller      = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        controller.delegate = self
        controller.present(completion: nil)
    }
    
    // ----------------------------------
    //  MARK: - Payment Creation -
    //
    private func paymentRequestUsing(_ checkout: PayCheckout, currency: PayCurrency, merchantID: String) -> PKPaymentRequest {
        let request                           = PKPaymentRequest()
        request.countryCode                   = currency.countryCode
        request.currencyCode                  = currency.currencyCode
        request.merchantIdentifier            = merchantID
        request.requiredBillingAddressFields  = .all
        request.requiredShippingAddressFields = checkout.needsShipping ? [.all] : [.email, .phone]
        request.supportedNetworks             = [.visa, .masterCard, .amex]
        request.merchantCapabilities          = [.capability3DS]
        request.paymentSummaryItems           = checkout.summaryItems
        
        return request
    }
}

// ------------------------------------------------------
//  MARK: - PKPaymentAuthorizationControllerDelegate -
//
extension PayController: PKPaymentAuthorizationControllerDelegate {
    
    // -------------------------------------------------------
    //  MARK: - PKPaymentAuthorizationControllerDelegate -
    //
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
     
        print("Authorized payment. Completing...")
        self.delegate?.payController(self, didCompletePayment: payment.token.paymentData, checkout: self.checkout!, completeTransaction: { status in
            
            print("Completion status : \(status)")
            
            switch status {
            case .success: completion(.success)
            case .failure: completion(.failure)
            }
        })
    }
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingContact contact: PKContact, completion: @escaping (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        print("Selecting shipping contact...")
        
        guard let postalAddress = contact.postalAddress else {
            completion(.invalidShippingPostalAddress, [], self.checkout!.summaryItems)
            return
        }
        
        let payPostalAddress = PayPostalAddress(with: postalAddress)
        
        /* ---------------------------------
         ** Request the delegate to provide
         ** shipping rates for the given
         ** postal address. The partial info
         ** should be enough to obtain rates.
         */
        self.delegate?.payController(self, didRequestShippingRatesFor: payPostalAddress, provide: { updatedCheckout, shippingRates in
            
            /* ---------------------------------
             ** The delegate has an opportunity
             ** to return empty shipping rates
             ** which indicates invalid or incomplete
             ** postal address.
             */
            guard !shippingRates.isEmpty else {
                completion(.invalidShippingPostalAddress, [], self.checkout!.summaryItems)
                return
            }
            
            self.checkout      = updatedCheckout
            self.shippingRates = shippingRates
            
            /* -----------------------------------------
             ** Give the delegate a chance to update the
             ** checkout with the first shipping rate as
             ** the default. Apple Pay selects it but
             ** doesn't invoke the delegate method.
             */
            self.delegate?.payController(self, didSelectShippingRate: shippingRates.first!, provide: { updatedCheckout in
                self.checkout = updatedCheckout
                
                print("Selected shipping contact.")
                completion(.success, shippingRates.summaryItems, updatedCheckout.summaryItems)
            })
        })
    }
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        print("Selecting delivery method...")
        
        /* --------------------------------------
         ** This should never fail since shipping
         ** methods are mapped 1:1 from shipping
         ** rates.
         */
        guard let shippingRate = self.shippingRates!.shippingRateFor(shippingMethod) else {
            completion(.failure, self.checkout!.summaryItems)
            return
        }
        
        self.delegate?.payController(self, didSelectShippingRate: shippingRate, provide: { updatedCheckout in
            self.checkout = updatedCheckout
            
            print("Selected delivery method.")
            completion(.success, updatedCheckout.summaryItems)
        })
    }
    
    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        
        print("Dismissing authorization controller.")
        controller.dismiss(completion: nil)
        
        self.delegate?.payControllerDidFinish(self)
    }
}
