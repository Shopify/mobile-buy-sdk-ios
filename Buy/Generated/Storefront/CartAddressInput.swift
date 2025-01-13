//
//  CartAddressInput.swift
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
	/// The input fields to provide exactly one of a variety of delivery address 
	/// types. 
	open class CartAddressInput {
		/// A delivery address stored on this cart. 
		open var deliveryAddress: Input<CartDeliveryAddressInput>

		/// Copies details from the customer address to an address on this cart. 
		open var copyFromCustomerAddressId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryAddress: A delivery address stored on this cart.
		///     - copyFromCustomerAddressId: Copies details from the customer address to an address on this cart.
		///
		public static func create(deliveryAddress: Input<CartDeliveryAddressInput> = .undefined, copyFromCustomerAddressId: Input<GraphQL.ID> = .undefined) -> CartAddressInput {
			return CartAddressInput(deliveryAddress: deliveryAddress, copyFromCustomerAddressId: copyFromCustomerAddressId)
		}

		private init(deliveryAddress: Input<CartDeliveryAddressInput> = .undefined, copyFromCustomerAddressId: Input<GraphQL.ID> = .undefined) {
			self.deliveryAddress = deliveryAddress
			self.copyFromCustomerAddressId = copyFromCustomerAddressId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryAddress: A delivery address stored on this cart.
		///     - copyFromCustomerAddressId: Copies details from the customer address to an address on this cart.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(deliveryAddress: CartDeliveryAddressInput? = nil, copyFromCustomerAddressId: GraphQL.ID? = nil) {
			self.init(deliveryAddress: deliveryAddress.orUndefined, copyFromCustomerAddressId: copyFromCustomerAddressId.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch deliveryAddress {
				case .value(let deliveryAddress):
				guard let deliveryAddress = deliveryAddress else {
					fields.append("deliveryAddress:null")
					break
				}
				fields.append("deliveryAddress:\(deliveryAddress.serialize())")
				case .undefined: break
			}

			switch copyFromCustomerAddressId {
				case .value(let copyFromCustomerAddressId):
				guard let copyFromCustomerAddressId = copyFromCustomerAddressId else {
					fields.append("copyFromCustomerAddressId:null")
					break
				}
				fields.append("copyFromCustomerAddressId:\(GraphQL.quoteString(input: "\(copyFromCustomerAddressId.rawValue)"))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
