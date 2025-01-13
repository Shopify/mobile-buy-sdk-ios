//
//  CartPreferencesInput.swift
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
	/// The input fields represent preferences for the buyer that is interacting 
	/// with the cart. 
	open class CartPreferencesInput {
		/// Delivery preferences can be used to prefill the delivery section in at 
		/// checkout. 
		open var delivery: Input<CartDeliveryPreferenceInput>

		/// Wallet preferences are used to populate relevant payment fields in the 
		/// checkout flow. Accepted value: `["shop_pay"]`. The input must not contain 
		/// more than `250` values. 
		open var wallet: Input<[String]>

		/// Creates the input object.
		///
		/// - parameters:
		///     - delivery: Delivery preferences can be used to prefill the delivery section in at checkout.
		///     - wallet: Wallet preferences are used to populate relevant payment fields in the checkout flow. Accepted value: `["shop_pay"]`.  The input must not contain more than `250` values.
		///
		public static func create(delivery: Input<CartDeliveryPreferenceInput> = .undefined, wallet: Input<[String]> = .undefined) -> CartPreferencesInput {
			return CartPreferencesInput(delivery: delivery, wallet: wallet)
		}

		private init(delivery: Input<CartDeliveryPreferenceInput> = .undefined, wallet: Input<[String]> = .undefined) {
			self.delivery = delivery
			self.wallet = wallet
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - delivery: Delivery preferences can be used to prefill the delivery section in at checkout.
		///     - wallet: Wallet preferences are used to populate relevant payment fields in the checkout flow. Accepted value: `["shop_pay"]`.  The input must not contain more than `250` values.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(delivery: CartDeliveryPreferenceInput? = nil, wallet: [String]? = nil) {
			self.init(delivery: delivery.orUndefined, wallet: wallet.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch delivery {
				case .value(let delivery):
				guard let delivery = delivery else {
					fields.append("delivery:null")
					break
				}
				fields.append("delivery:\(delivery.serialize())")
				case .undefined: break
			}

			switch wallet {
				case .value(let wallet):
				guard let wallet = wallet else {
					fields.append("wallet:null")
					break
				}
				fields.append("wallet:[\(wallet.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
