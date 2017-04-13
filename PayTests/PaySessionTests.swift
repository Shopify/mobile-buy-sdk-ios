//
//  PaySessionTests.swift
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

import XCTest
import PassKit
@testable import Pay

class PaySessionTests: XCTestCase {
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let session = PaySession(merchantID: "some-id")
        
        XCTAssertEqual(session.merchantID, "some-id")
        XCTAssertFalse(session.identifier.isEmpty)
    }
    
    func testUniqueIdentifier() {
        let session1 = self.createSession()
        let session2 = self.createSession()
        let session3 = self.createSession()
        
        XCTAssertNotEqual(session1.identifier, session2.identifier)
        XCTAssertNotEqual(session2.identifier, session3.identifier)
    }
    
    // ----------------------------------
    //  MARK: - Payment Request -
    //
    func testPaymentRequest() {
        let session  = self.createSession()
        let currency = self.createCurrency()
        
        let digitalCheckout = self.createCheckout(requiresShipping: false)
        let digitalRequest  = session.paymentRequestUsing(digitalCheckout, currency: currency, merchantID: session.merchantID)
        
        XCTAssertEqual(digitalRequest.countryCode,                   currency.countryCode)
        XCTAssertEqual(digitalRequest.currencyCode,                  currency.currencyCode)
        XCTAssertEqual(digitalRequest.merchantIdentifier,            session.merchantID)
        XCTAssertEqual(digitalRequest.requiredBillingAddressFields,  [.all])
        XCTAssertEqual(digitalRequest.requiredShippingAddressFields, [.email, .phone])
        XCTAssertEqual(digitalRequest.supportedNetworks,             [.visa, .masterCard, .amex])
        XCTAssertEqual(digitalRequest.merchantCapabilities,          [.capability3DS])
        XCTAssertFalse(digitalRequest.paymentSummaryItems.isEmpty)
        
        let shippingCheckout = self.createCheckout(requiresShipping: true)
        let shippingRequest  = session.paymentRequestUsing(shippingCheckout, currency: currency, merchantID: session.merchantID)
        
        XCTAssertEqual(shippingRequest.requiredShippingAddressFields, [.all])
    }
    
    func testSelectShippingContactWithInvalidAddress() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            XCTFail()
        }
        
        MockAuthorizationController.invokeDidSelectShippingContact(PKContact()) { status, shippingMethods, summaryItems in
            XCTAssertEqual(status, .invalidShippingPostalAddress)
            XCTAssertEqual(shippingMethods, [])
            XCTAssertEqual(summaryItems, checkout.summaryItems)
        }
    }
    
    func testSelectShippingContactWithEmptyRates() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        let shippingContact    = self.createShippingContact()
        let invalidExpectation = self.expectation(description: "")
        
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            invalidExpectation.fulfill()
            provide(checkout, [])
        }
        
        MockAuthorizationController.invokeDidSelectShippingContact(shippingContact) { status, shippingMethods, summaryItems in
            XCTAssertEqual(status, .invalidShippingPostalAddress)
            XCTAssertEqual(shippingMethods, [])
            XCTAssertEqual(summaryItems, checkout.summaryItems)
        }
        
        self.wait(for: [invalidExpectation], timeout: 0)
    }
    
    func testSelectShippingContact() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        let shippingContact  = self.createShippingContact()
        let shippingAddress  = self.createAddress()
        let shippingRate     = self.createShippingRate()
        let addressCheckout  = self.createCheckout(shippingAddress: shippingAddress)
        let shippingCheckout = self.createCheckout(shippingRate: shippingRate)
        let validExpectation = self.expectation(description: "")
        
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            validExpectation.fulfill()
            
            XCTAssertNil(checkout.shippingAddress)
            XCTAssertNil(checkout.shippingRate)
            
            provide(addressCheckout, [
                shippingRate,
            ])
        }
        
        delegate.didSelectShippingRate = { session, shippingRate, checkout, provide in
            XCTAssertNotNil(checkout.shippingAddress)
            XCTAssertNil(checkout.shippingRate)
            
            provide(shippingCheckout)
        }
        
        MockAuthorizationController.invokeDidSelectShippingContact(shippingContact) { status, shippingMethods, summaryItems in
            
            XCTAssertEqual(status, .success)
            XCTAssertEqual(shippingMethods.count, 1)
            XCTAssertEqual(summaryItems, shippingCheckout.summaryItems)
        }
        
        self.wait(for: [validExpectation], timeout: 0)
    }
    
    private func setupDelegateForMockSessionWith(_ checkout: PayCheckout) -> MockSessionDelegate {
        let session      = self.createSession()
        let delegate     = MockSessionDelegate(session: session)
        session.delegate = delegate
        
        let currency = self.createCurrency()
        
        session.authorizePaymentUsing(checkout, currency: currency)
        
        return delegate
    }
    
    // ----------------------------------
    //  MARK: - PassKit Models -
    //
    private func createShippingMethod() -> PKShippingMethod {
        return PKShippingMethod(label: "CanadaPost", amount: 15.00 as NSDecimalNumber)
    }
    
    private func createShippingContact() -> PKContact {
        let contact  = PKContact()
        contact.name = {
            var c        = PersonNameComponents()
            c.givenName  = "John"
            c.familyName = "Smith"
            return c
        }()
        contact.phoneNumber   = CNPhoneNumber(stringValue: "1234567890")
        contact.postalAddress = self.createPostalAddress()
        contact.emailAddress  = "john.smith@gmail.com"
        
        return contact
    }
    
    private func createPostalAddress() -> CNPostalAddress {
        let address        = CNMutablePostalAddress()
        address.street     = "80 Spadina"
        address.city       = "Toronto"
        address.country    = "Canada"
        address.state      = "ON"
        address.postalCode = "M5V 2J4"
        
        return address.copy() as! CNPostalAddress
    }
    
    // ----------------------------------
    //  MARK: - Pay Models -
    //
    private func createSession() -> PaySession {
        return PaySession(merchantID: "com.merchant.identifier", controllerType: MockAuthorizationController.self)
    }
    
    private func createCurrency() -> PayCurrency {
        return PayCurrency(currencyCode: "USD", countryCode: "US")
    }
    
    private func createCheckout(requiresShipping: Bool = true, shippingAddress: PayAddress? = nil, shippingRate: PayShippingRate? = nil) -> PayCheckout {
        return PayCheckout(
            id: "com.checkout.identifier",
            lineItems: [
                self.createLineItem1(),
                self.createLineItem2(),
            ],
            shippingAddress: shippingAddress,
            shippingRate:    shippingRate,
            discountAmount:  0.0,
            subtotalPrice:   44.0,
            needsShipping:   requiresShipping,
            totalTax:        6.0,
            paymentDue:      50.0
        )
    }
    
    private func createLineItem1() -> PayLineItem {
        return PayLineItem(price: 16.0, quantity: 2)
    }
    
    private func createLineItem2() -> PayLineItem {
        return PayLineItem(price: 12.0, quantity: 1)
    }
    
//    private func createShippingAddress() -> PayPostalAddress {
//        return PayPostalAddress(
//            city:     "Toronto",
//            country:  "Canada",
//            province: "ON",
//            zip:      "M5V 2J4"
//        )
//    }
    
    private func createAddress() -> PayAddress {
        return PayAddress(
            addressLine1: "80 Spadina",
            addressLine2: nil,
            city:         "Toronto",
            country:      "Canada",
            province:     "ON",
            zip:          "M5V 2J4",
            firstName:    "John",
            lastName:     "Smith",
            phone:        "1234567890",
            email:        "john.smith@gmail.com"
        )
    }
    
    private func createShippingRate() -> PayShippingRate {
        return PayShippingRate(handle: "shipping-rate", title: "UPS Standard", price: 12.0)
    }
}

// ---------------------------------------
//  MARK: - MockAuthorizationController -
//
private final class MockAuthorizationController: PKPaymentAuthorizationController {
    
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

// ----------------------------------
//  MARK: - SessionDelegate -
//
private final class MockSessionDelegate: PaySessionDelegate {
    
    var didSelectShippingRate:   ((PaySession, PayShippingRate, PayCheckout, (PayCheckout?) -> Void) -> Void)?
    var didAuthorizePayment:     ((PaySession, PayAuthorization, PayCheckout, (PaySession.TransactionStatus) -> Void) -> Void)?
    var didRequestShippingRates: ((PaySession, PayPostalAddress, PayCheckout, (PayCheckout?, [PayShippingRate]) -> Void) -> Void)?
    var didFinish: ((PaySession) -> Void)?
    
    let session: PaySession
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(session: PaySession) {
        self.session = session
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
    
    func paySessionDidFinish(_ paySession: PaySession) {
        self.didFinish?(paySession)
    }
}
