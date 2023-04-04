//
//  DeliveryAddressInput.swift
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
	/// The input fields for delivery address preferences. 
	open class DeliveryAddressInput {
		/// A delivery address preference of a buyer that is interacting with the cart. 
		open var deliveryAddress: Input<MailingAddressInput>

		/// The ID of a customer address that is associated with the buyer that is 
		/// interacting with the cart. 
		open var customerAddressId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryAddress: A delivery address preference of a buyer that is interacting with the cart.
		///     - customerAddressId: The ID of a customer address that is associated with the buyer that is interacting with the cart. 
		///
		public static func create(deliveryAddress: Input<MailingAddressInput> = .undefined, customerAddressId: Input<GraphQL.ID> = .undefined) -> DeliveryAddressInput {
			return DeliveryAddressInput(deliveryAddress: deliveryAddress, customerAddressId: customerAddressId)
		}

		private init(deliveryAddress: Input<MailingAddressInput> = .undefined, customerAddressId: Input<GraphQL.ID> = .undefined) {
			self.deliveryAddress = deliveryAddress
			self.customerAddressId = customerAddressId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryAddress: A delivery address preference of a buyer that is interacting with the cart.
		///     - customerAddressId: The ID of a customer address that is associated with the buyer that is interacting with the cart. 
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(deliveryAddress: MailingAddressInput? = nil, customerAddressId: GraphQL.ID? = nil) {
			self.init(deliveryAddress: deliveryAddress.orUndefined, customerAddressId: customerAddressId.orUndefined)
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

			switch customerAddressId {
				case .value(let customerAddressId): 
				guard let customerAddressId = customerAddressId else {
					fields.append("customerAddressId:null")
					break
				}
				fields.append("customerAddressId:\(GraphQL.quoteString(input: "\(customerAddressId.rawValue)"))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
