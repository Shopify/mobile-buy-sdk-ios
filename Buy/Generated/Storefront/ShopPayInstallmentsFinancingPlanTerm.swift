//
//  ShopPayInstallmentsFinancingPlanTerm.swift
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
	/// The terms of the financing plan in Shop Pay Installments. 
	open class ShopPayInstallmentsFinancingPlanTermQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayInstallmentsFinancingPlanTerm

		/// The annual percentage rate (APR) of the financing plan. 
		@discardableResult
		open func apr(alias: String? = nil) -> ShopPayInstallmentsFinancingPlanTermQuery {
			addField(field: "apr", aliasSuffix: alias)
			return self
		}

		/// The payment frequency for the financing plan. 
		@discardableResult
		open func frequency(alias: String? = nil) -> ShopPayInstallmentsFinancingPlanTermQuery {
			addField(field: "frequency", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ShopPayInstallmentsFinancingPlanTermQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The number of installments for the financing plan. 
		@discardableResult
		open func installmentsCount(alias: String? = nil, _ subfields: (CountQuery) -> Void) -> ShopPayInstallmentsFinancingPlanTermQuery {
			let subquery = CountQuery()
			subfields(subquery)

			addField(field: "installmentsCount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The type of loan for the financing plan. 
		@discardableResult
		open func loanType(alias: String? = nil) -> ShopPayInstallmentsFinancingPlanTermQuery {
			addField(field: "loanType", aliasSuffix: alias)
			return self
		}
	}

	/// The terms of the financing plan in Shop Pay Installments. 
	open class ShopPayInstallmentsFinancingPlanTerm: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ShopPayInstallmentsFinancingPlanTermQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "apr":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "frequency":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
				}
				return ShopPayInstallmentsFinancingPlanFrequency(rawValue: value) ?? .unknownValue

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "installmentsCount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
				}
				return try Count(fields: value)

				case "loanType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
				}
				return ShopPayInstallmentsLoan(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: ShopPayInstallmentsFinancingPlanTerm.self, field: fieldName, value: fieldValue)
			}
		}

		/// The annual percentage rate (APR) of the financing plan. 
		open var apr: Int32 {
			return internalGetApr()
		}

		func internalGetApr(alias: String? = nil) -> Int32 {
			return field(field: "apr", aliasSuffix: alias) as! Int32
		}

		/// The payment frequency for the financing plan. 
		open var frequency: Storefront.ShopPayInstallmentsFinancingPlanFrequency {
			return internalGetFrequency()
		}

		func internalGetFrequency(alias: String? = nil) -> Storefront.ShopPayInstallmentsFinancingPlanFrequency {
			return field(field: "frequency", aliasSuffix: alias) as! Storefront.ShopPayInstallmentsFinancingPlanFrequency
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The number of installments for the financing plan. 
		open var installmentsCount: Storefront.Count? {
			return internalGetInstallmentsCount()
		}

		func internalGetInstallmentsCount(alias: String? = nil) -> Storefront.Count? {
			return field(field: "installmentsCount", aliasSuffix: alias) as! Storefront.Count?
		}

		/// The type of loan for the financing plan. 
		open var loanType: Storefront.ShopPayInstallmentsLoan {
			return internalGetLoanType()
		}

		func internalGetLoanType(alias: String? = nil) -> Storefront.ShopPayInstallmentsLoan {
			return field(field: "loanType", aliasSuffix: alias) as! Storefront.ShopPayInstallmentsLoan
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "installmentsCount":
					if let value = internalGetInstallmentsCount() {
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
