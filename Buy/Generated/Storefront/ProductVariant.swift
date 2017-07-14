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

		@discardableResult
		open func id(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Image associated with the product variant. 
		///
		/// - parameters:
		///     - maxWidth: Image width in pixels between 1 and 2048
		///     - maxHeight: Image height in pixels between 1 and 2048
		///     - crop: If specified, crop the image keeping the specified region
		///     - scale: Image size multiplier retina displays. Must be between 1 and 3
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

		/// The product variant’s price. 
		@discardableResult
		open func price(alias: String? = nil) -> ProductVariantQuery {
			addField(field: "price", aliasSuffix: alias)
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
	open class ProductVariant: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ProductVariantQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "available":
				if value is NSNull { return nil }
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "availableForSale":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "price":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "product":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Product(fields: value)

				case "selectedOptions":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try SelectedOption(fields: $0) }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "weight":
				if value is NSNull { return nil }
				guard let value = value as? Double else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "weightUnit":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return WeightUnit(rawValue: value) ?? .unknownValue

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
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

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Image associated with the product variant. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		open func aliasedImage(alias: String) -> Storefront.Image? {
			return internalGetImage(alias: alias)
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// The product variant’s price. 
		open var price: Decimal {
			return internalGetPrice()
		}

		func internalGetPrice(alias: String? = nil) -> Decimal {
			return field(field: "price", aliasSuffix: alias) as! Decimal
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
					case "image":
					if let value = internalGetImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

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
