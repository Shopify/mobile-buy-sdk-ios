//
//  OnlineStorePublishable.swift
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

/// Represents a resource that can be published to the Online Store sales 
/// channel. 
public protocol OnlineStorePublishable {
	var onlineStoreUrl: URL? { get }
}

extension Storefront {
	/// Represents a resource that can be published to the Online Store sales 
	/// channel. 
	open class OnlineStorePublishableQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = OnlineStorePublishable

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> OnlineStorePublishableQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onBlog(subfields: (BlogQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = BlogQuery()
			subfields(subquery)
			addInlineFragment(on: "Blog", subfields: subquery)
			return self
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onMetaobject(subfields: (MetaobjectQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = MetaobjectQuery()
			subfields(subquery)
			addInlineFragment(on: "Metaobject", subfields: subquery)
			return self
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// Represents a resource that can be published to the Online Store sales 
		/// channel. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> OnlineStorePublishableQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}
	}

	/// Represents a resource that can be published to the Online Store sales 
	/// channel. 
	open class UnknownOnlineStorePublishable: GraphQL.AbstractResponse, GraphQLObject, OnlineStorePublishable {
		public typealias Query = OnlineStorePublishableQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownOnlineStorePublishable.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: UnknownOnlineStorePublishable.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> OnlineStorePublishable {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownOnlineStorePublishable.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Article": return try Article.init(fields: fields)

				case "Blog": return try Blog.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Metaobject": return try Metaobject.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				default:
				return try UnknownOnlineStorePublishable.init(fields: fields)
			}
		}

		/// The URL used for viewing the resource on the shop's Online Store. Returns 
		/// `null` if the resource is currently not published to the Online Store sales 
		/// channel. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
