//
//  ShopPayPaymentRequestContactField.swift
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
	/// Represents a contact field for a Shop Pay payment request. 
	open class ShopPayPaymentRequestContactFieldQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayPaymentRequestContactField

		/// The first address line of the contact field. 
		@discardableResult
		open func address1(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "address1", aliasSuffix: alias)
			return self
		}

		/// The second address line of the contact field. 
		@discardableResult
		open func address2(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "address2", aliasSuffix: alias)
			return self
		}

		/// The city of the contact field. 
		@discardableResult
		open func city(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "city", aliasSuffix: alias)
			return self
		}

		/// The company name of the contact field. 
		@discardableResult
		open func companyName(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "companyName", aliasSuffix: alias)
			return self
		}

		/// The country of the contact field. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The email of the contact field. 
		@discardableResult
		open func email(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The first name of the contact field. 
		@discardableResult
		open func firstName(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		/// The first name of the contact field. 
		@discardableResult
		open func lastName(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		/// The phone number of the contact field. 
		@discardableResult
		open func phone(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// The postal code of the contact field. 
		@discardableResult
		open func postalCode(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "postalCode", aliasSuffix: alias)
			return self
		}

		/// The province of the contact field. 
		@discardableResult
		open func provinceCode(alias: String? = nil) -> ShopPayPaymentRequestContactFieldQuery {
			addField(field: "provinceCode", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a contact field for a Shop Pay payment request. 
	open class ShopPayPaymentRequestContactField: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ShopPayPaymentRequestContactFieldQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "address1":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "address2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "city":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "companyName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "countryCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "lastName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "postalCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				case "provinceCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ShopPayPaymentRequestContactField.self, field: fieldName, value: fieldValue)
			}
		}

		/// The first address line of the contact field. 
		open var address1: String {
			return internalGetAddress1()
		}

		func internalGetAddress1(alias: String? = nil) -> String {
			return field(field: "address1", aliasSuffix: alias) as! String
		}

		/// The second address line of the contact field. 
		open var address2: String? {
			return internalGetAddress2()
		}

		func internalGetAddress2(alias: String? = nil) -> String? {
			return field(field: "address2", aliasSuffix: alias) as! String?
		}

		/// The city of the contact field. 
		open var city: String {
			return internalGetCity()
		}

		func internalGetCity(alias: String? = nil) -> String {
			return field(field: "city", aliasSuffix: alias) as! String
		}

		/// The company name of the contact field. 
		open var companyName: String? {
			return internalGetCompanyName()
		}

		func internalGetCompanyName(alias: String? = nil) -> String? {
			return field(field: "companyName", aliasSuffix: alias) as! String?
		}

		/// The country of the contact field. 
		open var countryCode: String {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> String {
			return field(field: "countryCode", aliasSuffix: alias) as! String
		}

		/// The email of the contact field. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// The first name of the contact field. 
		open var firstName: String {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String {
			return field(field: "firstName", aliasSuffix: alias) as! String
		}

		/// The first name of the contact field. 
		open var lastName: String {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String {
			return field(field: "lastName", aliasSuffix: alias) as! String
		}

		/// The phone number of the contact field. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// The postal code of the contact field. 
		open var postalCode: String? {
			return internalGetPostalCode()
		}

		func internalGetPostalCode(alias: String? = nil) -> String? {
			return field(field: "postalCode", aliasSuffix: alias) as! String?
		}

		/// The province of the contact field. 
		open var provinceCode: String? {
			return internalGetProvinceCode()
		}

		func internalGetProvinceCode(alias: String? = nil) -> String? {
			return field(field: "provinceCode", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
