//
//  CartSelectedDeliveryOptionInput.swift
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
	/// The input fields for updating the selected delivery options for a delivery 
	/// group. 
	open class CartSelectedDeliveryOptionInput {
		/// The ID of the cart delivery group. 
		open var deliveryGroupId: GraphQL.ID

		/// The handle of the selected delivery option. 
		open var deliveryOptionHandle: String

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryGroupId: The ID of the cart delivery group.
		///     - deliveryOptionHandle: The handle of the selected delivery option.
		///
		public static func create(deliveryGroupId: GraphQL.ID, deliveryOptionHandle: String) -> CartSelectedDeliveryOptionInput {
			return CartSelectedDeliveryOptionInput(deliveryGroupId: deliveryGroupId, deliveryOptionHandle: deliveryOptionHandle)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryGroupId: The ID of the cart delivery group.
		///     - deliveryOptionHandle: The handle of the selected delivery option.
		///
		public init(deliveryGroupId: GraphQL.ID, deliveryOptionHandle: String) {
			self.deliveryGroupId = deliveryGroupId
			self.deliveryOptionHandle = deliveryOptionHandle
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("deliveryGroupId:\(GraphQL.quoteString(input: "\(deliveryGroupId.rawValue)"))")

			fields.append("deliveryOptionHandle:\(GraphQL.quoteString(input: deliveryOptionHandle))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
