//
//  ShopPayPaymentRequestDiscountInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// The input fields to create a discount for a Shop Pay payment request. 
	open class ShopPayPaymentRequestDiscountInput {
		/// The label of the discount. 
		open var label: Input<String>

		/// The amount of the discount. 
		open var amount: Input<MoneyInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - label: The label of the discount.
		///     - amount: The amount of the discount.
		///
		public static func create(label: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined) -> ShopPayPaymentRequestDiscountInput {
			return ShopPayPaymentRequestDiscountInput(label: label, amount: amount)
		}

		private init(label: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined) {
			self.label = label
			self.amount = amount
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - label: The label of the discount.
		///     - amount: The amount of the discount.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(label: String? = nil, amount: MoneyInput? = nil) {
			self.init(label: label.orUndefined, amount: amount.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch label {
				case .value(let label):
				guard let label = label else {
					fields.append("label:null")
					break
				}
				fields.append("label:\(GraphQL.quoteString(input: label))")
				case .undefined: break
			}

			switch amount {
				case .value(let amount):
				guard let amount = amount else {
					fields.append("amount:null")
					break
				}
				fields.append("amount:\(amount.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
