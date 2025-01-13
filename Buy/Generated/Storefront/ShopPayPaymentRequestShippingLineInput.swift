//
//  ShopPayPaymentRequestShippingLineInput.swift
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
	/// The input fields to create a shipping line for a Shop Pay payment request. 
	open class ShopPayPaymentRequestShippingLineInput {
		/// The code of the shipping line. 
		open var code: Input<String>

		/// The label of the shipping line. 
		open var label: Input<String>

		/// The amount for the shipping line. 
		open var amount: Input<MoneyInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - code: The code of the shipping line.
		///     - label: The label of the shipping line.
		///     - amount: The amount for the shipping line.
		///
		public static func create(code: Input<String> = .undefined, label: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined) -> ShopPayPaymentRequestShippingLineInput {
			return ShopPayPaymentRequestShippingLineInput(code: code, label: label, amount: amount)
		}

		private init(code: Input<String> = .undefined, label: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined) {
			self.code = code
			self.label = label
			self.amount = amount
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - code: The code of the shipping line.
		///     - label: The label of the shipping line.
		///     - amount: The amount for the shipping line.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(code: String? = nil, label: String? = nil, amount: MoneyInput? = nil) {
			self.init(code: code.orUndefined, label: label.orUndefined, amount: amount.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch code {
				case .value(let code):
				guard let code = code else {
					fields.append("code:null")
					break
				}
				fields.append("code:\(GraphQL.quoteString(input: code))")
				case .undefined: break
			}

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
