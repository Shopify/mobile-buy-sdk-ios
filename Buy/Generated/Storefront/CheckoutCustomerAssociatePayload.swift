//
//  CheckoutCustomerAssociatePayload.swift
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
	/// Return type for `checkoutCustomerAssociate` mutation. 
	open class CheckoutCustomerAssociatePayloadQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CheckoutCustomerAssociatePayload

		/// The updated checkout object. 
		@discardableResult
		open func checkout(alias: String? = nil, _ subfields: (CheckoutQuery) -> Void) -> CheckoutCustomerAssociatePayloadQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)

			addField(field: "checkout", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The associated customer object. 
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CheckoutCustomerAssociatePayloadQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of errors that occurred executing the mutation. 
		@discardableResult
		open func userErrors(alias: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CheckoutCustomerAssociatePayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Return type for `checkoutCustomerAssociate` mutation. 
	open class CheckoutCustomerAssociatePayload: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CheckoutCustomerAssociatePayloadQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkout":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CheckoutCustomerAssociatePayload.self, field: fieldName, value: fieldValue)
				}
				return try Checkout(fields: value)

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CheckoutCustomerAssociatePayload.self, field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CheckoutCustomerAssociatePayload.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: CheckoutCustomerAssociatePayload.self, field: fieldName, value: fieldValue)
			}
		}

		/// The updated checkout object. 
		open var checkout: Storefront.Checkout {
			return internalGetCheckout()
		}

		func internalGetCheckout(alias: String? = nil) -> Storefront.Checkout {
			return field(field: "checkout", aliasSuffix: alias) as! Storefront.Checkout
		}

		/// The associated customer object. 
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// List of errors that occurred executing the mutation. 
		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(alias: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: alias) as! [Storefront.UserError]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "checkout":
					response.append(internalGetCheckout())
					response.append(contentsOf: internalGetCheckout().childResponseObjectMap())

					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "userErrors":
					internalGetUserErrors().forEach {
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
