//
//  Metaobject.swift
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
	/// An instance of a user-defined model based on a MetaobjectDefinition. 
	open class MetaobjectQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Metaobject

		/// Accesses a field of the object by key. 
		///
		/// - parameters:
		///     - key: The key of the field.
		///
		@discardableResult
		open func field(alias: String? = nil, key: String, _ subfields: (MetaobjectFieldQuery) -> Void) -> MetaobjectQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetaobjectFieldQuery()
			subfields(subquery)

			addField(field: "field", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// All object fields with defined values. Omitted object keys can be assumed 
		/// null, and no guarantees are made about field order. 
		@discardableResult
		open func fields(alias: String? = nil, _ subfields: (MetaobjectFieldQuery) -> Void) -> MetaobjectQuery {
			let subquery = MetaobjectFieldQuery()
			subfields(subquery)

			addField(field: "fields", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The unique handle of the metaobject. Useful as a custom ID. 
		@discardableResult
		open func handle(alias: String? = nil) -> MetaobjectQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> MetaobjectQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The URL used for viewing the metaobject on the shop's Online Store. Returns 
		/// `null` if the metaobject definition doesn't have the `online_store` 
		/// capability. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> MetaobjectQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// The metaobject's SEO information. Returns `null` if the metaobject 
		/// definition doesn't have the `renderable` capability. 
		@discardableResult
		open func seo(alias: String? = nil, _ subfields: (MetaobjectSEOQuery) -> Void) -> MetaobjectQuery {
			let subquery = MetaobjectSEOQuery()
			subfields(subquery)

			addField(field: "seo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The type of the metaobject. Defines the namespace of its associated 
		/// metafields. 
		@discardableResult
		open func type(alias: String? = nil) -> MetaobjectQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The date and time when the metaobject was last updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> MetaobjectQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// An instance of a user-defined model based on a MetaobjectDefinition. 
	open class Metaobject: GraphQL.AbstractResponse, GraphQLObject, MetafieldReference, Node, OnlineStorePublishable {
		public typealias Query = MetaobjectQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "field":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return try MetaobjectField(fields: value)

				case "fields":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try MetaobjectField(fields: $0) }

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "seo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return try MetaobjectSEO(fields: value)

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: Metaobject.self, field: fieldName, value: fieldValue)
			}
		}

		/// Accesses a field of the object by key. 
		open var field: Storefront.MetaobjectField? {
			return internalGetField()
		}

		open func aliasedField(alias: String) -> Storefront.MetaobjectField? {
			return internalGetField(alias: alias)
		}

		func internalGetField(alias: String? = nil) -> Storefront.MetaobjectField? {
			return field(field: "field", aliasSuffix: alias) as! Storefront.MetaobjectField?
		}

		/// All object fields with defined values. Omitted object keys can be assumed 
		/// null, and no guarantees are made about field order. 
		open var fields: [Storefront.MetaobjectField] {
			return internalGetFields()
		}

		func internalGetFields(alias: String? = nil) -> [Storefront.MetaobjectField] {
			return field(field: "fields", aliasSuffix: alias) as! [Storefront.MetaobjectField]
		}

		/// The unique handle of the metaobject. Useful as a custom ID. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The URL used for viewing the metaobject on the shop's Online Store. Returns 
		/// `null` if the metaobject definition doesn't have the `online_store` 
		/// capability. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		/// The metaobject's SEO information. Returns `null` if the metaobject 
		/// definition doesn't have the `renderable` capability. 
		open var seo: Storefront.MetaobjectSEO? {
			return internalGetSeo()
		}

		func internalGetSeo(alias: String? = nil) -> Storefront.MetaobjectSEO? {
			return field(field: "seo", aliasSuffix: alias) as! Storefront.MetaobjectSEO?
		}

		/// The type of the metaobject. Defines the namespace of its associated 
		/// metafields. 
		open var type: String {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> String {
			return field(field: "type", aliasSuffix: alias) as! String
		}

		/// The date and time when the metaobject was last updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "field":
					if let value = internalGetField() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "fields":
					internalGetFields().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "seo":
					if let value = internalGetSeo() {
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
