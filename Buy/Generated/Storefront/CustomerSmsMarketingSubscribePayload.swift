//
//  CustomerSmsMarketingSubscribePayload.swift
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
	/// Return type for `customerSmsMarketingSubscribe` mutation. 
	open class CustomerSmsMarketingSubscribePayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CustomerSmsMarketingSubscribePayload

		/// The created customer object. 
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerMarketingSubscribeQuery) -> Void) -> CustomerSmsMarketingSubscribePayloadQuery {
			let subquery = CustomerMarketingSubscribeQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The list of errors that occurred from executing the mutation. 
		@discardableResult
		open func customerUserErrors(alias: String? = nil, _ subfields: (CustomerUserErrorQuery) -> Void) -> CustomerSmsMarketingSubscribePayloadQuery {
			let subquery = CustomerUserErrorQuery()
			subfields(subquery)

			addField(field: "customerUserErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `customerSmsMarketingSubscribe` mutation. 
	open class CustomerSmsMarketingSubscribePayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CustomerSmsMarketingSubscribePayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CustomerSmsMarketingSubscribePayload.self, field: fieldName, value: fieldValue)
				}
				return try CustomerMarketingSubscribe(fields: value)

				case "customerUserErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CustomerSmsMarketingSubscribePayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try CustomerUserError(fields: $0) }

				default:
				throw SchemaViolationError(type: CustomerSmsMarketingSubscribePayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The created customer object. 
		open var customer: Storefront.CustomerMarketingSubscribe? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.CustomerMarketingSubscribe? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.CustomerMarketingSubscribe?
		}

		/// The list of errors that occurred from executing the mutation. 
		open var customerUserErrors: [Storefront.CustomerUserError] {
			return internalGetCustomerUserErrors()
		}

		func internalGetCustomerUserErrors(alias: String? = nil) -> [Storefront.CustomerUserError] {
			return field(field: "customerUserErrors", aliasSuffix: alias) as! [Storefront.CustomerUserError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerUserErrors":
					internalGetCustomerUserErrors().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
