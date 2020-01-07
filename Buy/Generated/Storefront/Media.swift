//
//  Media.swift
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

/// Represents a media interface. 
public protocol Media {
	var alt: String? { get }

	var mediaContentType: Storefront.MediaContentType { get }

	var previewImage: Storefront.Image? { get }
}

extension Storefront {
	/// Represents a media interface. 
	open class MediaQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Media

		/// A word or phrase to share the nature or contents of a media. 
		@discardableResult
		open func alt(alias: String? = nil) -> MediaQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// The media content type. 
		@discardableResult
		open func mediaContentType(alias: String? = nil) -> MediaQuery {
			addField(field: "mediaContentType", aliasSuffix: alias)
			return self
		}

		/// The preview image for the media. 
		@discardableResult
		open func previewImage(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> MediaQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "previewImage", aliasSuffix: alias, subfields: subquery)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// Represents a media interface. 
		@discardableResult
		open func onExternalVideo(subfields: (ExternalVideoQuery) -> Void) -> MediaQuery {
			let subquery = ExternalVideoQuery()
			subfields(subquery)
			addInlineFragment(on: "ExternalVideo", subfields: subquery)
			return self
		}

		/// Represents a media interface. 
		@discardableResult
		open func onMediaImage(subfields: (MediaImageQuery) -> Void) -> MediaQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)
			addInlineFragment(on: "MediaImage", subfields: subquery)
			return self
		}

		/// Represents a media interface. 
		@discardableResult
		open func onModel3d(subfields: (Model3dQuery) -> Void) -> MediaQuery {
			let subquery = Model3dQuery()
			subfields(subquery)
			addInlineFragment(on: "Model3d", subfields: subquery)
			return self
		}

		/// Represents a media interface. 
		@discardableResult
		open func onVideo(subfields: (VideoQuery) -> Void) -> MediaQuery {
			let subquery = VideoQuery()
			subfields(subquery)
			addInlineFragment(on: "Video", subfields: subquery)
			return self
		}
	}

	/// Represents a media interface. 
	open class UnknownMedia: GraphQL.AbstractResponse, GraphQLObject, Media {
		public typealias Query = MediaQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownMedia.self, field: fieldName, value: fieldValue)
				}
				return value

				case "mediaContentType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownMedia.self, field: fieldName, value: fieldValue)
				}
				return MediaContentType(rawValue: value) ?? .unknownValue

				case "previewImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: UnknownMedia.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				default:
				throw SchemaViolationError(type: UnknownMedia.self, field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> Media {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownMedia.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "ExternalVideo": return try ExternalVideo.init(fields: fields)

				case "MediaImage": return try MediaImage.init(fields: fields)

				case "Model3d": return try Model3d.init(fields: fields)

				case "Video": return try Video.init(fields: fields)

				default:
				return try UnknownMedia.init(fields: fields)
			}
		}

		/// A word or phrase to share the nature or contents of a media. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
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
