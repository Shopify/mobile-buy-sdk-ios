//
//  CartBuyerIdentity.swift
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
	/// Represents information about the buyer that is interacting with the cart. 
	open class CartBuyerIdentityQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartBuyerIdentity

		/// The country where the buyer is located. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The customer account associated with the cart. 
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CartBuyerIdentityQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The email address of the buyer that is interacting with the cart. 
		@discardableResult
		open func email(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The phone number of the buyer that is interacting with the cart. 
		@discardableResult
		open func phone(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}
	}

	/// Represents information about the buyer that is interacting with the cart. 
	open class CartBuyerIdentity: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartBuyerIdentityQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "countryCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
			}
		}

		/// The country where the buyer is located. 
		open var countryCode: Storefront.CountryCode? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> Storefront.CountryCode? {
			return field(field: "countryCode", aliasSuffix: alias) as! Storefront.CountryCode?
		}

		/// The customer account associated with the cart. 
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// The email address of the buyer that is interacting with the cart. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// The phone number of the buyer that is interacting with the cart. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
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

					default:
					break
				}
			}
			return response
		}
	}
}
