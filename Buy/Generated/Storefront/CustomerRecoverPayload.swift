//
//  CustomerRecoverPayload.swift
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
	/// Return type for `customerRecover` mutation. 
	open class CustomerRecoverPayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CustomerRecoverPayload

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func customerUserErrors(alias: String? = nil, _ subfields: (CustomerUserErrorQuery) -> Void) -> CustomerRecoverPayloadQuery {
			let subquery = CustomerUserErrorQuery()
			subfields(subquery)

			addField(field: "customerUserErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@available(*, deprecated, message:"Use `customerUserErrors` instead")
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CustomerRecoverPayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `customerRecover` mutation. 
	open class CustomerRecoverPayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CustomerRecoverPayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customerUserErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CustomerRecoverPayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CustomerUserError(fields: $0) }

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CustomerRecoverPayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: CustomerRecoverPayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The list of errors that occurred from executing the mutation. 
		open var customerUserErrors: [Storefront.CustomerUserError] {
			return internalGetCustomerUserErrors()
		}

		func internalGetCustomerUserErrors(alias: String? = nil) -> [Storefront.CustomerUserError] {
			return field(field: "customerUserErrors", aliasSuffix: alias) as! [Storefront.CustomerUserError]
		}

		/// The list of errors that occurred from executing the mutation. 
		@available(*, deprecated, message:"Use `customerUserErrors` instead")
		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.UserError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
