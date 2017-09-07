//
//  CheckoutLineItemInput.swift
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
	/// Specifies the input fields to create a line item on a checkout. 
	open class CheckoutLineItemInput {
		/// Extra information in the form of an array of Key-Value pairs about the line 
		/// item. 
		open var customAttributes: InputValue<[AttributeInput]>

		/// The quantity of the line item. 
		open var quantity: Int32

		/// The identifier of the product variant for the line item. 
		open var variantId: GraphQL.ID

		/// Creates the input object.
		///
		/// - parameters:
		///     - customAttributes: Extra information in the form of an array of Key-Value pairs about the line item.
		///     - quantity: The quantity of the line item.
		///     - variantId: The identifier of the product variant for the line item.
		///
		public init(quantity: Int32, variantId: GraphQL.ID, customAttributes: InputValue<[AttributeInput]> = .undefined) {
			self.customAttributes = customAttributes
			self.quantity = quantity
			self.variantId = variantId
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch customAttributes {
				case .some(let customAttributes): fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
				case .null: fields.append("customAttributes:null")
				case .undefined: break
			}

			fields.append("quantity:\(quantity)")

			fields.append("variantId:\(GraphQL.quoteString(input: "\(variantId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
