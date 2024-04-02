//
//  PurchasingCompany.swift
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
	open class PurchasingCompanyQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = PurchasingCompany

		/// The company associated to the order or draft order. 
		@discardableResult
		open func company(alias: String? = nil, _ subfields: (CompanyQuery) -> Void) -> PurchasingCompanyQuery {
			let subquery = CompanyQuery()
			subfields(subquery)

			addField(field: "company", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The company contact associated to the order or draft order. 
		@discardableResult
		open func contact(alias: String? = nil, _ subfields: (CompanyContactQuery) -> Void) -> PurchasingCompanyQuery {
			let subquery = CompanyContactQuery()
			subfields(subquery)

			addField(field: "contact", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The company location associated to the order or draft order. 
		@discardableResult
		open func location(alias: String? = nil, _ subfields: (CompanyLocationQuery) -> Void) -> PurchasingCompanyQuery {
			let subquery = CompanyLocationQuery()
			subfields(subquery)

			addField(field: "location", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents information about the buyer that is interacting with the cart. 
	open class PurchasingCompany: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = PurchasingCompanyQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "company":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: PurchasingCompany.self, field: fieldName, value: fieldValue)
				}
				return try Company(fields: value)

				case "contact":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: PurchasingCompany.self, field: fieldName, value: fieldValue)
				}
				return try CompanyContact(fields: value)

				case "location":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: PurchasingCompany.self, field: fieldName, value: fieldValue)
				}
				return try CompanyLocation(fields: value)

				default:
				throw SchemaViolationError(type: PurchasingCompany.self, field: fieldName, value: fieldValue)
			}
		}

		/// The company associated to the order or draft order. 
		open var company: Storefront.Company {
			return internalGetCompany()
		}

		func internalGetCompany(alias: String? = nil) -> Storefront.Company {
			return field(field: "company", aliasSuffix: alias) as! Storefront.Company
		}

		/// The company contact associated to the order or draft order. 
		open var contact: Storefront.CompanyContact? {
			return internalGetContact()
		}

		func internalGetContact(alias: String? = nil) -> Storefront.CompanyContact? {
			return field(field: "contact", aliasSuffix: alias) as! Storefront.CompanyContact?
		}

		/// The company location associated to the order or draft order. 
		open var location: Storefront.CompanyLocation {
			return internalGetLocation()
		}

		func internalGetLocation(alias: String? = nil) -> Storefront.CompanyLocation {
			return field(field: "location", aliasSuffix: alias) as! Storefront.CompanyLocation
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "company":
					response.append(internalGetCompany())
					response.append(contentsOf: internalGetCompany().childResponseObjectMap())

					case "contact":
					if let value = internalGetContact() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "location":
					response.append(internalGetLocation())
					response.append(contentsOf: internalGetLocation().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
