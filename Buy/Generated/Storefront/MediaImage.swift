//
//  MediaImage.swift
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
	/// Represents a Shopify hosted image. 
	open class MediaImageQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MediaImage

		/// A word or phrase to share the nature or contents of a media. 
		@discardableResult
		open func alt(alias: String? = nil) -> MediaImageQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> MediaImageQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The image for the media. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> MediaImageQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The media content type. 
		@discardableResult
		open func mediaContentType(alias: String? = nil) -> MediaImageQuery {
			addField(field: "mediaContentType", aliasSuffix: alias)
			return self
		}

		/// The preview image for the media. 
		@discardableResult
		open func previewImage(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> MediaImageQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "previewImage", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents a Shopify hosted image. 
	open class MediaImage: GraphQL.AbstractResponse, GraphQLObject, Media, Node {
		public typealias Query = MediaImageQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "mediaContentType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
				}
				return MediaContentType(rawValue: value) ?? .unknownValue

				case "previewImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				default:
				throw SchemaViolationError(type: MediaImage.self, field: fieldName, value: fieldValue)
			}
		}

		/// A word or phrase to share the nature or contents of a media. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The image for the media. 
		open var image: Storefront.Image? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.Image?
		}

		/// The media content type. 
		open var mediaContentType: Storefront.MediaContentType {
			return internalGetMediaContentType()
		}

		func internalGetMediaContentType(alias: String? = nil) -> Storefront.MediaContentType {
			return field(field: "mediaContentType", aliasSuffix: alias) as! Storefront.MediaContentType
		}

		/// The preview image for the media. 
		open var previewImage: Storefront.Image? {
			return internalGetPreviewImage()
		}

		func internalGetPreviewImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "previewImage", aliasSuffix: alias) as! Storefront.Image?
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

					case "previewImage":
					if let value = internalGetPreviewImage() {
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
