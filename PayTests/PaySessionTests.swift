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
        let checkout = self.createCheckout()
        let currency = self.createCurrency()
        let session  = PaySession(checkout: checkout, currency: currency, merchantID: "some-id")
        
        XCTAssertEqual(session.merchantID, "some-id")
        XCTAssertEqual(session.checkout.id, checkout.id)
        XCTAssertEqual(session.currency.countryCode, currency.countryCode)
        
        XCTAssertFalse(session.identifier.isEmpty)
    }
    
    func testUniqueIdentifier() {
        let checkout = self.createCheckout()
        let currency = self.createCurrency()
        
        let session1 = self.createSession(checkout: checkout, currency: currency)
        let session2 = self.createSession(checkout: checkout, currency: currency)
        let session3 = self.createSession(checkout: checkout, currency: currency)
        
        XCTAssertNotEqual(session1.identifier, session2.identifier)
        XCTAssertNotEqual(session2.identifier, session3.identifier)
    }
    
    // ----------------------------------
    //  MARK: - Payment Request -
    //
    func testPaymentRequest() {
        let checkout = self.createCheckout()
        let currency = self.createCurrency()
        let session  = self.createSession(checkout: checkout, currency: currency)
        
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
    
    // ----------------------------------
    //  MARK: - Payment Authorization -
    //
    func testPaymentAuthorization() {
        
        let contact      = self.createContact()
        let shippingRate = self.createShippingRate()
        
        let payMethod = MockPaymentMethod(displayName: "John's Mastercard", network: .masterCard, type: .credit)
        let token     = MockPaymentToken(paymentMethod: payMethod)
        let payment   = MockPayment(token: token, billingContact: contact, shippingContact: contact, shippingMethod: shippingRate.summaryItem)
        
        let checkout  = self.createCheckout(requiresShipping: true)
        let delegate  = self.setupDelegateForMockSessionWith(checkout) { session in
            session.shippingRates = [
                shippingRate
            ]
        }
        
        /* -------------------
         ** Success invocation
         */
        delegate.didAuthorizePayment = { session, authorization, checkout, complete in
            
            let tokenString = token.paymentData.map { String($0, radix: 16) }.joined()
            XCTAssertEqual(authorization.token, tokenString)
            XCTAssertEqual(authorization.billingAddress.city,  contact.postalAddress!.city)
            XCTAssertEqual(authorization.shippingAddress.city, contact.postalAddress!.city)
            
            XCTAssertNotNil(authorization.shippingRate)
            XCTAssertEqual(authorization.shippingRate!.handle, shippingRate.handle)
            
            complete(.success)
        }
        
        let expectationSuccess = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidAuthorizePayment(payment) { status in
            XCTAssertEqual(status, .success)
            expectationSuccess.fulfill()
        }
        
        self.wait(for: [expectationSuccess], timeout: 10.0)
        
        /* -------------------
         ** Failure invocation
         */
        delegate.didAuthorizePayment = { session, authorization, checkout, complete in
            complete(.failure)
        }
        
        let expectationFailure = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidAuthorizePayment(payment) { status in
            XCTAssertEqual(status, .failure)
            expectationFailure.fulfill()
        }
        
        self.wait(for: [expectationFailure], timeout: 10.0)
    }
    
    // ----------------------------------
    //  MARK: - Select Shipping Contact -
    //
    func testSelectShippingContactWithInvalidAddress() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            XCTFail()
        }
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingContact(PKContact()) { status, shippingMethods, summaryItems in
            XCTAssertEqual(status, .invalidShippingPostalAddress)
            XCTAssertEqual(shippingMethods, [])
            XCTAssertEqual(summaryItems, checkout.summaryItems)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10.0)
    }
    
    func testSelectShippingContactWithEmptyRates() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        let shippingContact    = self.createContact()
        let invalidExpectation = self.expectation(description: "")
        
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            invalidExpectation.fulfill()
            provide(checkout, [])
        }
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingContact(shippingContact) { status, shippingMethods, summaryItems in
            XCTAssertEqual(status, .invalidShippingPostalAddress)
            XCTAssertEqual(shippingMethods, [])
            XCTAssertEqual(summaryItems, checkout.summaryItems)
            
            expectation.fulfill()
        }
        
        self.wait(for: [invalidExpectation, expectation], timeout: 0)
    }
    
    func testSelectShippingContact() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        let shippingContact  = self.createContact()
        let shippingAddress  = self.createAddress()
        let shippingRate     = self.createShippingRate()
        let addressCheckout  = self.createCheckout(shippingAddress: shippingAddress)
        let shippingCheckout = self.createCheckout(shippingRate: shippingRate)
        
        let e1 = self.expectation(description: "")
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            e1.fulfill()
            
            XCTAssertNil(checkout.shippingAddress)
            XCTAssertNil(checkout.shippingRate)
            
            provide(addressCheckout, [shippingRate])
        }
        
        let e2 = self.expectation(description: "")
        delegate.didSelectShippingRate = { session, shippingRate, checkout, provide in
            e2.fulfill()
            
            XCTAssertNotNil(checkout.shippingAddress)
            XCTAssertNil(checkout.shippingRate)
            
            provide(shippingCheckout)
        }
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingContact(shippingContact) { status, shippingMethods, summaryItems in
            
            XCTAssertEqual(status, .success)
            XCTAssertEqual(shippingMethods.count, 1)
            XCTAssertEqual(summaryItems, shippingCheckout.summaryItems)
            
            expectation.fulfill()
        }
        
        self.wait(for: [e1, e2, expectation], timeout: 0)
    }
    
    func testSelectShippingContactFailure() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        let shippingContact  = self.createContact()
        let shippingAddress  = self.createAddress()
        let shippingRate     = self.createShippingRate()
        let addressCheckout  = self.createCheckout(shippingAddress: shippingAddress)
        
        let e1 = self.expectation(description: "")
        delegate.didRequestShippingRates = { session, postalAddress, checkout, provide in
            e1.fulfill()
            provide(addressCheckout, [shippingRate])
        }
        
        let e2 = self.expectation(description: "")
        delegate.didSelectShippingRate = { session, shippingRate, checkout, provide in
            e2.fulfill()
            
            XCTAssertNotNil(checkout.shippingAddress)
            XCTAssertNil(checkout.shippingRate)
            
            provide(nil)
        }
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingContact(shippingContact) { status, shippingMethods, summaryItems in
            
            XCTAssertEqual(status, .failure)
            XCTAssertTrue(shippingMethods.isEmpty)
            XCTAssertTrue(summaryItems.isEmpty)
            
            expectation.fulfill()
        }
        
        self.wait(for: [e1, e2, expectation], timeout: 0)
    }
    
    // ----------------------------------
    //  MARK: - Select Shipping Method -
    //
    func testSelectShippingMethodWithoutShippingRates() {
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout)
        
        delegate.didSelectShippingRate = { session, shippingRate, checkout, provide in
            XCTFail()
        }
        
        let shippingRate   = self.createShippingRate()
        let shippingMethod = shippingRate.summaryItem
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingMethod(shippingMethod) { status, summaryItems in
            XCTAssertEqual(status, .failure)
            XCTAssertEqual(summaryItems, checkout.summaryItems)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10.0)
    }
    
    func testSelectShippingMethodWithNilCheckout() {
        
        let shippingRate   = self.createShippingRate()
        let shippingMethod = shippingRate.summaryItem
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout) { session in
            
            session.checkout      = checkout
            session.shippingRates = [
                shippingRate
            ]
        }
        
        delegate.didSelectShippingRate = { session, selectedShippingRate, checkoutToUpdate, provide in
            provide(nil)
        }
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingMethod(shippingMethod) { status, summaryItems in
            XCTAssertEqual(status, .failure)
            XCTAssertTrue(summaryItems.isEmpty)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10.0)
    }
    
    func testSelectShippingMethod() {
        
        let shippingRate   = self.createShippingRate()
        let shippingMethod = shippingRate.summaryItem
        
        let checkout = self.createCheckout(requiresShipping: true)
        let delegate = self.setupDelegateForMockSessionWith(checkout) { session in
            
            session.checkout      = checkout
            session.shippingRates = [
                shippingRate
            ]
        }
        
        let updatedCheckout = self.createCheckout(
            requiresShipping: true,
            shippingRate:     shippingRate
        )
        
        delegate.didSelectShippingRate = { session, selectedShippingRate, checkoutToUpdate, provide in
            provide(updatedCheckout)
        }
        
        XCTAssertNil(checkout.shippingRate)
        
        let expectation = self.expectation(description: "")
        
        MockAuthorizationController.invokeDidSelectShippingMethod(shippingMethod) { status, summaryItems in
            XCTAssertEqual(status, .success)
            XCTAssertEqual(updatedCheckout.summaryItems, summaryItems)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 10.0)
    }
    
    // ----------------------------------
    //  MARK: - Payment Authorization -
    //
    func testAuthorizationFinished() {
        
        let checkout    = self.createCheckout(requiresShipping: true)
        let delegate    = self.setupDelegateForMockSessionWith(checkout)
        let expectation = self.expectation(description: "")
        
        delegate.didFinish = { session in
            expectation.fulfill()
        }
        MockAuthorizationController.invokeDidFinish()
        
        self.wait(for: [expectation], timeout: 10)
    }
    
    // ----------------------------------
    //  MARK: - Session Delegate -
    //
    private func setupDelegateForMockSessionWith(_ checkout: PayCheckout, configure: ((PaySession) -> Void)? = nil) -> MockSessionDelegate {
        let currency = self.createCurrency()
        let session  = self.createSession(checkout: checkout, currency: currency)
        let delegate = MockSessionDelegate(session: session)
        
        configure?(session)
        
        session.authorize()
        
        return delegate
    }
}

// ----------------------------------
//  MARK: - Models -
//
extension PaySessionTests {
    
    // ----------------------------------
    //  MARK: - PassKit Models -
    //
    fileprivate func createShippingMethod(identifier: String? = nil) -> PKShippingMethod {
        let method        = PKShippingMethod(label: "CanadaPost", amount: 15.00 as NSDecimalNumber)
        method.identifier = identifier
        return method
    }
    
    fileprivate func createContact() -> PKContact {
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
    
    fileprivate func createPostalAddress() -> CNPostalAddress {
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
    fileprivate func createSession(checkout: PayCheckout, currency: PayCurrency) -> PaySession {
        return PaySession(checkout: checkout, currency: currency, merchantID: "com.merchant.identifier", controllerType: MockAuthorizationController.self)
    }
    
    fileprivate func createCurrency() -> PayCurrency {
        return PayCurrency(currencyCode: "USD", countryCode: "US")
    }
    
    fileprivate func createCheckout(requiresShipping: Bool = true, shippingAddress: PayAddress? = nil, shippingRate: PayShippingRate? = nil) -> PayCheckout {
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
    
    fileprivate func createLineItem1() -> PayLineItem {
        return PayLineItem(price: 16.0, quantity: 2)
    }
    
    fileprivate func createLineItem2() -> PayLineItem {
        return PayLineItem(price: 12.0, quantity: 1)
    }
    
    fileprivate func createAddress() -> PayAddress {
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
    
    fileprivate func createShippingRate() -> PayShippingRate {
        return PayShippingRate(handle: "shipping-rate", title: "UPS Standard", price: 12.0)
    }
}
