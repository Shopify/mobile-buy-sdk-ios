//
//  Transaction.swift
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
	/// An object representing exchange of money for a product or service. 
	open class TransactionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Transaction

		/// The amount of money that the transaction was for. 
		@available(*, deprecated, message:"Use `amountV2` instead")
		@discardableResult
		open func amount(alias: String? = nil) -> TransactionQuery {
			addField(field: "amount", aliasSuffix: alias)
			return self
		}

		/// The amount of money that the transaction was for. 
		@discardableResult
		open func amountV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> TransactionQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "amountV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The kind of the transaction. 
		@discardableResult
		open func kind(alias: String? = nil) -> TransactionQuery {
			addField(field: "kind", aliasSuffix: alias)
			return self
		}

		/// The status of the transaction. 
		@available(*, deprecated, message:"Use `statusV2` instead")
		@discardableResult
		open func status(alias: String? = nil) -> TransactionQuery {
			addField(field: "status", aliasSuffix: alias)
			return self
		}

		/// The status of the transaction. 
		@discardableResult
		open func statusV2(alias: String? = nil) -> TransactionQuery {
			addField(field: "statusV2", aliasSuffix: alias)
			return self
		}

		/// Whether the transaction was done in test mode or not. 
		@discardableResult
		open func test(alias: String? = nil) -> TransactionQuery {
			addField(field: "test", aliasSuffix: alias)
			return self
		}
	}

	/// An object representing exchange of money for a product or service. 
	open class Transaction: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = TransactionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "amountV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "kind":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return TransactionKind(rawValue: value) ?? .unknownValue

				case "status":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return TransactionStatus(rawValue: value) ?? .unknownValue

				case "statusV2":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return TransactionStatus(rawValue: value) ?? .unknownValue

				case "test":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Transaction.self, field: fieldName, value: fieldValue)
			}
		}

		/// The amount of money that the transaction was for. 
		@available(*, deprecated, message:"Use `amountV2` instead")
		open var amount: Decimal {
			return internalGetAmount()
		}

		func internalGetAmount(alias: String? = nil) -> Decimal {
			return field(field: "amount", aliasSuffix: alias) as! Decimal
		}

		/// The amount of money that the transaction was for. 
		open var amountV2: Storefront.MoneyV2 {
			return internalGetAmountV2()
		}

		func internalGetAmountV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "amountV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The kind of the transaction. 
		open var kind: Storefront.TransactionKind {
			return internalGetKind()
		}

		func internalGetKind(alias: String? = nil) -> Storefront.TransactionKind {
			return field(field: "kind", aliasSuffix: alias) as! Storefront.TransactionKind
		}

		/// The status of the transaction. 
		@available(*, deprecated, message:"Use `statusV2` instead")
		open var status: Storefront.TransactionStatus {
			return internalGetStatus()
		}

		func internalGetStatus(alias: String? = nil) -> Storefront.TransactionStatus {
			return field(field: "status", aliasSuffix: alias) as! Storefront.TransactionStatus
		}

		/// The status of the transaction. 
		open var statusV2: Storefront.TransactionStatus? {
			return internalGetStatusV2()
		}

		func internalGetStatusV2(alias: String? = nil) -> Storefront.TransactionStatus? {
			return field(field: "statusV2", aliasSuffix: alias) as! Storefront.TransactionStatus?
		}

		/// Whether the transaction was done in test mode or not. 
		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(alias: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "amountV2":
					response.append(internalGetAmountV2())
					response.append(contentsOf: internalGetAmountV2().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
