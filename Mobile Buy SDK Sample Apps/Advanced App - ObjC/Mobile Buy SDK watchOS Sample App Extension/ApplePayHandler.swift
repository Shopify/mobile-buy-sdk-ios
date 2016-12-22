//
//  ApplePayHandler.swift
//  Mobile Buy SDK Advanced Sample
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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
import Buy
import WatchKit

class ApplePayHandler: NSObject, BUYPaymentProviderDelegate {
    
    var checkout: BUYCheckout!
    var dataProvider: DataProvider!
    var interfaceController: WKInterfaceController!
    var paymentController: BUYPaymentController!
    var paymentProvider: BUYApplePayPaymentProvider!
    
    init(dataProvider: DataProvider, interfaceController: WKInterfaceController) {
        super.init()
        self.dataProvider = dataProvider
        self.interfaceController = interfaceController
        self.interfaceController.pushController(withName: "LoadingInterfaceController", context: nil)
        self.paymentController = BUYPaymentController.init()
        self.setupPaymentProvider()
    }
    
    /// Sets up the `BUYApplePayPaymentProvider` using the `BUYClient` and adds it to the `BUYPaymentController`
    private func setupPaymentProvider() {
        self.paymentProvider = BUYApplePayPaymentProvider.init(client: self.dataProvider.getClient(), merchantID: self.dataProvider.merchantId)
        self.paymentProvider.delegate = self
        self.paymentController.add(self.paymentProvider)
    }
    
    /// Checkout with Apple Pay (if available) given the `BUYProductVariant` the user wants to buy
    ///
    /// - Parameter variant: the `BUYProductVariant` the user wants to buy
    func checkoutWithApplePay(variant: BUYProductVariant) {
        if self.isApplePayAvailable() {
            self.checkout = self.checkoutWithVariant(variant: variant)
            self.startApplePayCheckout(checkout: self.checkout)
        }
    }
    
    /// Starts the Apple Pay checkout process by using the `BUYApplePayPaymentProvider`
    ///
    /// - Parameter checkout: the `BUYCheckout` associated with the checkout process
    private func startApplePayCheckout(checkout: BUYCheckout) {
        if ((self.paymentProvider.delegate != nil) && (self.paymentProvider.delegate?.responds(to: #selector(BUYPaymentProviderDelegate.paymentProvider(_:wantsPaymentControllerPresented:))))!) {
                self.paymentController.start(checkout, withProviderType: BUYApplePayPaymentProviderId)
        }
    }
    
    /// Creates a `BUYCheckout` given the `BUYProductVariant`
    ///
    /// - Parameter variant: the `BUYProductVariant`
    /// - Returns: a `BUYCheckout` containing the `BUYProductVariant`
    private func checkoutWithVariant(variant: BUYProductVariant) -> BUYCheckout {
        let modelManager = self.dataProvider.getClient().modelManager
        let cart = modelManager.insertCart(withJSONDictionary: nil)
        cart?.add(variant)
        return modelManager.checkout(with: cart!)
    }
    
    /// Checks if Apple Pay is available through the `BUYApplePayPaymentProvider`
    ///
    /// - Returns: true if Apple Pay is available, else false
    private func isApplePayAvailable() -> Bool {
        return self.paymentProvider.isAvailable
    }
    
    /// Called when a `PKPaymentAuthorizationController` needs to be dismissed
    ///
    /// - Parameter provider: the `BUYPaymentProvider`
    func paymentProviderWantsControllerDismissed(_ provider: BUYPaymentProvider) {
        self.interfaceController.pop()
    }
    
    /// Called when a `PKPaymentAuthorizationController` needs to be presented
    ///
    /// - Parameters:
    ///   - provider: the `BUYPaymentProvider`
    ///   - controller: the `PKPaymentAuthorizationController` that needs to be presented
    func paymentProvider(_ provider: BUYPaymentProvider, wantsPaymentControllerPresented controller: PKPaymentAuthorizationController) {
        controller.present(completion: nil)
    }
}
