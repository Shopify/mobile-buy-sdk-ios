//
//  DisplayableError.swift
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

/// Represents an error in the input of a mutation. 
public protocol DisplayableError {
	var field: [String]? { get }

	var message: String { get }
}

extension Storefront {
	/// Represents an error in the input of a mutation. 
	open class DisplayableErrorQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = DisplayableError

		/// Path to the input field which caused the error. 
		@discardableResult
		open func field(alias: String? = nil) -> DisplayableErrorQuery {
			addField(field: "field", aliasSuffix: alias)
			return self
		}

		/// The error message. 
		@discardableResult
		open func message(alias: String? = nil) -> DisplayableErrorQuery {
			addField(field: "message", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents an error in the input of a mutation. 
		@discardableResult
		open func onCheckoutUserError(subfields: (CheckoutUserErrorQuery) -> Void) -> DisplayableErrorQuery {
			let subquery = CheckoutUserErrorQuery()
			subfields(subquery)
			addInlineFragment(on: "CheckoutUserError", subfields: subquery)
			return self
		}

		/// Represents an error in the input of a mutation. 
		@discardableResult
		open func onCustomerUserError(subfields: (CustomerUserErrorQuery) -> Void) -> DisplayableErrorQuery {
			let subquery = CustomerUserErrorQuery()
			subfields(subquery)
			addInlineFragment(on: "CustomerUserError", subfields: subquery)
			return self
		}

		/// Represents an error in the input of a mutation. 
		@discardableResult
		open func onUserError(subfields: (UserErrorQuery) -> Void) -> DisplayableErrorQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)
			addInlineFragment(on: "UserError", subfields: subquery)
			return self
		}
	}

	/// Represents an error in the input of a mutation. 
	open class UnknownDisplayableError: GraphQL.AbstractResponse, GraphQLObject, DisplayableError {
		public typealias Query = DisplayableErrorQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "field":
				if value is NSNull { return nil }
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: UnknownDisplayableError.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "message":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownDisplayableError.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: UnknownDisplayableError.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> DisplayableError {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownDisplayableError.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CheckoutUserError": return try CheckoutUserError.init(fields: fields)

				case "CustomerUserError": return try CustomerUserError.init(fields: fields)

				case "UserError": return try UserError.init(fields: fields)

				default:
				return try UnknownDisplayableError.init(fields: fields)
			}
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
