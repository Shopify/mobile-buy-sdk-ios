//
//  Image.swift
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
	/// Represents an image resource. 
	open class ImageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Image

		/// A word or phrase to share the nature or contents of an image. 
		@discardableResult
		open func altText(alias: String? = nil) -> ImageQuery {
			addField(field: "altText", aliasSuffix: alias)
			return self
		}

		/// A unique identifier for the image. 
		@discardableResult
		open func id(alias: String? = nil) -> ImageQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The location of the original image as a URL. If there are any existing 
		/// transformations in the original source URL, they will remain and not be 
		/// stripped. 
		@discardableResult
		open func originalSrc(alias: String? = nil) -> ImageQuery {
			addField(field: "originalSrc", aliasSuffix: alias)
			return self
		}

		/// The location of the image as a URL. 
		@available(*, deprecated, message:"Previously an image had a single `src` field. This could either return the original image\nlocation or a URL that contained transformations such as sizing or scale.\n\nThese transformations were specified by arguments on the parent field.\n\nNow an image has two distinct URL fields: `originalSrc` and `transformedSrc`.\n\n* `originalSrc` - the original unmodified image URL\n* `transformedSrc` - the image URL with the specified transformations included\n\nTo migrate to the new fields, image transformations should be moved from the parent field to `transformedSrc`.\n\nBefore:\n```graphql\n{\n  shop {\n    productImages(maxWidth: 200, scale: 2) {\n      edges {\n        node {\n          src\n        }\n      }\n    }\n  }\n}\n```\n\nAfter:\n```graphql\n{\n  shop {\n    productImages {\n      edges {\n        node {\n          transformedSrc(maxWidth: 200, scale: 2)\n        }\n      }\n    }\n  }\n}\n```\n")
		@discardableResult
		open func src(alias: String? = nil) -> ImageQuery {
			addField(field: "src", aliasSuffix: alias)
			return self
		}

		/// The location of the transformed image as a URL. All transformation 
		/// arguments are considered "best-effort". If they can be applied to an image, 
		/// they will be. Otherwise any transformations which an image type does not 
		/// support will be ignored. 
		///
		/// - parameters:
		///     - maxWidth: Image width in pixels between 1 and 5760.
		///     - maxHeight: Image height in pixels between 1 and 5760.
		///     - crop: Crops the image according to the specified region.
		///     - scale: Image size multiplier for high-resolution retina displays. Must be between 1 and 3.
		///     - preferredContentType: Best effort conversion of image into content type (SVG -> PNG, Anything -> JGP, Anything -> WEBP are supported).
		///
		@discardableResult
		open func transformedSrc(alias: String? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, crop: CropRegion? = nil, scale: Int32? = nil, preferredContentType: ImageContentType? = nil) -> ImageQuery {
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

			if let preferredContentType = preferredContentType {
				args.append("preferredContentType:\(preferredContentType.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "transformedSrc", aliasSuffix: alias, args: argsString)
			return self
		}
	}

	/// Represents an image resource. 
	open class Image: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ImageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "altText":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "originalSrc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "src":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "transformedSrc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: Image.self, field: fieldName, value: fieldValue)
			}
		}

		/// A word or phrase to share the nature or contents of an image. 
		open var altText: String? {
			return internalGetAltText()
		}

		func internalGetAltText(alias: String? = nil) -> String? {
			return field(field: "altText", aliasSuffix: alias) as! String?
		}

		/// A unique identifier for the image. 
		open var id: GraphQL.ID? {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID? {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID?
		}

		/// The location of the original image as a URL. If there are any existing 
		/// transformations in the original source URL, they will remain and not be 
		/// stripped. 
		open var originalSrc: URL {
			return internalGetOriginalSrc()
		}

		func internalGetOriginalSrc(alias: String? = nil) -> URL {
			return field(field: "originalSrc", aliasSuffix: alias) as! URL
		}

		/// The location of the image as a URL. 
		@available(*, deprecated, message:"Previously an image had a single `src` field. This could either return the original image\nlocation or a URL that contained transformations such as sizing or scale.\n\nThese transformations were specified by arguments on the parent field.\n\nNow an image has two distinct URL fields: `originalSrc` and `transformedSrc`.\n\n* `originalSrc` - the original unmodified image URL\n* `transformedSrc` - the image URL with the specified transformations included\n\nTo migrate to the new fields, image transformations should be moved from the parent field to `transformedSrc`.\n\nBefore:\n```graphql\n{\n  shop {\n    productImages(maxWidth: 200, scale: 2) {\n      edges {\n        node {\n          src\n        }\n      }\n    }\n  }\n}\n```\n\nAfter:\n```graphql\n{\n  shop {\n    productImages {\n      edges {\n        node {\n          transformedSrc(maxWidth: 200, scale: 2)\n        }\n      }\n    }\n  }\n}\n```\n")
		open var src: URL {
			return internalGetSrc()
		}

		func internalGetSrc(alias: String? = nil) -> URL {
			return field(field: "src", aliasSuffix: alias) as! URL
		}

		/// The location of the transformed image as a URL. All transformation 
		/// arguments are considered "best-effort". If they can be applied to an image, 
		/// they will be. Otherwise any transformations which an image type does not 
		/// support will be ignored. 
		open var transformedSrc: URL {
			return internalGetTransformedSrc()
		}

		open func aliasedTransformedSrc(alias: String) -> URL {
			return internalGetTransformedSrc(alias: alias)
		}

		func internalGetTransformedSrc(alias: String? = nil) -> URL {
			return field(field: "transformedSrc", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
