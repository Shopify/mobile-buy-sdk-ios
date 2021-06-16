//
//  Models.swift
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

#if canImport(PassKit)

import Foundation
import PassKit
import Pay

@available(iOS 11.0, *)
struct Models {
    
    static func createShippingMethod(identifier: String? = nil) -> PKShippingMethod {
        let method        = PKShippingMethod(label: "CanadaPost", amount: 15.00 as NSDecimalNumber)
        method.identifier = identifier
        return method
    }
    
    static func createContact() -> PKContact {
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
    
    static func createPostalAddress() -> CNPostalAddress {
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
    static func createSession(checkout: PayCheckout, currency: PayCurrency) -> MockPaySession {
        return MockPaySession(shopName: "Jaded Labs", checkout: checkout, currency: currency, merchantID: "com.merchant.identifier", controllerType: MockAuthorizationController.self)
    }
    
    static func createGiftCard() -> PayGiftCard {
        return PayGiftCard(
            id: "123",
            balance: 20.00,
            amount: 5.00,
            lastCharacters: "A1B2"
        )
    }
    
    static func createGiftCardSecondary() -> PayGiftCard {
        return PayGiftCard(
            id: "234",
            balance: 10.00,
            amount: 2.50,
            lastCharacters: "C3D4"
        )
    }
    
    static func createDiscount() -> PayDiscount {
        return PayDiscount(code: "WIN20", amount: 20.0)
    }
    
    static func createShippingDiscount() -> PayDiscount {
        return PayDiscount(code: "FREESHIP", amount: 10.0)
    }
    
    static func createAnonymousDiscount() -> PayDiscount {
        return PayDiscount(code: "", amount: 20.0)
    }
    
    static func createAnonymousShippingDiscount() -> PayDiscount {
        return PayDiscount(code: "", amount: 10.0)
    }
    
    static func createCurrency() -> PayCurrency {
        return PayCurrency(currencyCode: "USD", countryCode: "US")
    }
    
    static func createCheckout(requiresShipping: Bool = true, giftCards: [PayGiftCard]? = nil, discount: PayDiscount? = nil, shippingDiscount: PayDiscount? = nil, shippingAddress: PayAddress? = nil, shippingRate: PayShippingRate? = nil, duties: Decimal? = nil, empty: Bool = false, hasTax: Bool = true) -> PayCheckout {
        
        let lineItems = [
            self.createLineItem1(),
            self.createLineItem2(),
        ]
        
        return PayCheckout(
            id:               "123",
            lineItems:        !empty ? lineItems : [],
            giftCards:        giftCards,
            discount:         discount,
            shippingDiscount: shippingDiscount,
            shippingAddress:  shippingAddress,
            shippingRate:     shippingRate,
            currencyCode:     "CAD",
            totalDuties:      duties,
            subtotalPrice:    44.0,
            needsShipping:    requiresShipping,
            totalTax:         hasTax ? 6.0 : 0.0,
            paymentDue:       50.0
        )
    }
    
    static func createLineItem1() -> PayLineItem {
        return PayLineItem(price: 16.0, quantity: 2)
    }
    
    static func createLineItem2() -> PayLineItem {
        return PayLineItem(price: 12.0, quantity: 1)
    }
    
    static func createAddress() -> PayAddress {
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
    
    static func createShippingRate() -> PayShippingRate {
        return PayShippingRate(handle: "shipping-rate", title: "UPS Standard", price: 12.0)
    }
    
    static func createShippingRates() -> [PayShippingRate] {
        return [
            PayShippingRate(handle: "123", title: "USPS",  price: 11.0),
            PayShippingRate(handle: "234", title: "UPS",   price: 12.0),
            PayShippingRate(handle: "345", title: "FexEx", price: 13.0),
        ]
    }
    
    static func createDeliveryRangeFromSingle() -> (orderDate: Date, range: PayShippingRate.DeliveryRange) {
        let order = Date(timeIntervalSince1970: 1483228800)
        let from  = Date(timeIntervalSince1970: 1483315200)
        
        return (order, PayShippingRate.DeliveryRange(from: from))
    }
    
    static func createDeliveryRangeFromMulti() -> (orderDate: Date, range: PayShippingRate.DeliveryRange) {
        let order = Date(timeIntervalSince1970: 1483228800)
        let from  = Date(timeIntervalSince1970: 1483401600)
        
        return (order, PayShippingRate.DeliveryRange(from: from))
    }
    
    static func createDeliveryRange() -> (orderDate: Date, range: PayShippingRate.DeliveryRange) {
        let order = Date(timeIntervalSince1970: 1483228800)
        let from  = Date(timeIntervalSince1970: 1483315200)
        let to    = Date(timeIntervalSince1970: 1483747200)
        
        return (order, PayShippingRate.DeliveryRange(from: from, to: to))
    }
}

#endif
