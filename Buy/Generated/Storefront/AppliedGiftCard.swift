//
//  AppliedGiftCard.swift
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
	/// Details about the gift card used on the checkout. 
	open class AppliedGiftCardQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = AppliedGiftCard

		/// The amount that was used taken from the Gift Card by applying it. 
		@discardableResult
		open func amountUsed(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "amountUsed", aliasSuffix: alias)
			return self
		}

		/// The amount left on the Gift Card. 
		@discardableResult
		open func balance(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "balance", aliasSuffix: alias)
			return self
		}

		@discardableResult
		open func id(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The last characters of the Gift Card code 
		@discardableResult
		open func lastCharacters(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "lastCharacters", aliasSuffix: alias)
			return self
		}
	}

	/// Details about the gift card used on the checkout. 
	open class AppliedGiftCard: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = AppliedGiftCardQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amountUsed":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "balance":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastCharacters":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The amount that was used taken from the Gift Card by applying it. 
		open var amountUsed: Decimal {
			return internalGetAmountUsed()
		}

		func internalGetAmountUsed(alias: String? = nil) -> Decimal {
			return field(field: "amountUsed", aliasSuffix: alias) as! Decimal
		}

		/// The amount left on the Gift Card. 
		open var balance: Decimal {
			return internalGetBalance()
		}

		func internalGetBalance(alias: String? = nil) -> Decimal {
			return field(field: "balance", aliasSuffix: alias) as! Decimal
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The last characters of the Gift Card code 
		open var lastCharacters: String {
			return internalGetLastCharacters()
		}

		func internalGetLastCharacters(alias: String? = nil) -> String {
			return field(field: "lastCharacters", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
