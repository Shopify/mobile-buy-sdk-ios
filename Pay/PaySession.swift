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

/// The delegate will be called when user interaction modifies the information
/// that affects checkout. Whenever such events occur, you should perform any
/// API calls required to mutate the existing checkout and provide the updated
/// object in the `provide` handler.
///
@available(iOS 10.0, *)
public protocol PaySessionDelegate: class {

    /// This callback is invoked if the user updates the `shippingContact` and the current address used for shipping is invalidated.
    /// You should make any necessary API calls to obtain shipping rates here and provide an array of `PayShippingRate` objects.
    ///
    /// - parameters:
    ///     - paySession: The session that invoked the callback.
    ///     - address:    A partial address that you can use to obtain relevant shipping rates. This address is missing `addressLine1` and `addressLine2`. This information is only available after the user has authorized payment.
    ///     - checkout:   The current checkout state.
    ///     - provide:    A completion handler that **must** be invoked with an updated `PayCheckout` and an array of `[PayShippingRate]`. If the `PayPostalAddress` is invalid or you were unable to obtain shipping rates, then returning `nil` or empty shipping rates will result in an invalid address error in Apple Pay.
    ///
    /// - Important:
    /// The `address` passed into this method is _partial_, and doesn't include address lines or a complete zip / postal code. It is sufficient for obtaining shipping rates _only_. **You must update the checkout with a full address before completing the payment.** The complete address will be available in `paySession(_:didAuthorizePayment:checkout:completeTransaction:)`.
    ///
    func paySession(_ paySession: PaySession, didRequestShippingRatesFor address: PayPostalAddress, checkout: PayCheckout, provide: @escaping (PayCheckout?, [PayShippingRate]) -> Void)

    /// This callback is invoked if the user updates the `shippingContact` and the current address is invalidated. This method is called *only* for
    /// checkouts that don't require shipping.
    /// You should make any necessary API calls to update the checkout with the provided address in order to obtain accurate tax information.
    ///
    /// - parameters:
    ///     - paySession: The session that invoked the callback.
    ///     - address:    A partial address that you can use to obtain relevant tax information for the checkout. This address is missing `addressLine1` and `addressLine2`. This information is only available after the user has authorized payment.
    ///     - checkout:   The current checkout state.
    ///     - provide:    A completion handler that **must** be invoked with an updated `PayCheckout`. Returning `nil` will result in a generic failure in the Apple Pay dialog.
    ///
    /// - Important:
    /// The `address` passed into this method is _partial_, and doesn't include address lines or a complete zip / postal code. It is sufficient for obtaining shipping rates _only_. **You must update the checkout with a full address before completing the payment.** The complete address will be available in `paySession(_:didAuthorizePayment:checkout:completeTransaction:)`.
    ///
    func paySession(_ paySession: PaySession, didUpdateShippingAddress address: PayPostalAddress, checkout: PayCheckout, provide: @escaping (PayCheckout?) -> Void)
    
    /// This callback is invoked when the user selects a shipping rate or an initial array of shipping rates is provided. In the latter case, the first shipping rate in the array will be used. You should make any necessary API calls to update the checkout with the selected shipping rate here.
    ///
    /// - parameters:
    ///     - paySession:   The session that invoked the callback.
    ///     - shippingRate: The selected shipping rate.
    ///     - checkout:     The current checkout state.
    ///     - provide:      A completion handler that **must** be invoked with an updated `PayCheckout`. Returning `nil` will result in a generic failure in the Apple Pay dialog.
    ///
    func paySession(_ paySession: PaySession, didSelectShippingRate shippingRate: PayShippingRate, checkout: PayCheckout, provide: @escaping (PayCheckout?) -> Void)

    /// This callback is invoked when the user authorizes payment using Touch ID or passcode. You should make necessary API calls to update and complete the checkout with final information here (eg: billing address).
    ///
    /// - parameters:
    ///     - paySession:          The session that invoked the callback.
    ///     - authorization:       Authorization object that encapsulates the token and other relevant information: billing address, complete shipping address, and shipping rate.
    ///     - checkout:            The current checkout state.
    ///     - completeTransaction: A completion handler that **must** be invoked with the final transaction status.
    ///
    /// - Important:
    /// If you previously set a partial address on checkout (eg: for obtaining shipping rates), you **MUST** update the checkout with the complete address provided by `authorization.shippingAddress`.
    ///
    func paySession(_ paySession: PaySession, didAuthorizePayment authorization: PayAuthorization, checkout: PayCheckout, completeTransaction: @escaping (PaySession.TransactionStatus) -> Void)

    /// This callback is invoked when the Apple Pay authorization controller is dismissed.
    ///
    /// - parameters:
    ///     - paySession: The session that invoked the callback.
    ///
    func paySessionDidFinish(_ paySession: PaySession)
}

/// The `PaySession` coordinates the communication
/// between `PKPaymentAuthorizationController` and your application to
/// provide easier support for Apple Pay.
///
@available(iOS 10.0, *)
public class PaySession: NSObject {

    /// A status that determines whether a transaction has completed
    /// successfully or failed.
    ///
    public enum TransactionStatus {
        case success
        case failure
    }

    /// A delegate for receiving updates from `PaySession`.
    public weak var delegate: PaySessionDelegate?
    
    /// Types of credit cards accepted for payment.
    public var acceptedCardBrands: [PayCardBrand] = [.visa, .masterCard, .americanExpress]
    
    /// The name of your shop. Display in the Apple Pay dialog
    /// during checkout. It is _very_ important that `shopName`
    /// accurately reflects the shop customers will be paying to.
    public let shopName: String

    /// The currency description that will be used in this Apple Pay transaction.
    public let currency: PayCurrency

    /// The merchant ID provided on initialization. It should match the merchant ID used to setup Apple Pay in the developer portal.
    public let merchantID: String

    /// Idempotency identifier of this session.
    public let identifier: String

    internal var checkout:      PayCheckout
    internal var shippingRates: [PayShippingRate] = []

    private let controllerType: PKPaymentAuthorizationController.Type

    // ----------------------------------
    //  MARK: - Init -
    //
    /// An instance of `PaySession` represents a single transaction using Apple Pay.
    /// To create one requires a `PayCheckout` and `PayCurrency`.
    ///
    /// - parameters:
    ///     - checkout: A `PayCheckout` that will be used to create summary items.
    ///     - currency: Represents the country and currency that will be used for the transaction.
    ///     - merchantID: The merchant ID that you've registered to use for Apple Pay.
    ///     - controllerType: Reserved for testing.
    ///
    public init(shopName: String, checkout: PayCheckout, currency: PayCurrency, merchantID: String, controllerType: PKPaymentAuthorizationController.Type = PKPaymentAuthorizationController.self) {
        self.shopName       = shopName
        self.checkout       = checkout
        self.currency       = currency
        self.merchantID     = merchantID
        self.identifier     = UUID().uuidString
        self.controllerType = controllerType
        
        super.init()
    }
    
    @available(*, deprecated, message: "PaySession requires a shop name to display during checkout. Use init(shopName:checkout:currency:merchantID:controllerType:) instead.")
    public convenience init(checkout: PayCheckout, currency: PayCurrency, merchantID: String, controllerType: PKPaymentAuthorizationController.Type = PKPaymentAuthorizationController.self) {
        self.init(shopName: "TOTAL", checkout: checkout, currency: currency, merchantID: merchantID, controllerType: controllerType)
    }

    // ----------------------------------
    //  MARK: - Begin Checkout -
    //
    /// Invoking `authorize()` will create a payment request and present the
    /// Apple Pay dialog. The `delegate` will then be called when the user
    /// begins changing billing address, shipping address, and shipping rates.
    ///
    public func authorize() {
        let paymentRequest  = self.paymentRequestUsing(self.checkout, currency: self.currency, merchantID: self.merchantID)
        let controller      = self.controllerType.init(paymentRequest: paymentRequest)
        controller.delegate = self
        controller.present(completion: nil)
    }

    // ----------------------------------
    //  MARK: - Payment Creation -
    //
    func paymentRequestUsing(_ checkout: PayCheckout, currency: PayCurrency, merchantID: String) -> PKPaymentRequest {
        let request                           = PKPaymentRequest()
        request.countryCode                   = currency.countryCode
        request.currencyCode                  = currency.currencyCode
        request.merchantIdentifier            = merchantID
        request.requiredBillingAddressFields  = .all
        request.requiredShippingAddressFields = .all
        request.supportedNetworks             = self.acceptedCardBrands.paymentNetworks
        request.merchantCapabilities          = [.capability3DS]
        request.paymentSummaryItems           = checkout.summaryItems(for: self.shopName)

        return request
    }
}

// ------------------------------------------------------
//  MARK: - PKPaymentAuthorizationControllerDelegate -
//
@available(iOS 10.0, *)
extension PaySession: PKPaymentAuthorizationControllerDelegate {

    // -------------------------------------------------------
    //  MARK: - PKPaymentAuthorizationControllerDelegate -
    //
    @available(iOS 11.0, watchOS 4.0, *)
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        self.paymentAuthorizationController(controller, didAuthorizePayment: payment) { (status: PKPaymentAuthorizationStatus) in
            let result = PKPaymentAuthorizationResult(status: status, errors: nil)
            completion(result)
        }
    }
    
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {

        var shippingRate: PayShippingRate?

        if self.checkout.needsShipping {
            shippingRate = self.shippingRates.shippingRateFor(payment.shippingMethod!)
        }

        /* -----------------------------------------------
         ** The PKPayment object provides `billingContact`
         ** and `shippingContact` only when required fields
         ** are set on the payment request, which they are.
         ** We can then safely force-unwrap both contacts.
         */
        let authorization = PayAuthorization(
            paymentData:     payment.token.paymentData,
            billingAddress:  PayAddress(with: payment.billingContact!),
            shippingAddress: PayAddress(with: payment.shippingContact!),
            shippingRate:    shippingRate
        )
        
        Log("Authorized payment. Completing...")
        self.delegate?.paySession(self, didAuthorizePayment: authorization, checkout: self.checkout, completeTransaction: { status in
            Log("Completion status : \(status)")
        
            switch status {
            case .success: completion(.success)
            case .failure: completion(.failure)
            }
        })
    }
    
    @available(iOS 11.0, watchOS 4.0, *)
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingContact contact: PKContact, handler completion: @escaping (PKPaymentRequestShippingContactUpdate) -> Void) {
        
        self.paymentAuthorizationController(controller, didSelectShippingContact: contact) { status, shippingMethod, summaryItems in
            let result    = PKPaymentRequestShippingContactUpdate(errors: nil, paymentSummaryItems: summaryItems, shippingMethods: shippingMethod)
            result.status = status
            completion(result)
        }
    }

    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingContact contact: PKContact, completion: @escaping (PKPaymentAuthorizationStatus, [PKShippingMethod], [PKPaymentSummaryItem]) -> Void) {
        Log("Selecting shipping contact...")
        
        guard let postalAddress = contact.postalAddress else {
            completion(.invalidShippingPostalAddress, [], self.checkout.summaryItems(for: self.shopName))
            return
        }

        let payPostalAddress = PayPostalAddress(with: postalAddress)
        
        /* ---------------------------------
         ** If the checkout doesn't require
         ** shipping, we still need to notify
         ** the delegate about the shipping
         ** address but we have to skip fetching
         ** shipping rates.
         */
        guard self.checkout.needsShipping else {
            Log("Checkout doesn't require shipping. Updating address...")
            
            self.delegate?.paySession(self, didUpdateShippingAddress: payPostalAddress, checkout: self.checkout, provide: { updatedCheckout in
                if let updatedCheckout = updatedCheckout {
                    self.checkout = updatedCheckout
                    
                    completion(.success, [], updatedCheckout.summaryItems(for: self.shopName))
                } else {
                    completion(.failure, [], [])
                }
            })
            return
        }

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
                completion(.invalidShippingPostalAddress, [], self.checkout.summaryItems(for: self.shopName))
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
                    
                    Log("Selected shipping contact.")
                    completion(.success, shippingRates.summaryItems, updatedCheckout.summaryItems(for: self.shopName))
                } else {
                    completion(.failure, [], [])
                }
            })
        })
    }
    
    @available(iOS 11.0, watchOS 4.0, *)
    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod, handler completion: @escaping (PKPaymentRequestShippingMethodUpdate) -> Void) {
        self.paymentAuthorizationController(controller, didSelectShippingMethod: shippingMethod) { status, summaryItems in
            let result    = PKPaymentRequestShippingMethodUpdate(paymentSummaryItems: summaryItems)
            result.status = status
            completion(result)
        }
    }

    public func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didSelectShippingMethod shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        Log("Selecting delivery method...")
        
        /* --------------------------------------
         ** This should never fail since shipping
         ** methods are mapped 1:1 from shipping
         ** rates.
         */
        guard let shippingRate = self.shippingRates.shippingRateFor(shippingMethod) else {
            completion(.failure, self.checkout.summaryItems(for: self.shopName))
            return
        }

        self.delegate?.paySession(self, didSelectShippingRate: shippingRate, checkout: self.checkout, provide: { updatedCheckout in
            if let updatedCheckout = updatedCheckout {
                self.checkout = updatedCheckout
                
                Log("Selected delivery method.")
                completion(.success, updatedCheckout.summaryItems(for: self.shopName))
            } else {
                completion(.failure, [])
            }
        })
    }

    public func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        
        Log("Dismissing authorization controller.")
        controller.dismiss(completion: nil)

        self.delegate?.paySessionDidFinish(self)
    }
}
