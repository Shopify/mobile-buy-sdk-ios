//
//  CartLineInput.swift
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
	/// The input fields to create a merchandise line on a cart. 
	open class CartLineInput {
		/// An array of key-value pairs that contains additional information about the 
		/// merchandise line. 
		open var attributes: Input<[AttributeInput]>

		/// The quantity of the merchandise. 
		open var quantity: Input<Int32>

		/// The ID of the merchandise that the buyer intends to purchase. 
		open var merchandiseId: GraphQL.ID

		/// The ID of the selling plan that the merchandise is being purchased with. 
		open var sellingPlanId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the merchandise line.
		///     - quantity: The quantity of the merchandise.
		///     - merchandiseId: The ID of the merchandise that the buyer intends to purchase.
		///     - sellingPlanId: The ID of the selling plan that the merchandise is being purchased with.
		///
		public static func create(merchandiseId: GraphQL.ID, attributes: Input<[AttributeInput]> = .undefined, quantity: Input<Int32> = .undefined, sellingPlanId: Input<GraphQL.ID> = .undefined) -> CartLineInput {
			return CartLineInput(merchandiseId: merchandiseId, attributes: attributes, quantity: quantity, sellingPlanId: sellingPlanId)
		}

		private init(merchandiseId: GraphQL.ID, attributes: Input<[AttributeInput]> = .undefined, quantity: Input<Int32> = .undefined, sellingPlanId: Input<GraphQL.ID> = .undefined) {
			self.attributes = attributes
			self.quantity = quantity
			self.merchandiseId = merchandiseId
			self.sellingPlanId = sellingPlanId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - attributes: An array of key-value pairs that contains additional information about the merchandise line.
		///     - quantity: The quantity of the merchandise.
		///     - merchandiseId: The ID of the merchandise that the buyer intends to purchase.
		///     - sellingPlanId: The ID of the selling plan that the merchandise is being purchased with.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(merchandiseId: GraphQL.ID, attributes: [AttributeInput]? = nil, quantity: Int32? = nil, sellingPlanId: GraphQL.ID? = nil) {
			self.init(merchandiseId: merchandiseId, attributes: attributes.orUndefined, quantity: quantity.orUndefined, sellingPlanId: sellingPlanId.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch attributes {
				case .value(let attributes): 
				guard let attributes = attributes else {
					fields.append("attributes:null")
					break
				}
				fields.append("attributes:[\(attributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch quantity {
				case .value(let quantity): 
				guard let quantity = quantity else {
					fields.append("quantity:null")
					break
				}
				fields.append("quantity:\(quantity)")
				case .undefined: break
			}

			fields.append("merchandiseId:\(GraphQL.quoteString(input: "\(merchandiseId.rawValue)"))")

			switch sellingPlanId {
				case .value(let sellingPlanId): 
				guard let sellingPlanId = sellingPlanId else {
					fields.append("sellingPlanId:null")
					break
				}
				fields.append("sellingPlanId:\(GraphQL.quoteString(input: "\(sellingPlanId.rawValue)"))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
