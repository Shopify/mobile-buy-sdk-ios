//
//  SellingPlanGroupOption.swift
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
	/// Represents an option on a selling plan group that's available in the 
	/// drop-down list in the storefront. 
	open class SellingPlanGroupOptionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanGroupOption

		/// The name of the option. For example, 'Delivery every'. 
		@discardableResult
		open func name(alias: String? = nil) -> SellingPlanGroupOptionQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// The values for the options specified by the selling plans in the selling 
		/// plan group. For example, '1 week', '2 weeks', '3 weeks'. 
		@discardableResult
		open func values(alias: String? = nil) -> SellingPlanGroupOptionQuery {
			addField(field: "values", aliasSuffix: alias)
			return self
		}
	}

	/// Represents an option on a selling plan group that's available in the 
	/// drop-down list in the storefront. 
	open class SellingPlanGroupOption: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanGroupOptionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlanGroupOption.self, field: fieldName, value: fieldValue)
				}
				return value

				case "values":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: SellingPlanGroupOption.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				default:
				throw SchemaViolationError(type: SellingPlanGroupOption.self, field: fieldName, value: fieldValue)
			}
		}

		/// The name of the option. For example, 'Delivery every'. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// The values for the options specified by the selling plans in the selling 
		/// plan group. For example, '1 week', '2 weeks', '3 weeks'. 
		open var values: [String] {
			return internalGetValues()
		}

		func internalGetValues(alias: String? = nil) -> [String] {
			return field(field: "values", aliasSuffix: alias) as! [String]
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
