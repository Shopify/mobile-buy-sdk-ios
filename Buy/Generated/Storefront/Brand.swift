//
//  Brand.swift
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
	/// The store's [branding 
	/// configuration](https://help.shopify.com/en/manual/promoting-marketing/managing-brand-assets). 
	open class BrandQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Brand

		/// The colors of the store's brand. 
		@discardableResult
		open func colors(alias: String? = nil, _ subfields: (BrandColorsQuery) -> Void) -> BrandQuery {
			let subquery = BrandColorsQuery()
			subfields(subquery)

			addField(field: "colors", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The store's cover image. 
		@discardableResult
		open func coverImage(alias: String? = nil, _ subfields: (MediaImageQuery) -> Void) -> BrandQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)

			addField(field: "coverImage", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The store's default logo. 
		@discardableResult
		open func logo(alias: String? = nil, _ subfields: (MediaImageQuery) -> Void) -> BrandQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)

			addField(field: "logo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The store's short description. 
		@discardableResult
		open func shortDescription(alias: String? = nil) -> BrandQuery {
			addField(field: "shortDescription", aliasSuffix: alias)
			return self
		}

		/// The store's slogan. 
		@discardableResult
		open func slogan(alias: String? = nil) -> BrandQuery {
			addField(field: "slogan", aliasSuffix: alias)
			return self
		}

		/// The store's preferred logo for square UI elements. 
		@discardableResult
		open func squareLogo(alias: String? = nil, _ subfields: (MediaImageQuery) -> Void) -> BrandQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)

			addField(field: "squareLogo", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The store's [branding 
	/// configuration](https://help.shopify.com/en/manual/promoting-marketing/managing-brand-assets). 
	open class Brand: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = BrandQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "colors":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return try BrandColors(fields: value)

				case "coverImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return try MediaImage(fields: value)

				case "logo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return try MediaImage(fields: value)

				case "shortDescription":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return value

				case "slogan":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return value

				case "squareLogo":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
				}
				return try MediaImage(fields: value)

				default:
				throw SchemaViolationError(type: Brand.self, field: fieldName, value: fieldValue)
			}
		}

		/// The colors of the store's brand. 
		open var colors: Storefront.BrandColors {
			return internalGetColors()
		}

		func internalGetColors(alias: String? = nil) -> Storefront.BrandColors {
			return field(field: "colors", aliasSuffix: alias) as! Storefront.BrandColors
		}

		/// The store's cover image. 
		open var coverImage: Storefront.MediaImage? {
			return internalGetCoverImage()
		}

		func internalGetCoverImage(alias: String? = nil) -> Storefront.MediaImage? {
			return field(field: "coverImage", aliasSuffix: alias) as! Storefront.MediaImage?
		}

		/// The store's default logo. 
		open var logo: Storefront.MediaImage? {
			return internalGetLogo()
		}

		func internalGetLogo(alias: String? = nil) -> Storefront.MediaImage? {
			return field(field: "logo", aliasSuffix: alias) as! Storefront.MediaImage?
		}

		/// The store's short description. 
		open var shortDescription: String? {
			return internalGetShortDescription()
		}

		func internalGetShortDescription(alias: String? = nil) -> String? {
			return field(field: "shortDescription", aliasSuffix: alias) as! String?
		}

		/// The store's slogan. 
		open var slogan: String? {
			return internalGetSlogan()
		}

		func internalGetSlogan(alias: String? = nil) -> String? {
			return field(field: "slogan", aliasSuffix: alias) as! String?
		}

		/// The store's preferred logo for square UI elements. 
		open var squareLogo: Storefront.MediaImage? {
			return internalGetSquareLogo()
		}

		func internalGetSquareLogo(alias: String? = nil) -> Storefront.MediaImage? {
			return field(field: "squareLogo", aliasSuffix: alias) as! Storefront.MediaImage?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "colors":
					response.append(internalGetColors())
					response.append(contentsOf: internalGetColors().childResponseObjectMap())

					case "coverImage":
					if let value = internalGetCoverImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "logo":
					if let value = internalGetLogo() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "squareLogo":
					if let value = internalGetSquareLogo() {
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
