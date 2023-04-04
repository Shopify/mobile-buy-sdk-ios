//
//  CartMetafieldsSetPayload.swift
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
	/// Return type for `cartMetafieldsSet` mutation. 
	open class CartMetafieldsSetPayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartMetafieldsSetPayload

		/// The list of cart metafields that were set. 
		@discardableResult
		open func metafields(alias: String? = nil, _ subfields: (MetafieldQuery) -> Void) -> CartMetafieldsSetPayloadQuery {
			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (MetafieldsSetUserErrorQuery) -> Void) -> CartMetafieldsSetPayloadQuery {
			let subquery = MetafieldsSetUserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `cartMetafieldsSet` mutation. 
	open class CartMetafieldsSetPayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartMetafieldsSetPayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "metafields":
				if value is NSNull { return nil }
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartMetafieldsSetPayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try Metafield(fields: $0) }

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartMetafieldsSetPayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try MetafieldsSetUserError(fields: $0) }

				default:
				throw SchemaViolationError(type: CartMetafieldsSetPayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The list of cart metafields that were set. 
		open var metafields: [Storefront.Metafield]? {
			return internalGetMetafields()
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield]? {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield]?
		}

		/// The list of errors that occurred from executing the mutation. 
		open var userErrors: [Storefront.MetafieldsSetUserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.MetafieldsSetUserError] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.MetafieldsSetUserError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
