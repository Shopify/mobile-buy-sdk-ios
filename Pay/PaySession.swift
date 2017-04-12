//
//  PaySession.swift
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

public protocol PaySessionDelegate: class {
    func paySession(_ paySession: PaySession, didRequestShippingRatesFor address: PayPostalAddress, checkout: PayCheckout, provide: @escaping (PayCheckout?, [PayShippingRate]) -> Void)
    func paySession(_ paySession: PaySession, didSelectShippingRate shippingRate: PayShippingRate, checkout: PayCheckout, provide: @escaping (PayCheckout?) -> Void)
    func paySession(_ paySession: PaySession, didAuthorizePayment authorization: PayAuthorization, checkout: PayCheckout, completeTransaction: @escaping (PaySession.TransactionStatus) -> Void)
    
    func paySessionDidFinish(_ paySession: PaySession)
}

public class PaySession: NSObject {
    
    public enum TransactionStatus {
        case success
        case failure
    }
    
    public weak var delegate: PaySessionDelegate?
    
    public let currency:   PayCurrency
    public let merchantID: String
    public let identifier: String
    
    internal fileprivate(set) var checkout:      PayCheckout
    internal fileprivate(set) var shippingRates: [PayShippingRate] = []
    
    private let controllerType: PKPaymentAuthorizationController.Type
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(checkout: PayCheckout, currency: PayCurrency, merchantID: String, controllerType: PKPaymentAuthorizationController.Type = PKPaymentAuthorizationController.self) {
        self.checkout       = checkout
        self.currency       = currency
        self.merchantID     = merchantID
        self.identifier     = UUID().uuidString
        self.controllerType = controllerType
    }
    
    // ----------------------------------
    //  MARK: - Begin Checkout -
    //
    public func authorize() {
        let paymentRequest  = self.paymentRequestUsing(checkout, currency: currency, merchantID: self.merchantID)
        let controller      = self.controllerType.init(paymentRequest: paymentRequest)
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
extension PaySession: PKPaymentAuthorizationControllerDelegate {
    
    // -------------------------------------------------------
    //  MARK: - PKPaymentAuthorizationControllerDelegate -
    //
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
     
        /* -----------------------------------------------
         ** The PKPayment object provides `billingContact`
         ** and `shippingContact` only when required fields
         ** are set on the payment request, which they are.
         ** We can then safely force-unwrap both contacts.
         */
        let authorization = PayAuthorization(
            token:           payment.token.paymentData.hexString,
            billingAddress:  PayAddress(with: payment.billingContact!),
            shippingAddress: PayAddress(with: payment.shippingContact!),
            shippingRate:    self.shippingRates.shippingRateFor(payment.shippingMethod!)
        )
        
        print("Authorized payment. Completing...")
        self.delegate?.paySession(self, didAuthorizePayment: authorization, checkout: self.checkout, completeTransaction: { status in
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
            completion(.invalidShippingPostalAddress, [], self.checkout.summaryItems)
            return
        }
        
        let payPostalAddress = PayPostalAddress(with: postalAddress)
        
        /* ---------------------------------
         ** Request the delegate to provide
         ** shipping rates for the given
         ** postal address. The partial info
         ** should be enough to obtain rates.
         */
        self.delegate?.paySession(self, didRequestShippingRatesFor: payPostalAddress, checkout: self.checkout, provide: { updatedCheckout, shippingRates in
            
            /* ---------------------------------
             ** The delegate has an opportunity
             ** to return empty shipping rates
             ** which indicates invalid or incomplete
             ** postal address.
             */
            guard let updatedCheckout = updatedCheckout, !shippingRates.isEmpty else {
                completion(.invalidShippingPostalAddress, [], self.checkout.summaryItems)
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
            self.delegate?.paySession(self, didSelectShippingRate: shippingRates.first!, checkout: updatedCheckout, provide: { updatedCheckout in
                if let updatedCheckout = updatedCheckout {
                    self.checkout = updatedCheckout
                    
                    print("Selected shipping contact.")
                    completion(.success, shippingRates.summaryItems, updatedCheckout.summaryItems)
                } else {
                    completion(.failure, [], [])
                }
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
        guard let shippingRate = self.shippingRates.shippingRateFor(shippingMethod) else {
            completion(.failure, self.checkout.summaryItems)
            return
        }
        
        self.delegate?.paySession(self, didSelectShippingRate: shippingRate, checkout: self.checkout, provide: { updatedCheckout in
            if let updatedCheckout = updatedCheckout {
                self.checkout = updatedCheckout
                
                print("Selected delivery method.")
                completion(.success, updatedCheckout.summaryItems)
            } else {
                completion(.failure, [])
            }
        })
    }
    
    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        
        print("Dismissing authorization controller.")
        controller.dismiss(completion: nil)
        
        self.delegate?.paySessionDidFinish(self)
    }
}

private extension Data {
    
    var hexString: String {
        return self.map { String($0, radix: 16) }.joined()
    }
}
