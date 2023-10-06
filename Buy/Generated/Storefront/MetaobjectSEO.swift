//
//  MetaobjectSEO.swift
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
	/// SEO information for a metaobject. 
	open class MetaobjectSEOQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MetaobjectSEO

		/// The meta description. 
		@discardableResult
		open func description(alias: String? = nil, _ subfields: (MetaobjectFieldQuery) -> Void) -> MetaobjectSEOQuery {
			let subquery = MetaobjectFieldQuery()
			subfields(subquery)

			addField(field: "description", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The SEO title. 
		@discardableResult
		open func title(alias: String? = nil, _ subfields: (MetaobjectFieldQuery) -> Void) -> MetaobjectSEOQuery {
			let subquery = MetaobjectFieldQuery()
			subfields(subquery)

			addField(field: "title", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// SEO information for a metaobject. 
	open class MetaobjectSEO: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = MetaobjectSEOQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "description":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MetaobjectSEO.self, field: fieldName, value: fieldValue)
				}
				return try MetaobjectField(fields: value)

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MetaobjectSEO.self, field: fieldName, value: fieldValue)
				}
				return try MetaobjectField(fields: value)

				default:
				throw SchemaViolationError(type: MetaobjectSEO.self, field: fieldName, value: fieldValue)
			}
		}

		/// The meta description. 
		open var description: Storefront.MetaobjectField? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> Storefront.MetaobjectField? {
			return field(field: "description", aliasSuffix: alias) as! Storefront.MetaobjectField?
		}

		/// The SEO title. 
		open var title: Storefront.MetaobjectField? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> Storefront.MetaobjectField? {
			return field(field: "title", aliasSuffix: alias) as! Storefront.MetaobjectField?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "description":
					if let value = internalGetDescription() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "title":
					if let value = internalGetTitle() {
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
