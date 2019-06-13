//
//  Product.swift
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
	/// A product represents an individual item for sale in a Shopify store. 
	/// Products are often physical, but they don't have to be. For example, a 
	/// digital download (such as a movie, music or ebook file) also qualifies as a 
	/// product, as do services (such as equipment rental, work for hire, 
	/// customization of another product or an extended warranty). 
	open class ProductQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Product

		/// Indicates if at least one product variant is available for sale. 
		@discardableResult
		open func availableForSale(alias: String? = nil) -> ProductQuery {
			addField(field: "availableForSale", aliasSuffix: alias)
			return self
		}

		/// List of collections a product belongs to. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func collections(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> ProductQuery {
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

			let subquery = CollectionConnectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The date and time when the product was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> ProductQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// Stripped description of the product, single line with HTML tags removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates string after the given length.
		///
		@discardableResult
		open func description(alias: String? = nil, truncateAt: Int32? = nil) -> ProductQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "description", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The description of the product, complete with HTML formatting. 
		@discardableResult
		open func descriptionHtml(alias: String? = nil) -> ProductQuery {
			addField(field: "descriptionHtml", aliasSuffix: alias)
			return self
		}

		/// A human-friendly unique string for the Product automatically generated from 
		/// its title. They are used by the Liquid templating language to refer to 
		/// objects. 
		@discardableResult
		open func handle(alias: String? = nil) -> ProductQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> ProductQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// List of images associated with the product. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///     - maxWidth: Image width in pixels between 1 and 2048. This argument is deprecated: Use `maxWidth` on `Image.transformedSrc` instead.
		///     - maxHeight: Image height in pixels between 1 and 2048. This argument is deprecated: Use `maxHeight` on `Image.transformedSrc` instead.
		///     - crop: Crops the image according to the specified region. This argument is deprecated: Use `crop` on `Image.transformedSrc` instead.
		///     - scale: Image size multiplier for high-resolution retina displays. Must be between 1 and 3. This argument is deprecated: Use `scale` on `Image.transformedSrc` instead.
		///
		@discardableResult
		open func images(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductImageSortKeys? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageConnectionQuery) -> Void) -> ProductQuery {
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

			let subquery = ImageConnectionQuery()
			subfields(subquery)

			addField(field: "images", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafield associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - key: Identifier for the metafield (maximum of 30 characters).
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String, key: String, _ subfields: (MetafieldQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("namespace:\(GraphQL.quoteString(input: namespace))")

			args.append("key:\(GraphQL.quoteString(input: key))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A paginated list of metafields associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func metafields(alias: String? = nil, namespace: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (MetafieldConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

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

			let subquery = MetafieldConnectionQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The online store URL for the product. A value of `null` indicates that the 
		/// product is not published to the Online Store sales channel. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> ProductQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// List of custom product options (maximum of 3 per product). 
		///
		/// - parameters:
		///     - first: Truncate the array result to this size.
		///
		@discardableResult
		open func options(alias: String? = nil, first: Int32? = nil, _ subfields: (ProductOptionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductOptionQuery()
			subfields(subquery)

			addField(field: "options", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of price ranges in the presentment currencies for this shop. 
		///
		/// - parameters:
		///     - presentmentCurrencies: Specifies the presentment currencies to return a price range in.
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func presentmentPriceRanges(alias: String? = nil, presentmentCurrencies: [CurrencyCode]? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (ProductPriceRangeConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let presentmentCurrencies = presentmentCurrencies {
				args.append("presentmentCurrencies:[\(presentmentCurrencies.map{ "\($0.rawValue)" }.joined(separator: ","))]")
			}

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

			let subquery = ProductPriceRangeConnectionQuery()
			subfields(subquery)

			addField(field: "presentmentPriceRanges", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The price range. 
		@discardableResult
		open func priceRange(alias: String? = nil, _ subfields: (ProductPriceRangeQuery) -> Void) -> ProductQuery {
			let subquery = ProductPriceRangeQuery()
			subfields(subquery)

			addField(field: "priceRange", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A categorization that a product can be tagged with, commonly used for 
		/// filtering and searching. 
		@discardableResult
		open func productType(alias: String? = nil) -> ProductQuery {
			addField(field: "productType", aliasSuffix: alias)
			return self
		}

		/// The date and time when the product was published to the channel. 
		@discardableResult
		open func publishedAt(alias: String? = nil) -> ProductQuery {
			addField(field: "publishedAt", aliasSuffix: alias)
			return self
		}

		/// A categorization that a product can be tagged with, commonly used for 
		/// filtering and searching. Additional access scope required for private apps: 
		/// unauthenticated_read_product_tags. 
		@discardableResult
		open func tags(alias: String? = nil) -> ProductQuery {
			addField(field: "tags", aliasSuffix: alias)
			return self
		}

		/// The product’s title. 
		@discardableResult
		open func title(alias: String? = nil) -> ProductQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The date and time when the product was last modified. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> ProductQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// Find a product’s variant based on its selected options. This is useful for 
		/// converting a user’s selection of product options into a single matching 
		/// variant. If there is not a variant for the selected options, `null` will be 
		/// returned. 
		///
		/// - parameters:
		///     - selectedOptions: No description
		///
		@discardableResult
		open func variantBySelectedOptions(alias: String? = nil, selectedOptions: [SelectedOptionInput], _ subfields: (ProductVariantQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("selectedOptions:[\(selectedOptions.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variantBySelectedOptions", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// List of the product’s variants. 
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
		open func variants(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductVariantSortKeys? = nil, _ subfields: (ProductVariantConnectionQuery) -> Void) -> ProductQuery {
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

			let subquery = ProductVariantConnectionQuery()
			subfields(subquery)

			addField(field: "variants", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The product’s vendor name. 
		@discardableResult
		open func vendor(alias: String? = nil) -> ProductQuery {
			addField(field: "vendor", aliasSuffix: alias)
			return self
		}
	}

	/// A product represents an individual item for sale in a Shopify store. 
	/// Products are often physical, but they don't have to be. For example, a 
	/// digital download (such as a movie, music or ebook file) also qualifies as a 
	/// product, as do services (such as equipment rental, work for hire, 
	/// customization of another product or an extended warranty). 
	open class Product: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
		public typealias Query = ProductQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "availableForSale":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "description":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "descriptionHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "images":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ImageConnection(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldConnection(fields: value)

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "options":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ProductOption(fields: $0) }

				case "presentmentPriceRanges":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductPriceRangeConnection(fields: value)

				case "priceRange":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductPriceRange(fields: value)

				case "productType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "publishedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "variantBySelectedOptions":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				case "variants":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariantConnection(fields: value)

				case "vendor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
			}
		}

		/// Indicates if at least one product variant is available for sale. 
		open var availableForSale: Bool {
			return internalGetAvailableForSale()
		}

		func internalGetAvailableForSale(alias: String? = nil) -> Bool {
			return field(field: "availableForSale", aliasSuffix: alias) as! Bool
		}

		/// List of collections a product belongs to. 
		open var collections: Storefront.CollectionConnection {
			return internalGetCollections()
		}

		open func aliasedCollections(alias: String) -> Storefront.CollectionConnection {
			return internalGetCollections(alias: alias)
		}

		func internalGetCollections(alias: String? = nil) -> Storefront.CollectionConnection {
			return field(field: "collections", aliasSuffix: alias) as! Storefront.CollectionConnection
		}

		/// The date and time when the product was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// Stripped description of the product, single line with HTML tags removed. 
		open var description: String {
			return internalGetDescription()
		}

		open func aliasedDescription(alias: String) -> String {
			return internalGetDescription(alias: alias)
		}

		func internalGetDescription(alias: String? = nil) -> String {
			return field(field: "description", aliasSuffix: alias) as! String
		}

		/// The description of the product, complete with HTML formatting. 
		open var descriptionHtml: String {
			return internalGetDescriptionHtml()
		}

		func internalGetDescriptionHtml(alias: String? = nil) -> String {
			return field(field: "descriptionHtml", aliasSuffix: alias) as! String
		}

		/// A human-friendly unique string for the Product automatically generated from 
		/// its title. They are used by the Liquid templating language to refer to 
		/// objects. 
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

		/// List of images associated with the product. 
		open var images: Storefront.ImageConnection {
			return internalGetImages()
		}

		open func aliasedImages(alias: String) -> Storefront.ImageConnection {
			return internalGetImages(alias: alias)
		}

		func internalGetImages(alias: String? = nil) -> Storefront.ImageConnection {
			return field(field: "images", aliasSuffix: alias) as! Storefront.ImageConnection
		}

		/// The metafield associated with the resource. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// A paginated list of metafields associated with the resource. 
		open var metafields: Storefront.MetafieldConnection {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> Storefront.MetafieldConnection {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> Storefront.MetafieldConnection {
			return field(field: "metafields", aliasSuffix: alias) as! Storefront.MetafieldConnection
		}

		/// The online store URL for the product. A value of `null` indicates that the 
		/// product is not published to the Online Store sales channel. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		/// List of custom product options (maximum of 3 per product). 
		open var options: [Storefront.ProductOption] {
			return internalGetOptions()
		}

		open func aliasedOptions(alias: String) -> [Storefront.ProductOption] {
			return internalGetOptions(alias: alias)
		}

		func internalGetOptions(alias: String? = nil) -> [Storefront.ProductOption] {
			return field(field: "options", aliasSuffix: alias) as! [Storefront.ProductOption]
		}

		/// List of price ranges in the presentment currencies for this shop. 
		open var presentmentPriceRanges: Storefront.ProductPriceRangeConnection {
			return internalGetPresentmentPriceRanges()
		}

		open func aliasedPresentmentPriceRanges(alias: String) -> Storefront.ProductPriceRangeConnection {
			return internalGetPresentmentPriceRanges(alias: alias)
		}

		func internalGetPresentmentPriceRanges(alias: String? = nil) -> Storefront.ProductPriceRangeConnection {
			return field(field: "presentmentPriceRanges", aliasSuffix: alias) as! Storefront.ProductPriceRangeConnection
		}

		/// The price range. 
		open var priceRange: Storefront.ProductPriceRange {
			return internalGetPriceRange()
		}

		func internalGetPriceRange(alias: String? = nil) -> Storefront.ProductPriceRange {
			return field(field: "priceRange", aliasSuffix: alias) as! Storefront.ProductPriceRange
		}

		/// A categorization that a product can be tagged with, commonly used for 
		/// filtering and searching. 
		open var productType: String {
			return internalGetProductType()
		}

		func internalGetProductType(alias: String? = nil) -> String {
			return field(field: "productType", aliasSuffix: alias) as! String
		}

		/// The date and time when the product was published to the channel. 
		open var publishedAt: Date {
			return internalGetPublishedAt()
		}

		func internalGetPublishedAt(alias: String? = nil) -> Date {
			return field(field: "publishedAt", aliasSuffix: alias) as! Date
		}

		/// A categorization that a product can be tagged with, commonly used for 
		/// filtering and searching. Additional access scope required for private apps: 
		/// unauthenticated_read_product_tags. 
		open var tags: [String] {
			return internalGetTags()
		}

		func internalGetTags(alias: String? = nil) -> [String] {
			return field(field: "tags", aliasSuffix: alias) as! [String]
		}

		/// The product’s title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The date and time when the product was last modified. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// Find a product’s variant based on its selected options. This is useful for 
		/// converting a user’s selection of product options into a single matching 
		/// variant. If there is not a variant for the selected options, `null` will be 
		/// returned. 
		open var variantBySelectedOptions: Storefront.ProductVariant? {
			return internalGetVariantBySelectedOptions()
		}

		open func aliasedVariantBySelectedOptions(alias: String) -> Storefront.ProductVariant? {
			return internalGetVariantBySelectedOptions(alias: alias)
		}

		func internalGetVariantBySelectedOptions(alias: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "variantBySelectedOptions", aliasSuffix: alias) as! Storefront.ProductVariant?
		}

		/// List of the product’s variants. 
		open var variants: Storefront.ProductVariantConnection {
			return internalGetVariants()
		}

		open func aliasedVariants(alias: String) -> Storefront.ProductVariantConnection {
			return internalGetVariants(alias: alias)
		}

		func internalGetVariants(alias: String? = nil) -> Storefront.ProductVariantConnection {
			return field(field: "variants", aliasSuffix: alias) as! Storefront.ProductVariantConnection
		}

		/// The product’s vendor name. 
		open var vendor: String {
			return internalGetVendor()
		}

		func internalGetVendor(alias: String? = nil) -> String {
			return field(field: "vendor", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "images":
					response.append(internalGetImages())
					response.append(contentsOf: internalGetImages().childResponseObjectMap())

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					response.append(internalGetMetafields())
					response.append(contentsOf: internalGetMetafields().childResponseObjectMap())

					case "options":
					internalGetOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "presentmentPriceRanges":
					response.append(internalGetPresentmentPriceRanges())
					response.append(contentsOf: internalGetPresentmentPriceRanges().childResponseObjectMap())

					case "priceRange":
					response.append(internalGetPriceRange())
					response.append(contentsOf: internalGetPriceRange().childResponseObjectMap())

					case "variantBySelectedOptions":
					if let value = internalGetVariantBySelectedOptions() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "variants":
					response.append(internalGetVariants())
					response.append(contentsOf: internalGetVariants().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
