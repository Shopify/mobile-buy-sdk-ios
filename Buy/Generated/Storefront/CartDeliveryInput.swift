//
//  CartDeliveryInput.swift
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
	/// The input fields for the cart's delivery properties. 
	open class CartDeliveryInput {
		/// Selectable addresses to present to the buyer on the cart. The input must 
		/// not contain more than `250` values. 
		open var addresses: Input<[CartSelectableAddressInput]>

		/// Creates the input object.
		///
		/// - parameters:
		///     - addresses: Selectable addresses to present to the buyer on the cart.  The input must not contain more than `250` values.
		///
		public static func create(addresses: Input<[CartSelectableAddressInput]> = .undefined) -> CartDeliveryInput {
			return CartDeliveryInput(addresses: addresses)
		}

		private init(addresses: Input<[CartSelectableAddressInput]> = .undefined) {
			self.addresses = addresses
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - addresses: Selectable addresses to present to the buyer on the cart.  The input must not contain more than `250` values.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(addresses: [CartSelectableAddressInput]? = nil) {
			self.init(addresses: addresses.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch addresses {
				case .value(let addresses):
				guard let addresses = addresses else {
					fields.append("addresses:null")
					break
				}
				fields.append("addresses:[\(addresses.map { "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
