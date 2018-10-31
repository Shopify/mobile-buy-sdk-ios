//
//  PayCheckout.swift
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

/// Encapsulates all fields required for invoking the Apple Pay
/// dialog. It also creates summary items for cart total,
/// subtotal, taxes, shipping, and more.
///
public struct PayCheckout {

    public let id:               String
    public let hasLineItems:     Bool
    public let needsShipping:    Bool

    public let giftCards:        [PayGiftCard]?
    public let discount:         PayDiscount?
    public let shippingDiscount: PayDiscount?
    public let lineItems:        [PayLineItem]
    public let shippingAddress:  PayAddress?
    public let shippingRate:     PayShippingRate?

    public let currencyCode:     String
    public let subtotalPrice:    Decimal
    public let totalTax:         Decimal
    public let paymentDue:       Decimal

    // ----------------------------------
    //  MARK: - Init -
    //
    public init(id: String, lineItems: [PayLineItem], giftCards: [PayGiftCard]?, discount: PayDiscount?, shippingDiscount: PayDiscount?, shippingAddress: PayAddress?, shippingRate: PayShippingRate?, currencyCode: String, subtotalPrice: Decimal, needsShipping: Bool, totalTax: Decimal, paymentDue: Decimal) {

        self.id               = id
        self.lineItems        = lineItems
        self.shippingAddress  = shippingAddress
        self.shippingRate     = shippingRate

        self.giftCards        = giftCards
        self.discount         = discount
        self.shippingDiscount = shippingDiscount
        
        self.currencyCode     = currencyCode
        self.subtotalPrice    = subtotalPrice
        self.totalTax         = totalTax
        self.paymentDue       = paymentDue

        self.hasLineItems     = !lineItems.isEmpty
        self.needsShipping    = needsShipping
    }
}

// ----------------------------------
//  MARK: - PassKits -
//
internal extension PayCheckout {

    func summaryItems(for shop: String) -> [PKPaymentSummaryItem] {
        var summaryItems: [PKPaymentSummaryItem] = []

        // Cart total
        
        if self.hasLineItems || self.discount != nil {
            summaryItems.append(self.lineItems.totalPrice.summaryItemNamed("CART TOTAL"))
        }
        
        // Discount

        if let discount = self.discount {
            let title = discount.code.isEmpty ? "DISCOUNT" : "DISCOUNT (\(discount.code))"
            summaryItems.append(discount.amount.negative.summaryItemNamed(title))
        }

        // Subtotal
        
        summaryItems.append(self.subtotalPrice.summaryItemNamed("SUBTOTAL"))

        // Shipping
        
        if let shippingRate = self.shippingRate, shippingRate.price > 0.0 {
            summaryItems.append(shippingRate.price.summaryItemNamed("SHIPPING"))
        }

        // Shipping Discount
        
        if let discount = self.shippingDiscount {
            let title = discount.code.isEmpty ? "DISCOUNT" : "DISCOUNT (\(discount.code))"
            summaryItems.append(discount.amount.negative.summaryItemNamed(title))
        }
        
        // Taxes
        
        if self.totalTax > 0.0 {
            summaryItems.append(self.totalTax.summaryItemNamed("TAXES"))
        }
        
        // Gift cards
        
        if let giftCards = self.giftCards, !giftCards.isEmpty {
            if giftCards.count == 1 {
                let giftCard     = giftCards[0]
                let appliedTotal = giftCard.amount
                summaryItems.append(appliedTotal.negative.summaryItemNamed("GIFT CARD (•••• \(giftCard.lastCharacters))"))
                
            } else {
                let appliedTotal = giftCards.reduce(0) {
                    $0 + $1.amount
                }
                summaryItems.append(appliedTotal.negative.summaryItemNamed("GIFT CARDS (\(giftCards.count))"))
            }
        }

        // Shop name
        
        summaryItems.append(self.paymentDue.summaryItemNamed(shop))

        return summaryItems
    }
}
