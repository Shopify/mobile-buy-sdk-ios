//
//  CheckoutLineItemUpdateInput.swift
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
	/// Specifies the input fields to update a line item on the checkout. 
	open class CheckoutLineItemUpdateInput {
		open var id: Input<GraphQL.ID>

		/// The variant identifier of the line item. 
		open var variantId: Input<GraphQL.ID>

		/// The quantity of the line item. 
		open var quantity: Input<Int32>

		/// Extra information in the form of an array of Key-Value pairs about the line 
		/// item. 
		open var customAttributes: Input<[AttributeInput]>

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: No description
		///     - variantId: The variant identifier of the line item.
		///     - quantity: The quantity of the line item.
		///     - customAttributes: Extra information in the form of an array of Key-Value pairs about the line item.
		///
		public static func create(id: Input<GraphQL.ID> = .undefined, variantId: Input<GraphQL.ID> = .undefined, quantity: Input<Int32> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined) -> CheckoutLineItemUpdateInput {
			return CheckoutLineItemUpdateInput(id: id, variantId: variantId, quantity: quantity, customAttributes: customAttributes)
		}

		private init(id: Input<GraphQL.ID> = .undefined, variantId: Input<GraphQL.ID> = .undefined, quantity: Input<Int32> = .undefined, customAttributes: Input<[AttributeInput]> = .undefined) {
			self.id = id
			self.variantId = variantId
			self.quantity = quantity
			self.customAttributes = customAttributes
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - id: No description
		///     - variantId: The variant identifier of the line item.
		///     - quantity: The quantity of the line item.
		///     - customAttributes: Extra information in the form of an array of Key-Value pairs about the line item.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(id: GraphQL.ID? = nil, variantId: GraphQL.ID? = nil, quantity: Int32? = nil, customAttributes: [AttributeInput]? = nil) {
			self.init(id: id.orUndefined, variantId: variantId.orUndefined, quantity: quantity.orUndefined, customAttributes: customAttributes.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch id {
				case .value(let id): 
				guard let id = id else {
					fields.append("id:null")
					break
				}
				fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")
				case .undefined: break
			}

			switch variantId {
				case .value(let variantId): 
				guard let variantId = variantId else {
					fields.append("variantId:null")
					break
				}
				fields.append("variantId:\(GraphQL.quoteString(input: "\(variantId.rawValue)"))")
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

			switch customAttributes {
				case .value(let customAttributes): 
				guard let customAttributes = customAttributes else {
					fields.append("customAttributes:null")
					break
				}
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
