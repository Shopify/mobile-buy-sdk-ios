//
//  PayShippingRate.swift
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

/// Represents a shipping rate quote, usually provided for a specific address.
///
public struct PayShippingRate {

    /// Represents a `from` and `to` date for the expected delivery time frame. If the `to` date is `nil`, then the expected delivery window is roughly around the `from` date.
    ///
    public struct DeliveryRange {

        /// Delivery is expected no earlier than `from` date.
        public let from: Date

        /// Delivery is expected no later than `to` date.
        public let to:   Date?

        /// Create a delivery range.
        ///
        /// - parameters:
        ///     - from: A date from which to expect delivery.
        ///     - to: A date until which to expect delivery.
        ///
        public init(from: Date, to: Date? = nil) {
            self.from = from
            self.to   = to
        }

        /// A string that describes how many days until expected delivery (eg: "1 - 2 days").
        public func descriptionFrom(_ date: Date) -> String {
            let firstDelta = date.daysUntil(self.from)

            guard let toDate = self.to else {
                let suffix  = firstDelta == 1 ? "" : "s"
                return "\(firstDelta) day\(suffix)"
            }

            let secondDelta = date.daysUntil(toDate)
            return "\(firstDelta) - \(secondDelta) days"
        }
    }

    /// A handle that uniquely identifies this shipping rate.
    public let handle: String

    /// A human-friendly name for this shipping rate.
    public let title: String

    /// Shipping rate price.
    public let price: Decimal

    /// A delivery range that represents a timeframe during which a delivery is expected.
    public let deliveryRange: DeliveryRange?

    // ----------------------------------
    //  MARK: - Init -
    //
    public init(handle: String, title: String, price: Decimal, deliveryRange: DeliveryRange? = nil) {
        self.handle        = handle
        self.title         = title
        self.price         = price
        self.deliveryRange = deliveryRange
    }
}

// ----------------------------------
//  MARK: - Date -
//
private extension Date {

    static let calendar = Calendar.current

    func daysUntil(_ date: Date) -> Int {

        let calendar = Date.calendar
        let start    = calendar.startOfDay(for: self)
        let end      = calendar.startOfDay(for: date)
        let delta    = calendar.dateComponents([.day], from: start, to: end)

        return delta.day!
    }
}

// ----------------------------------
//  MARK: - PassKit -
//
internal extension PayShippingRate {

    var summaryItem: PKShippingMethod {
        let item = PKShippingMethod(label: self.title, amount: self.price)

        if let deliveryRange = self.deliveryRange {
            item.detail = deliveryRange.descriptionFrom(Date())
        } else {
            item.detail = "No delivery estimate provided."
        }
        item.identifier = self.handle

        return item
    }
}

internal extension Array where Element == PayShippingRate {

    var summaryItems: [PKShippingMethod] {
        return self.map {
            $0.summaryItem
        }
    }

    func shippingRateFor(_ shippingMethod: PKShippingMethod) -> Element? {
        return self.filter {
            $0.handle == shippingMethod.identifier!
        }.first
    }
}
