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

public struct PayCheckout {

    public let hasLineItems:    Bool
    public let hasDiscount:     Bool
    public let needsShipping:   Bool
    
    public let lineItems:       [PayLineItem]
    public let shippingAddress: PayAddress?
    public let shippingRate:    PayShippingRate?
    
    public let discountAmount:  Decimal
    public let subtotalPrice:   Decimal
    public let totalTax:        Decimal
    public let paymentDue:      Decimal
    
    // ----------------------------------
    //  MARK: - Init -
    //
    public init(lineItems: [PayLineItem], shippingAddress: PayAddress?, shippingRate: PayShippingRate?, discountAmount: Decimal, subtotalPrice: Decimal, needsShipping: Bool, totalTax: Decimal, paymentDue: Decimal) {
        
        self.lineItems       = lineItems
        self.shippingAddress = shippingAddress
        self.shippingRate    = shippingRate
        
        self.discountAmount  = discountAmount
        self.subtotalPrice   = subtotalPrice
        self.totalTax        = totalTax
        self.paymentDue      = paymentDue
        
        self.hasLineItems    = !lineItems.isEmpty
        self.hasDiscount     = false // TODO: Add discount
        self.needsShipping   = needsShipping
    }
}

// ----------------------------------
//  MARK: - PassKits -
//
internal extension PayCheckout {
    
    var summaryItems: [PKPaymentSummaryItem] {
        var summaryItems: [PKPaymentSummaryItem] = []
        
        if self.hasLineItems /* or has discount */ {
            summaryItems.append(self.lineItems.totalPrice.summaryItemNamed("CART TOTAL"))
        }
        
        // TODO: if self.hasDiscount { add discount summary item }
        
        //        if (hasDiscount) {
        //            NSString *discountLabel = [self.discount.code length] > 0 ? [NSString stringWithFormat:@"DISCOUNT (%@)", self.discount.code] : @"DISCOUNT";
        //            [summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:discountLabel amount:[self.discount.amount buy_decimalNumberAsNegative]]];
        //        }
        
        summaryItems.append(self.subtotalPrice.summaryItemNamed("SUBTOTAL"))
        
        if let shippingRate = self.shippingRate, shippingRate.price > 0.0 {
            summaryItems.append(shippingRate.price.summaryItemNamed("SHIPPING"))
        }
        
        if self.totalTax > 0.0 {
            summaryItems.append(self.totalTax.summaryItemNamed("TAXES"))
        }
        
        // TODO: if !self.giftCards.isEmpty { add gift card summary item }
        
        //        if ([self.giftCards count] > 0) {
        //            for (BUYGiftCard *giftCard in self.giftCards) {
        //                NSString *giftCardLabel = [giftCard.lastCharacters length] > 0 ? [NSString stringWithFormat:@"GIFT CARD (•••• %@)", giftCard.lastCharacters] : @"GIFT CARD";
        //                [summaryItems addObject:[PKPaymentSummaryItem summaryItemWithLabel:giftCardLabel amount:giftCard.amountUsed ? [giftCard.amountUsed buy_decimalNumberAsNegative] : [giftCard.balance buy_decimalNumberAsNegative]]];
        //            }
        //        }
        
        summaryItems.append(self.paymentDue.summaryItemNamed("TOTAL"))
        
        return summaryItems
    }
}