//
//  MoneyInput.swift
//  Buy
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

extension Storefront {
	/// Specifies the fields for a monetary value with currency. 
	open class MoneyInput {
		/// Decimal money amount. 
		open var amount: Decimal

		/// Currency of the money. 
		open var currencyCode: CurrencyCode

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: Decimal money amount.
		///     - currencyCode: Currency of the money.
		///
		public static func create(amount: Decimal, currencyCode: CurrencyCode) -> MoneyInput {
			return MoneyInput(amount: amount, currencyCode: currencyCode)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - amount: Decimal money amount.
		///     - currencyCode: Currency of the money.
		///
		public init(amount: Decimal, currencyCode: CurrencyCode) {
			self.amount = amount
			self.currencyCode = currencyCode
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("amount:\(GraphQL.quoteString(input: "\(String(describing: amount))"))")

			fields.append("currencyCode:\(currencyCode.rawValue)")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
