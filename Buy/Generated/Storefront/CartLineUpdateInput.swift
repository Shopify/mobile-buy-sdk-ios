//
//  CartLineUpdateInput.swift
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
	/// The input fields to update a line item on a cart. 
	open class CartLineUpdateInput {
		/// The ID of the merchandise line. 
		open var id: GraphQL.ID

		/// The quantity of the line item. 
		open var quantity: Input<Int32>

		/// The ID of the merchandise for the line item. 
		open var merchandiseId: Input<GraphQL.ID>

		/// An array of key-value pairs that contains additional information about the 
		/// merchandise line. 
		open var attributes: Input<[AttributeInput]>

		/// The ID of the selling plan that the merchandise is being purchased with. 
		open var sellingPlanId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: The ID of the merchandise line.
		///     - quantity: The quantity of the line item.
		///     - merchandiseId: The ID of the merchandise for the line item.
		///     - attributes: An array of key-value pairs that contains additional information about the merchandise line.
		///     - sellingPlanId: The ID of the selling plan that the merchandise is being purchased with.
		///
		public static func create(id: GraphQL.ID, quantity: Input<Int32> = .undefined, merchandiseId: Input<GraphQL.ID> = .undefined, attributes: Input<[AttributeInput]> = .undefined, sellingPlanId: Input<GraphQL.ID> = .undefined) -> CartLineUpdateInput {
			return CartLineUpdateInput(id: id, quantity: quantity, merchandiseId: merchandiseId, attributes: attributes, sellingPlanId: sellingPlanId)
		}

		private init(id: GraphQL.ID, quantity: Input<Int32> = .undefined, merchandiseId: Input<GraphQL.ID> = .undefined, attributes: Input<[AttributeInput]> = .undefined, sellingPlanId: Input<GraphQL.ID> = .undefined) {
			self.id = id
			self.quantity = quantity
			self.merchandiseId = merchandiseId
			self.attributes = attributes
			self.sellingPlanId = sellingPlanId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: The ID of the merchandise line.
		///     - quantity: The quantity of the line item.
		///     - merchandiseId: The ID of the merchandise for the line item.
		///     - attributes: An array of key-value pairs that contains additional information about the merchandise line.
		///     - sellingPlanId: The ID of the selling plan that the merchandise is being purchased with.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(id: GraphQL.ID, quantity: Int32? = nil, merchandiseId: GraphQL.ID? = nil, attributes: [AttributeInput]? = nil, sellingPlanId: GraphQL.ID? = nil) {
			self.init(id: id, quantity: quantity.orUndefined, merchandiseId: merchandiseId.orUndefined, attributes: attributes.orUndefined, sellingPlanId: sellingPlanId.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			switch quantity {
				case .value(let quantity): 
				guard let quantity = quantity else {
					fields.append("quantity:null")
					break
				}
				fields.append("quantity:\(quantity)")
				case .undefined: break
			}

			switch merchandiseId {
				case .value(let merchandiseId): 
				guard let merchandiseId = merchandiseId else {
					fields.append("merchandiseId:null")
					break
				}
				fields.append("merchandiseId:\(GraphQL.quoteString(input: "\(merchandiseId.rawValue)"))")
				case .undefined: break
			}

			switch attributes {
				case .value(let attributes): 
				guard let attributes = attributes else {
					fields.append("attributes:null")
					break
				}
				fields.append("attributes:[\(attributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

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
