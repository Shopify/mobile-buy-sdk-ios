//
//  DiscountAllocation.swift
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
	/// An amount discounting the line that has been allocated by a discount. 
	open class DiscountAllocationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = DiscountAllocation

		/// Amount of discount allocated. 
		@discardableResult
		open func allocatedAmount(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> DiscountAllocationQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "allocatedAmount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The discount this allocated amount originated from. 
		@discardableResult
		open func discountApplication(alias: String? = nil, _ subfields: (DiscountApplicationQuery) -> Void) -> DiscountAllocationQuery {
			let subquery = DiscountApplicationQuery()
			subfields(subquery)

			addField(field: "discountApplication", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// An amount discounting the line that has been allocated by a discount. 
	open class DiscountAllocation: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = DiscountAllocationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "allocatedAmount":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: DiscountAllocation.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "discountApplication":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: DiscountAllocation.self, field: fieldName, value: fieldValue)
				}
				return try UnknownDiscountApplication.create(fields: value)

				default:
				throw SchemaViolationError(type: DiscountAllocation.self, field: fieldName, value: fieldValue)
			}
		}

		/// Amount of discount allocated. 
		open var allocatedAmount: Storefront.MoneyV2 {
			return internalGetAllocatedAmount()
		}

		func internalGetAllocatedAmount(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "allocatedAmount", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The discount this allocated amount originated from. 
		open var discountApplication: DiscountApplication {
			return internalGetDiscountApplication()
		}

		func internalGetDiscountApplication(alias: String? = nil) -> DiscountApplication {
			return field(field: "discountApplication", aliasSuffix: alias) as! DiscountApplication
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "allocatedAmount":
					response.append(internalGetAllocatedAmount())
					response.append(contentsOf: internalGetAllocatedAmount().childResponseObjectMap())

					case "discountApplication":
					response.append((internalGetDiscountApplication() as! GraphQL.AbstractResponse))
					response.append(contentsOf: (internalGetDiscountApplication() as! GraphQL.AbstractResponse).childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
