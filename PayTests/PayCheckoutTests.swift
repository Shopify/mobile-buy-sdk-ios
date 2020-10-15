//
//  PayCheckoutTests.swift
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

import XCTest
@testable import Pay

@available(iOS 11.0, *)
class PayCheckoutTests: XCTestCase {

    private let shopName = "SHOPIFY"
    
    // ----------------------------------
    //  MARK: - Init -
    //
    func testInit() {
        let giftCard = Models.createGiftCard()
        let discount = Models.createDiscount()
        let shipping = Models.createShippingDiscount()
        let address  = Models.createAddress()
        let rate     = Models.createShippingRate()
        let checkout = PayCheckout(
            id: "123",
            lineItems: [
                PayLineItem(price: 10.0, quantity: 1),
                PayLineItem(price: 20.0, quantity: 1),
            ],
            giftCards:        [giftCard],
            discount:         discount,
            shippingDiscount: shipping,
            shippingAddress:  address,
            shippingRate:     rate,
            currencyCode:     "CAD",
            totalDuties:      9.95,
            subtotalPrice:    30.0,
            needsShipping:    true,
            totalTax:         15.0,
            paymentDue:       35.0
        )
        
        XCTAssertEqual(checkout.id,                       "123")
        XCTAssertEqual(checkout.lineItems.count,          2)
        XCTAssertEqual(checkout.shippingAddress!.city,    address.city)
        XCTAssertEqual(checkout.shippingRate!.handle,     rate.handle)
        XCTAssertEqual(checkout.giftCards!.first!.amount, 5.00)
        XCTAssertEqual(checkout.discount!.amount,         20.0)
        XCTAssertEqual(checkout.shippingDiscount!.amount, 10.0)
        XCTAssertEqual(checkout.currencyCode,             "CAD")
        XCTAssertEqual(checkout.subtotalPrice,            30.0)
        XCTAssertEqual(checkout.totalDuties,              9.95)
        XCTAssertEqual(checkout.needsShipping,            true)
        XCTAssertEqual(checkout.totalTax,                 15.0)
        XCTAssertEqual(checkout.paymentDue,               35.0)
    }
    
    // ----------------------------------
    //  MARK: - Summary Items -
    //
    func testSummaryItemsWithTaxes() {
        let checkout     = Models.createCheckout(requiresShipping: false)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "TAXES")
        XCTAssertEqual(summaryItems[3].label, "SHOPIFY")
    }
    
    func testSummaryItemsWithDuties() {
        let checkout     = Models.createCheckout(requiresShipping: false, duties: 24.99)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 5)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "DUTIES")
        XCTAssertEqual(summaryItems[2].amount as Decimal, 24.99)
        XCTAssertEqual(summaryItems[3].label, "TAXES")
        XCTAssertEqual(summaryItems[4].label, "SHOPIFY")
    }
    
    func testSummaryItemsWithDutiesAmountZero() {
        let checkout     = Models.createCheckout(requiresShipping: false, duties: 0)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 5)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "DUTIES")
        XCTAssertEqual(summaryItems[2].amount as Decimal, 0)
        XCTAssertEqual(summaryItems[3].label, "TAXES")
        XCTAssertEqual(summaryItems[4].label, "SHOPIFY")
    }
    
    func testSummaryItemsWithShipping() {
        let address      = Models.createAddress()
        let rate         = Models.createShippingRate()
        let checkout     = Models.createCheckout(requiresShipping: true, shippingAddress: address, shippingRate: rate)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 5)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "SHIPPING")
        XCTAssertEqual(summaryItems[3].label, "TAXES")
        XCTAssertEqual(summaryItems[4].label, "SHOPIFY")
    }
    
    func testSummaryItemsWithoutTax() {
        let checkout     = Models.createCheckout(requiresShipping: false, hasTax: false)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 3)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "SHOPIFY")
    }
    
    func testSummaryItemsWithGiftCard() {
        let giftCards    = [Models.createGiftCard()]
        let checkout     = Models.createCheckout(giftCards: giftCards, hasTax: false)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "GIFT CARD (•••• A1B2)")
        XCTAssertEqual(summaryItems[3].label, "SHOPIFY")
        
        XCTAssertEqual(summaryItems[2].amount as Decimal, giftCards[0].amount.negative)
    }
    
    func testSummaryItemsWithMultipleGiftCards() {
        let giftCards = [
            Models.createGiftCard(),
            Models.createGiftCardSecondary(),
        ]
        
        let checkout     = Models.createCheckout(giftCards: giftCards, hasTax: false)
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[2].label, "GIFT CARDS (2)")
        XCTAssertEqual(summaryItems[3].label, "SHOPIFY")
        
        let totalGiftCards = giftCards.reduce(0) { $0 + $1.amount }
        XCTAssertEqual(summaryItems[2].amount as Decimal, totalGiftCards.negative)
    }
    
    func testSummaryItemsWithItemDiscount() {
        let discount     = Models.createDiscount()
        let checkout     = Models.createCheckout(requiresShipping: false, discount: discount, empty: true, hasTax: false)
        var summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 4)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT (WIN20)")
        XCTAssertEqual(summaryItems[2].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[3].label, "SHOPIFY")
        
        XCTAssertEqual(summaryItems[1].amount as Decimal, discount.amount.negative)
        
        let anonymousDiscount = Models.createAnonymousDiscount()
        let checkout2         = Models.createCheckout(requiresShipping: false, discount: anonymousDiscount, empty: true, hasTax: false)
        
        summaryItems = checkout2.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT")
        XCTAssertEqual(summaryItems[1].amount as Decimal, anonymousDiscount.amount.negative)
    }
    
    func testSummaryItemsWithShippingDiscount() {
        let discount     = Models.createShippingDiscount()
        let checkout     = Models.createCheckout(requiresShipping: false, shippingDiscount: discount, empty: true, hasTax: false)
        var summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 3)
        XCTAssertEqual(summaryItems[0].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT (FREESHIP)")
        XCTAssertEqual(summaryItems[2].label, "SHOPIFY")
        
        XCTAssertEqual(summaryItems[1].amount as Decimal, discount.amount.negative)
        
        let anonymousDiscount = Models.createAnonymousShippingDiscount()
        let checkout2         = Models.createCheckout(requiresShipping: false, shippingDiscount: anonymousDiscount, empty: true, hasTax: false)
        
        summaryItems = checkout2.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT")
        XCTAssertEqual(summaryItems[1].amount as Decimal, anonymousDiscount.amount.negative)
    }
    
    func testSummaryItemsFullyLoaded() {
        let giftCards        = [Models.createGiftCard()]
        let discount         = Models.createDiscount()
        let shippingDiscount = Models.createShippingDiscount()
        let address          = Models.createAddress()
        let shippingRate     = Models.createShippingRate()
        let checkout         = Models.createCheckout(
            requiresShipping: true,
            giftCards:        giftCards,
            discount:         discount,
            shippingDiscount: shippingDiscount,
            shippingAddress:  address,
            shippingRate:     shippingRate,
            empty:            false,
            hasTax:           true
        )
        let summaryItems = checkout.summaryItems(for: self.shopName)
        
        XCTAssertEqual(summaryItems.count, 8)
        XCTAssertEqual(summaryItems[0].label, "CART TOTAL")
        XCTAssertEqual(summaryItems[1].label, "DISCOUNT (WIN20)")
        XCTAssertEqual(summaryItems[2].label, "SUBTOTAL")
        XCTAssertEqual(summaryItems[3].label, "SHIPPING")
        XCTAssertEqual(summaryItems[4].label, "DISCOUNT (FREESHIP)")
        XCTAssertEqual(summaryItems[5].label, "TAXES")
        XCTAssertEqual(summaryItems[6].label, "GIFT CARD (•••• A1B2)")
        XCTAssertEqual(summaryItems[7].label, "SHOPIFY")
        
        XCTAssertEqual(summaryItems[1].amount as Decimal, discount.amount.negative)
        XCTAssertEqual(summaryItems[4].amount as Decimal, shippingDiscount.amount.negative)
        XCTAssertEqual(summaryItems[6].amount as Decimal, giftCards[0].amount.negative)
    }
}

#endif
