//
//  MetafieldReference.swift
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

/// Returns the resource which is being referred to by a metafield. 
public protocol MetafieldReference {
}

extension Storefront {
	/// Returns the resource which is being referred to by a metafield. 
	open class MetafieldReferenceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MetafieldReference

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onGenericFile(subfields: (GenericFileQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = GenericFileQuery()
			subfields(subquery)
			addInlineFragment(on: "GenericFile", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onMediaImage(subfields: (MediaImageQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)
			addInlineFragment(on: "MediaImage", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onMetaobject(subfields: (MetaobjectQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = MetaobjectQuery()
			subfields(subquery)
			addInlineFragment(on: "Metaobject", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		/// Returns the resource which is being referred to by a metafield. 
		@discardableResult
		open func onVideo(subfields: (VideoQuery) -> Void) -> MetafieldReferenceQuery {
			let subquery = VideoQuery()
			subfields(subquery)
			addInlineFragment(on: "Video", subfields: subquery)
			return self
		}
	}

	/// Returns the resource which is being referred to by a metafield. 
	open class UnknownMetafieldReference: GraphQL.AbstractResponse, GraphQLObject, MetafieldReference {
		public typealias Query = MetafieldReferenceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				default:
				throw SchemaViolationError(type: UnknownMetafieldReference.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> MetafieldReference {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownMetafieldReference.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "Collection": return try Collection.init(fields: fields)

				case "GenericFile": return try GenericFile.init(fields: fields)

				case "MediaImage": return try MediaImage.init(fields: fields)

				case "Metaobject": return try Metaobject.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				case "Video": return try Video.init(fields: fields)

				default:
				return try UnknownMetafieldReference.init(fields: fields)
			}
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
