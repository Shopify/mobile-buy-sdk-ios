//
//  ShopPayPaymentRequestDeliveryMethodInput.swift
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
	/// The input fields to create a delivery method for a Shop Pay payment 
	/// request. 
	open class ShopPayPaymentRequestDeliveryMethodInput {
		/// The code of the delivery method. 
		open var code: Input<String>

		/// The label of the delivery method. 
		open var label: Input<String>

		/// The detail of the delivery method. 
		open var detail: Input<String>

		/// The amount for the delivery method. 
		open var amount: Input<MoneyInput>

		/// The minimum delivery date for the delivery method. 
		open var minDeliveryDate: Input<String>

		/// The maximum delivery date for the delivery method. 
		open var maxDeliveryDate: Input<String>

		/// The detail about when the delivery may be expected. 
		open var deliveryExpectationLabel: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - code: The code of the delivery method.
		///     - label: The label of the delivery method.
		///     - detail: The detail of the delivery method.
		///     - amount: The amount for the delivery method.
		///     - minDeliveryDate: The minimum delivery date for the delivery method.
		///     - maxDeliveryDate: The maximum delivery date for the delivery method.
		///     - deliveryExpectationLabel: The detail about when the delivery may be expected.
		///
		public static func create(code: Input<String> = .undefined, label: Input<String> = .undefined, detail: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined, minDeliveryDate: Input<String> = .undefined, maxDeliveryDate: Input<String> = .undefined, deliveryExpectationLabel: Input<String> = .undefined) -> ShopPayPaymentRequestDeliveryMethodInput {
			return ShopPayPaymentRequestDeliveryMethodInput(code: code, label: label, detail: detail, amount: amount, minDeliveryDate: minDeliveryDate, maxDeliveryDate: maxDeliveryDate, deliveryExpectationLabel: deliveryExpectationLabel)
		}

		private init(code: Input<String> = .undefined, label: Input<String> = .undefined, detail: Input<String> = .undefined, amount: Input<MoneyInput> = .undefined, minDeliveryDate: Input<String> = .undefined, maxDeliveryDate: Input<String> = .undefined, deliveryExpectationLabel: Input<String> = .undefined) {
			self.code = code
			self.label = label
			self.detail = detail
			self.amount = amount
			self.minDeliveryDate = minDeliveryDate
			self.maxDeliveryDate = maxDeliveryDate
			self.deliveryExpectationLabel = deliveryExpectationLabel
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - code: The code of the delivery method.
		///     - label: The label of the delivery method.
		///     - detail: The detail of the delivery method.
		///     - amount: The amount for the delivery method.
		///     - minDeliveryDate: The minimum delivery date for the delivery method.
		///     - maxDeliveryDate: The maximum delivery date for the delivery method.
		///     - deliveryExpectationLabel: The detail about when the delivery may be expected.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(code: String? = nil, label: String? = nil, detail: String? = nil, amount: MoneyInput? = nil, minDeliveryDate: String? = nil, maxDeliveryDate: String? = nil, deliveryExpectationLabel: String? = nil) {
			self.init(code: code.orUndefined, label: label.orUndefined, detail: detail.orUndefined, amount: amount.orUndefined, minDeliveryDate: minDeliveryDate.orUndefined, maxDeliveryDate: maxDeliveryDate.orUndefined, deliveryExpectationLabel: deliveryExpectationLabel.orUndefined)
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

			switch detail {
				case .value(let detail):
				guard let detail = detail else {
					fields.append("detail:null")
					break
				}
				fields.append("detail:\(GraphQL.quoteString(input: detail))")
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

			switch minDeliveryDate {
				case .value(let minDeliveryDate):
				guard let minDeliveryDate = minDeliveryDate else {
					fields.append("minDeliveryDate:null")
					break
				}
				fields.append("minDeliveryDate:\(GraphQL.quoteString(input: minDeliveryDate))")
				case .undefined: break
			}

			switch maxDeliveryDate {
				case .value(let maxDeliveryDate):
				guard let maxDeliveryDate = maxDeliveryDate else {
					fields.append("maxDeliveryDate:null")
					break
				}
				fields.append("maxDeliveryDate:\(GraphQL.quoteString(input: maxDeliveryDate))")
				case .undefined: break
			}

			switch deliveryExpectationLabel {
				case .value(let deliveryExpectationLabel):
				guard let deliveryExpectationLabel = deliveryExpectationLabel else {
					fields.append("deliveryExpectationLabel:null")
					break
				}
				fields.append("deliveryExpectationLabel:\(GraphQL.quoteString(input: deliveryExpectationLabel))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
