//
//  SellingPlanGroup.swift
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
	/// Represents a selling method. For example, 'Subscribe and save' is a selling 
	/// method where customers pay for goods or services per delivery. A selling 
	/// plan group contains individual selling plans. 
	open class SellingPlanGroupQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = SellingPlanGroup

		/// A display friendly name for the app that created the selling plan group. 
		@discardableResult
		open func appName(alias: String? = nil) -> SellingPlanGroupQuery {
			addField(field: "appName", aliasSuffix: alias)
			return self
		}

		/// The name of the selling plan group. 
		@discardableResult
		open func name(alias: String? = nil) -> SellingPlanGroupQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// Represents the selling plan options available in the drop-down list in the 
		/// storefront. For example, 'Delivery every week' or 'Delivery every 2 weeks' 
		/// specifies the delivery frequency options for the product. 
		@discardableResult
		open func options(alias: String? = nil, _ subfields: (SellingPlanGroupOptionQuery) -> Void) -> SellingPlanGroupQuery {
			let subquery = SellingPlanGroupOptionQuery()
			subfields(subquery)

			addField(field: "options", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of selling plans in a selling plan group. A selling plan is a 
		/// representation of how products and variants can be sold and purchased. For 
		/// example, an individual selling plan could be '6 weeks of prepaid granola, 
		/// delivered weekly'. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func sellingPlans(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (SellingPlanConnectionQuery) -> Void) -> SellingPlanGroupQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = SellingPlanConnectionQuery()
			subfields(subquery)

			addField(field: "sellingPlans", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}
	}

	/// Represents a selling method. For example, 'Subscribe and save' is a selling 
	/// method where customers pay for goods or services per delivery. A selling 
	/// plan group contains individual selling plans. 
	open class SellingPlanGroup: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SellingPlanGroupQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "appName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlanGroup.self, field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: SellingPlanGroup.self, field: fieldName, value: fieldValue)
				}
				return value

				case "options":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: SellingPlanGroup.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SellingPlanGroupOption(fields: $0) }

				case "sellingPlans":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: SellingPlanGroup.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlanConnection(fields: value)

				default:
				throw SchemaViolationError(type: SellingPlanGroup.self, field: fieldName, value: fieldValue)
			}
		}

		/// A display friendly name for the app that created the selling plan group. 
		open var appName: String? {
			return internalGetAppName()
		}

		func internalGetAppName(alias: String? = nil) -> String? {
			return field(field: "appName", aliasSuffix: alias) as! String?
		}

		/// The name of the selling plan group. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// Represents the selling plan options available in the drop-down list in the 
		/// storefront. For example, 'Delivery every week' or 'Delivery every 2 weeks' 
		/// specifies the delivery frequency options for the product. 
		open var options: [Storefront.SellingPlanGroupOption] {
			return internalGetOptions()
		}

		func internalGetOptions(alias: String? = nil) -> [Storefront.SellingPlanGroupOption] {
			return field(field: "options", aliasSuffix: alias) as! [Storefront.SellingPlanGroupOption]
		}

		/// A list of selling plans in a selling plan group. A selling plan is a 
		/// representation of how products and variants can be sold and purchased. For 
		/// example, an individual selling plan could be '6 weeks of prepaid granola, 
		/// delivered weekly'. 
		open var sellingPlans: Storefront.SellingPlanConnection {
			return internalGetSellingPlans()
		}

		open func aliasedSellingPlans(alias: String) -> Storefront.SellingPlanConnection {
			return internalGetSellingPlans(alias: alias)
		}

		func internalGetSellingPlans(alias: String? = nil) -> Storefront.SellingPlanConnection {
			return field(field: "sellingPlans", aliasSuffix: alias) as! Storefront.SellingPlanConnection
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "options":
					internalGetOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "sellingPlans":
					response.append(internalGetSellingPlans())
					response.append(contentsOf: internalGetSellingPlans().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
