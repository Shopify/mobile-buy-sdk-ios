//
//  Collection.swift
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
	/// A collection represents a grouping of products that a shop owner can create 
	/// to organize them or make their shops easier to browse. 
	open class CollectionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Collection

		/// Stripped description of the collection, single line with HTML tags removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates string after the given length.
		///
		@discardableResult
		open func description(alias: String? = nil, truncateAt: Int32? = nil) -> CollectionQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "description", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The description of the collection, complete with HTML formatting. 
		@discardableResult
		open func descriptionHtml(alias: String? = nil) -> CollectionQuery {
			addField(field: "descriptionHtml", aliasSuffix: alias)
			return self
		}

		/// A human-friendly unique string for the collection automatically generated 
		/// from its title. Limit of 255 characters. 
		@discardableResult
		open func handle(alias: String? = nil) -> CollectionQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> CollectionQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Image associated with the collection. 
		///
		/// - parameters:
		///     - maxWidth: Image width in pixels between 1 and 2048. This argument is deprecated: Use `maxWidth` on `Image.transformedSrc` instead.
		///     - maxHeight: Image height in pixels between 1 and 2048. This argument is deprecated: Use `maxHeight` on `Image.transformedSrc` instead.
		///     - crop: Crops the image according to the specified region. This argument is deprecated: Use `crop` on `Image.transformedSrc` instead.
		///     - scale: Image size multiplier for high-resolution retina displays. Must be between 1 and 3. This argument is deprecated: Use `scale` on `Image.transformedSrc` instead.
		///
		@discardableResult
		open func image(alias: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> CollectionQuery {
			var args: [String] = []

			if let maxWidth = maxWidth {
				args.append("maxWidth:\(maxWidth)")
			}

			if let maxHeight = maxHeight {
				args.append("maxHeight:\(maxHeight)")
			}

			if let crop = crop {
				args.append("crop:\(crop.rawValue)")
			}

			if let scale = scale {
				args.append("scale:\(scale)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of products in the collection. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///
		@discardableResult
		open func products(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductCollectionSortKeys? = nil, _ subfields: (ProductConnectionQuery) -> Void) -> CollectionQuery {
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

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductConnectionQuery()
			subfields(subquery)

			addField(field: "products", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The collection’s name. Limit of 255 characters. 
		@discardableResult
		open func title(alias: String? = nil) -> CollectionQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The date and time when the collection was last modified. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> CollectionQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// A collection represents a grouping of products that a shop owner can create 
	/// to organize them or make their shops easier to browse. 
	open class Collection: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CollectionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "description":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return value

				case "descriptionHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "products":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return try ProductConnection(fields: value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: Collection.self, field: fieldName, value: fieldValue)
			}
		}

		/// Stripped description of the collection, single line with HTML tags removed. 
		open var description: String {
			return internalGetDescription()
		}

		open func aliasedDescription(alias: String) -> String {
			return internalGetDescription(alias: alias)
		}

		func internalGetDescription(alias: String? = nil) -> String {
			return field(field: "description", aliasSuffix: alias) as! String
		}

		/// The description of the collection, complete with HTML formatting. 
		open var descriptionHtml: String {
			return internalGetDescriptionHtml()
		}

		func internalGetDescriptionHtml(alias: String? = nil) -> String {
			return field(field: "descriptionHtml", aliasSuffix: alias) as! String
		}

		/// A human-friendly unique string for the collection automatically generated 
		/// from its title. Limit of 255 characters. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Image associated with the collection. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		open func aliasedImage(alias: String) -> Storefront.Image? {
			return internalGetImage(alias: alias)
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// List of products in the collection. 
		open var products: Storefront.ProductConnection {
			return internalGetProducts()
		}

		open func aliasedProducts(alias: String) -> Storefront.ProductConnection {
			return internalGetProducts(alias: alias)
		}

		func internalGetProducts(alias: String? = nil) -> Storefront.ProductConnection {
			return field(field: "products", aliasSuffix: alias) as! Storefront.ProductConnection
		}

		/// The collection’s name. Limit of 255 characters. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The date and time when the collection was last modified. 
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
					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "products":
					response.append(internalGetProducts())
					response.append(contentsOf: internalGetProducts().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
