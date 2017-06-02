//
//  CreditCard.swift
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
	/// Credit card information used for a payment. 
	open class CreditCardQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CreditCard

		@discardableResult
		open func brand(alias: String? = nil) -> CreditCardQuery {
			addField(field: "brand", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func expiryMonth(alias: String? = nil) -> CreditCardQuery {
			addField(field: "expiryMonth", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func expiryYear(alias: String? = nil) -> CreditCardQuery {
			addField(field: "expiryYear", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func firstDigits(alias: String? = nil) -> CreditCardQuery {
			addField(field: "firstDigits", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func firstName(alias: String? = nil) -> CreditCardQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func lastDigits(alias: String? = nil) -> CreditCardQuery {
			addField(field: "lastDigits", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func lastName(alias: String? = nil) -> CreditCardQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		/// Masked credit card number with only the last 4 digits displayed 
		@discardableResult
		open func maskedNumber(alias: String? = nil) -> CreditCardQuery {
			addField(field: "maskedNumber", aliasSuffix: alias)
			return self
		}
	}

	/// Credit card information used for a payment. 
	open class CreditCard: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CreditCardQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "brand":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "expiryMonth":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "expiryYear":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "firstDigits":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "lastDigits":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "maskedNumber":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var brand: String? {
			return internalGetBrand()
		}

		func internalGetBrand(alias: String? = nil) -> String? {
			return field(field: "brand", aliasSuffix: alias) as! String?
		}

		open var expiryMonth: Int32? {
			return internalGetExpiryMonth()
		}

		func internalGetExpiryMonth(alias: String? = nil) -> Int32? {
			return field(field: "expiryMonth", aliasSuffix: alias) as! Int32?
		}

		open var expiryYear: Int32? {
			return internalGetExpiryYear()
		}

		func internalGetExpiryYear(alias: String? = nil) -> Int32? {
			return field(field: "expiryYear", aliasSuffix: alias) as! Int32?
		}

		open var firstDigits: String? {
			return internalGetFirstDigits()
		}

		func internalGetFirstDigits(alias: String? = nil) -> String? {
			return field(field: "firstDigits", aliasSuffix: alias) as! String?
		}

		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: alias) as! String?
		}

		open var lastDigits: String? {
			return internalGetLastDigits()
		}

		func internalGetLastDigits(alias: String? = nil) -> String? {
			return field(field: "lastDigits", aliasSuffix: alias) as! String?
		}

		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: alias) as! String?
		}

		/// Masked credit card number with only the last 4 digits displayed 
		open var maskedNumber: String? {
			return internalGetMaskedNumber()
		}

		func internalGetMaskedNumber(alias: String? = nil) -> String? {
			return field(field: "maskedNumber", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
