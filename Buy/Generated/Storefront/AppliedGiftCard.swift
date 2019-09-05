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

		/// The amount that was taken from the Gift Card by applying it. 
		@available(*, deprecated, message:"Use `amountUsedV2` instead")
		@discardableResult
		open func amountUsed(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "amountUsed", aliasSuffix: alias)
			return self
		}

		/// The amount that was taken from the Gift Card by applying it. 
		@discardableResult
		open func amountUsedV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> AppliedGiftCardQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "amountUsedV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The amount left on the Gift Card. 
		@available(*, deprecated, message:"Use `balanceV2` instead")
		@discardableResult
		open func balance(alias: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "balance", aliasSuffix: alias)
			return self
		}

		/// The amount left on the Gift Card. 
		@discardableResult
		open func balanceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> AppliedGiftCardQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "balanceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Globally unique identifier. 
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

		/// The amount that was applied to the checkout in its currency. 
		@discardableResult
		open func presentmentAmountUsed(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> AppliedGiftCardQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "presentmentAmountUsed", aliasSuffix: alias, subfields: subquery)
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
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "amountUsedV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "balance":
				guard let value = value as? String else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "balanceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastCharacters":
				guard let value = value as? String else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return value

				case "presentmentAmountUsed":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: AppliedGiftCard.self, field: fieldName, value: fieldValue)
			}
		}

		/// The amount that was taken from the Gift Card by applying it. 
		@available(*, deprecated, message:"Use `amountUsedV2` instead")
		open var amountUsed: Decimal {
			return internalGetAmountUsed()
		}

		func internalGetAmountUsed(alias: String? = nil) -> Decimal {
			return field(field: "amountUsed", aliasSuffix: alias) as! Decimal
		}

		/// The amount that was taken from the Gift Card by applying it. 
		open var amountUsedV2: Storefront.MoneyV2 {
			return internalGetAmountUsedV2()
		}

		func internalGetAmountUsedV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "amountUsedV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The amount left on the Gift Card. 
		@available(*, deprecated, message:"Use `balanceV2` instead")
		open var balance: Decimal {
			return internalGetBalance()
		}

		func internalGetBalance(alias: String? = nil) -> Decimal {
			return field(field: "balance", aliasSuffix: alias) as! Decimal
		}

		/// The amount left on the Gift Card. 
		open var balanceV2: Storefront.MoneyV2 {
			return internalGetBalanceV2()
		}

		func internalGetBalanceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "balanceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// Globally unique identifier. 
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

		/// The amount that was applied to the checkout in its currency. 
		open var presentmentAmountUsed: Storefront.MoneyV2 {
			return internalGetPresentmentAmountUsed()
		}

		func internalGetPresentmentAmountUsed(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "presentmentAmountUsed", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "amountUsedV2":
					response.append(internalGetAmountUsedV2())
					response.append(contentsOf: internalGetAmountUsedV2().childResponseObjectMap())

					case "balanceV2":
					response.append(internalGetBalanceV2())
					response.append(contentsOf: internalGetBalanceV2().childResponseObjectMap())

					case "presentmentAmountUsed":
					response.append(internalGetPresentmentAmountUsed())
					response.append(contentsOf: internalGetPresentmentAmountUsed().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
