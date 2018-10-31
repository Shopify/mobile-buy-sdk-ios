//
//  CheckoutUserError.swift
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
	/// Represents an error that happens during execution of a checkout mutation. 
	open class CheckoutUserErrorQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CheckoutUserError

		/// Error code to uniquely identify the error. 
		@discardableResult
		open func code(alias: String? = nil) -> CheckoutUserErrorQuery {
			addField(field: "code", aliasSuffix: alias)
			return self
		}

		/// Path to the input field which caused the error. 
		@discardableResult
		open func field(alias: String? = nil) -> CheckoutUserErrorQuery {
			addField(field: "field", aliasSuffix: alias)
			return self
		}

		/// The error message. 
		@discardableResult
		open func message(alias: String? = nil) -> CheckoutUserErrorQuery {
			addField(field: "message", aliasSuffix: alias)
			return self
		}
	}

	/// Represents an error that happens during execution of a checkout mutation. 
	open class CheckoutUserError: GraphQL.AbstractResponse, GraphQLObject, DisplayableError {
		public typealias Query = CheckoutUserErrorQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "code":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CheckoutUserError.self, field: fieldName, value: fieldValue)
				}
				return CheckoutErrorCode(rawValue: value) ?? .unknownValue

				case "field":
				if value is NSNull { return nil }
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: CheckoutUserError.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "message":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CheckoutUserError.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: CheckoutUserError.self, field: fieldName, value: fieldValue)
			}
		}

		/// Error code to uniquely identify the error. 
		open var code: Storefront.CheckoutErrorCode? {
			return internalGetCode()
		}

		func internalGetCode(alias: String? = nil) -> Storefront.CheckoutErrorCode? {
			return field(field: "code", aliasSuffix: alias) as! Storefront.CheckoutErrorCode?
		}

		/// Path to the input field which caused the error. 
		open var field: [String]? {
			return internalGetField()
		}

		func internalGetField(alias: String? = nil) -> [String]? {
			return field(field: "field", aliasSuffix: alias) as! [String]?
		}

		/// The error message. 
		open var message: String {
			return internalGetMessage()
		}

		func internalGetMessage(alias: String? = nil) -> String {
			return field(field: "message", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
