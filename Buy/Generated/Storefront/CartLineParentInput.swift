//
//  CartLineParentInput.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2026 Shopify Inc. All rights reserved.
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
	/// The parent line item of the cart line.
	open class CartLineParentInput {
		/// The id of the parent line item.
		open var lineId: Input<GraphQL.ID>

		/// The ID of the parent line merchandise.
		open var merchandiseId: Input<GraphQL.ID>

		/// Creates the input object.
		///
		/// - parameters:
		///     - lineId: The id of the parent line item.
		///     - merchandiseId: The ID of the parent line merchandise.
		///
		public static func create(lineId: Input<GraphQL.ID> = .undefined, merchandiseId: Input<GraphQL.ID> = .undefined) -> CartLineParentInput {
			return CartLineParentInput(lineId: lineId, merchandiseId: merchandiseId)
		}

		private init(lineId: Input<GraphQL.ID> = .undefined, merchandiseId: Input<GraphQL.ID> = .undefined) {
			self.lineId = lineId
			self.merchandiseId = merchandiseId
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - lineId: The id of the parent line item.
		///     - merchandiseId: The ID of the parent line merchandise.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(lineId: GraphQL.ID? = nil, merchandiseId: GraphQL.ID? = nil) {
			self.init(lineId: lineId.orUndefined, merchandiseId: merchandiseId.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch lineId {
				case .value(let lineId):
				guard let lineId = lineId else {
					fields.append("lineId:null")
					break
				}
				fields.append("lineId:\(GraphQL.quoteString(input: "\(lineId.rawValue)"))")
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

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
