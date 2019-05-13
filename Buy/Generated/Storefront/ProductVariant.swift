//
//  ProductVariant.swift
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
	/// A product variant represents a different version of a product, such as 
	/// differing sizes or differing colors. 
	open class ProductVariantQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ProductVariant

		/// Indicates if the product variant is in stock. 
		@available(*, deprecated, message:"Use `availableForSale` instead")
		@discardableResult
		open func available(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "available", aliasSuffix: alias)
			return self
		}

		/// Indicates if the product variant is available for sale. 
		@discardableResult
		open func availableForSale(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "availableForSale", aliasSuffix: alias)
			return self
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPrice` is higher than `price`. 
		@available(*, deprecated, message:"Use `compareAtPriceV2` instead")
		@discardableResult
		open func compareAtPrice(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "compareAtPrice", aliasSuffix: alias)
			return self
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPriceV2` is higher than `priceV2`. 
		@discardableResult
		open func compareAtPriceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "compareAtPriceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Image associated with the product variant. This field falls back to the 
		/// product image if no image is available. 
		///
		/// - parameters:
		///     - maxWidth: Image width in pixels between 1 and 2048. This argument is deprecated: Use `maxWidth` on `Image.transformedSrc` instead.
		///     - maxHeight: Image height in pixels between 1 and 2048. This argument is deprecated: Use `maxHeight` on `Image.transformedSrc` instead.
		///     - crop: Crops the image according to the specified region. This argument is deprecated: Use `crop` on `Image.transformedSrc` instead.
		///     - scale: Image size multiplier for high-resolution retina displays. Must be between 1 and 3. This argument is deprecated: Use `scale` on `Image.transformedSrc` instead.
		///
		@discardableResult
		open func image(alias: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, _ subfields: (ImageQuery) -> Void) -> ProductVariantQuery {
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

		/// The metafield associated with the resource. 
		///
		/// - parameters:
		///     - namespace: Container for a set of metafields (maximum of 20 characters).
		///     - key: Identifier for the metafield (maximum of 30 characters).
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String, key: String, _ subfields: (MetafieldQuery) -> Void) -> ProductVariantQuery {
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
		open func metafields(alias: String? = nil, namespace: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (MetafieldConnectionQuery) -> Void) -> ProductVariantQuery {
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

		/// List of prices and compare-at prices in the presentment currencies for this 
		/// shop. 
		///
		/// - parameters:
		///     - presentmentCurrencies: The presentment currencies prices should return in.
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func presentmentPrices(alias: String? = nil, presentmentCurrencies: [CurrencyCode]? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (ProductVariantPricePairConnectionQuery) -> Void) -> ProductVariantQuery {
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

			let subquery = ProductVariantPricePairConnectionQuery()
			subfields(subquery)

			addField(field: "presentmentPrices", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The product variant’s price. 
		@available(*, deprecated, message:"Use `priceV2` instead")
		@discardableResult
		open func price(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "price", aliasSuffix: alias)
			return self
		}

		/// The product variant’s price. 
		@discardableResult
		open func priceV2(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ProductVariantQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "priceV2", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The product object that the product variant belongs to. 
		@discardableResult
		open func product(alias: String? = nil, _ subfields: (ProductQuery) -> Void) -> ProductVariantQuery {
			let subquery = ProductQuery()
			subfields(subquery)

			addField(field: "product", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// List of product options applied to the variant. 
		@discardableResult
		open func selectedOptions(alias: String? = nil, _ subfields: (SelectedOptionQuery) -> Void) -> ProductVariantQuery {
			let subquery = SelectedOptionQuery()
			subfields(subquery)

			addField(field: "selectedOptions", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The SKU (stock keeping unit) associated with the variant. 
		@discardableResult
		open func sku(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "sku", aliasSuffix: alias)
			return self
		}

		/// The product variant’s title. 
		@discardableResult
		open func title(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The weight of the product variant in the unit system specified with 
		/// `weight_unit`. 
		@discardableResult
		open func weight(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "weight", aliasSuffix: alias)
			return self
		}

		/// Unit of measurement for weight. 
		@discardableResult
		open func weightUnit(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "weightUnit", aliasSuffix: alias)
			return self
		}
	}

	/// A product variant represents a different version of a product, such as 
	/// differing sizes or differing colors. 
	open class ProductVariant: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
		public typealias Query = ProductVariantQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "available":
				if value is NSNull { return nil }
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "availableForSale":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "compareAtPrice":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "compareAtPriceV2":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MetafieldConnection(fields: value)

				case "presentmentPrices":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariantPricePairConnection(fields: value)

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "priceV2":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "product":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "selectedOptions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try SelectedOption(fields: $0) }

				case "sku":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "weight":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return value

				case "weightUnit":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
				}
				return WeightUnit(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: ProductVariant.self, field: fieldName, value: fieldValue)
			}
		}

		/// Indicates if the product variant is in stock. 
		@available(*, deprecated, message:"Use `availableForSale` instead")
		open var available: Bool? {
			return internalGetAvailable()
		}

		func internalGetAvailable(alias: String? = nil) -> Bool? {
			return field(field: "available", aliasSuffix: alias) as! Bool?
		}

		/// Indicates if the product variant is available for sale. 
		open var availableForSale: Bool {
			return internalGetAvailableForSale()
		}

		func internalGetAvailableForSale(alias: String? = nil) -> Bool {
			return field(field: "availableForSale", aliasSuffix: alias) as! Bool
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPrice` is higher than `price`. 
		@available(*, deprecated, message:"Use `compareAtPriceV2` instead")
		open var compareAtPrice: Decimal? {
			return internalGetCompareAtPrice()
		}

		func internalGetCompareAtPrice(alias: String? = nil) -> Decimal? {
			return field(field: "compareAtPrice", aliasSuffix: alias) as! Decimal?
		}

		/// The compare at price of the variant. This can be used to mark a variant as 
		/// on sale, when `compareAtPriceV2` is higher than `priceV2`. 
		open var compareAtPriceV2: Storefront.MoneyV2? {
			return internalGetCompareAtPriceV2()
		}

		func internalGetCompareAtPriceV2(alias: String? = nil) -> Storefront.MoneyV2? {
			return field(field: "compareAtPriceV2", aliasSuffix: alias) as! Storefront.MoneyV2?
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Image associated with the product variant. This field falls back to the 
		/// product image if no image is available. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		open func aliasedImage(alias: String) -> Storefront.Image? {
			return internalGetImage(alias: alias)
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
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

		/// List of prices and compare-at prices in the presentment currencies for this 
		/// shop. 
		open var presentmentPrices: Storefront.ProductVariantPricePairConnection {
			return internalGetPresentmentPrices()
		}

		open func aliasedPresentmentPrices(alias: String) -> Storefront.ProductVariantPricePairConnection {
			return internalGetPresentmentPrices(alias: alias)
		}

		func internalGetPresentmentPrices(alias: String? = nil) -> Storefront.ProductVariantPricePairConnection {
			return field(field: "presentmentPrices", aliasSuffix: alias) as! Storefront.ProductVariantPricePairConnection
		}

		/// The product variant’s price. 
		@available(*, deprecated, message:"Use `priceV2` instead")
		open var price: Decimal {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Decimal {
			return field(field: "price", aliasSuffix: alias) as! Decimal
		}

		/// The product variant’s price. 
		open var priceV2: Storefront.MoneyV2 {
			return internalGetPriceV2()
		}

		func internalGetPriceV2(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "priceV2", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The product object that the product variant belongs to. 
		open var product: Storefront.Product {
			return internalGetProduct()
		}

		func internalGetProduct(alias: String? = nil) -> Storefront.Product {
			return field(field: "product", aliasSuffix: alias) as! Storefront.Product
		}

		/// List of product options applied to the variant. 
		open var selectedOptions: [Storefront.SelectedOption] {
			return internalGetSelectedOptions()
		}

		func internalGetSelectedOptions(alias: String? = nil) -> [Storefront.SelectedOption] {
			return field(field: "selectedOptions", aliasSuffix: alias) as! [Storefront.SelectedOption]
		}

		/// The SKU (stock keeping unit) associated with the variant. 
		open var sku: String? {
			return internalGetSku()
		}

		func internalGetSku(alias: String? = nil) -> String? {
			return field(field: "sku", aliasSuffix: alias) as! String?
		}

		/// The product variant’s title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The weight of the product variant in the unit system specified with 
		/// `weight_unit`. 
		open var weight: Double? {
			return internalGetWeight()
		}

		func internalGetWeight(alias: String? = nil) -> Double? {
			return field(field: "weight", aliasSuffix: alias) as! Double?
		}

		/// Unit of measurement for weight. 
		open var weightUnit: Storefront.WeightUnit {
			return internalGetWeightUnit()
		}

		func internalGetWeightUnit(alias: String? = nil) -> Storefront.WeightUnit {
			return field(field: "weightUnit", aliasSuffix: alias) as! Storefront.WeightUnit
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "compareAtPriceV2":
					if let value = internalGetCompareAtPriceV2() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					response.append(internalGetMetafields())
					response.append(contentsOf: internalGetMetafields().childResponseObjectMap())

					case "presentmentPrices":
					response.append(internalGetPresentmentPrices())
					response.append(contentsOf: internalGetPresentmentPrices().childResponseObjectMap())

					case "priceV2":
					response.append(internalGetPriceV2())
					response.append(contentsOf: internalGetPriceV2().childResponseObjectMap())

					case "product":
					response.append(internalGetProduct())
					response.append(contentsOf: internalGetProduct().childResponseObjectMap())

					case "selectedOptions":
					internalGetSelectedOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
