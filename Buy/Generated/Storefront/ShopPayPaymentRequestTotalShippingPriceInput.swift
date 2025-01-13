//
//  ShopPayPaymentRequestTotalShippingPriceInput.swift
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
	/// The input fields to create a shipping total for a Shop Pay payment request. 
	open class ShopPayPaymentRequestTotalShippingPriceInput {
		/// The discounts for the shipping total. The input must not contain more than 
		/// `250` values. 
		open var discounts: Input<[ShopPayPaymentRequestDiscountInput]>

		/// The original total for the shipping total. 
		open var originalTotal: Input<MoneyInput>

		/// The final total for the shipping total. 
		open var finalTotal: Input<MoneyInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - discounts: The discounts for the shipping total.  The input must not contain more than `250` values.
		///     - originalTotal: The original total for the shipping total.
		///     - finalTotal: The final total for the shipping total.
		///
		public static func create(discounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, originalTotal: Input<MoneyInput> = .undefined, finalTotal: Input<MoneyInput> = .undefined) -> ShopPayPaymentRequestTotalShippingPriceInput {
			return ShopPayPaymentRequestTotalShippingPriceInput(discounts: discounts, originalTotal: originalTotal, finalTotal: finalTotal)
		}

		private init(discounts: Input<[ShopPayPaymentRequestDiscountInput]> = .undefined, originalTotal: Input<MoneyInput> = .undefined, finalTotal: Input<MoneyInput> = .undefined) {
			self.discounts = discounts
			self.originalTotal = originalTotal
			self.finalTotal = finalTotal
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - discounts: The discounts for the shipping total.  The input must not contain more than `250` values.
		///     - originalTotal: The original total for the shipping total.
		///     - finalTotal: The final total for the shipping total.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(discounts: [ShopPayPaymentRequestDiscountInput]? = nil, originalTotal: MoneyInput? = nil, finalTotal: MoneyInput? = nil) {
			self.init(discounts: discounts.orUndefined, originalTotal: originalTotal.orUndefined, finalTotal: finalTotal.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch discounts {
				case .value(let discounts):
				guard let discounts = discounts else {
					fields.append("discounts:null")
					break
				}
				fields.append("discounts:[\(discounts.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch originalTotal {
				case .value(let originalTotal):
				guard let originalTotal = originalTotal else {
					fields.append("originalTotal:null")
					break
				}
				fields.append("originalTotal:\(originalTotal.serialize())")
				case .undefined: break
			}

			switch finalTotal {
				case .value(let finalTotal):
				guard let finalTotal = finalTotal else {
					fields.append("finalTotal:null")
					break
				}
				fields.append("finalTotal:\(finalTotal.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
