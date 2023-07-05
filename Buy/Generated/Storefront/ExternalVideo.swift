//
//  ExternalVideo.swift
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
	/// Represents a video hosted outside of Shopify. 
	open class ExternalVideoQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ExternalVideo

		/// A word or phrase to share the nature or contents of a media. 
		@discardableResult
		open func alt(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// The embed URL of the video for the respective host. 
		@discardableResult
		open func embedUrl(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "embedUrl", aliasSuffix: alias)
			return self
		}

		/// The URL. 
		@available(*, deprecated, message:"Use `originUrl` instead.")
		@discardableResult
		open func embeddedUrl(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "embeddedUrl", aliasSuffix: alias)
			return self
		}

		/// The host of the external video. 
		@discardableResult
		open func host(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "host", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The media content type. 
		@discardableResult
		open func mediaContentType(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "mediaContentType", aliasSuffix: alias)
			return self
		}

		/// The origin URL of the video on the respective host. 
		@discardableResult
		open func originUrl(alias: String? = nil) -> ExternalVideoQuery {
			addField(field: "originUrl", aliasSuffix: alias)
			return self
		}

		/// The presentation for a media. 
		@discardableResult
		open func presentation(alias: String? = nil, _ subfields: (MediaPresentationQuery) -> Void) -> ExternalVideoQuery {
			let subquery = MediaPresentationQuery()
			subfields(subquery)

			addField(field: "presentation", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The preview image for the media. 
		@discardableResult
		open func previewImage(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> ExternalVideoQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "previewImage", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents a video hosted outside of Shopify. 
	open class ExternalVideo: GraphQL.AbstractResponse, GraphQLObject, Media, Node {
		public typealias Query = ExternalVideoQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return value

				case "embedUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "embeddedUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "host":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return MediaHost(rawValue: value) ?? .unknownValue

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "mediaContentType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return MediaContentType(rawValue: value) ?? .unknownValue

				case "originUrl":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "presentation":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return try MediaPresentation(fields: value)

				case "previewImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				default:
				throw SchemaViolationError(type: ExternalVideo.self, field: fieldName, value: fieldValue)
			}
		}

		/// A word or phrase to share the nature or contents of a media. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
		}

		/// The embed URL of the video for the respective host. 
		open var embedUrl: URL {
			return internalGetEmbedUrl()
		}

		func internalGetEmbedUrl(alias: String? = nil) -> URL {
			return field(field: "embedUrl", aliasSuffix: alias) as! URL
		}

		/// The URL. 
		@available(*, deprecated, message:"Use `originUrl` instead.")
		open var embeddedUrl: URL {
			return internalGetEmbeddedUrl()
		}

		func internalGetEmbeddedUrl(alias: String? = nil) -> URL {
			return field(field: "embeddedUrl", aliasSuffix: alias) as! URL
		}

		/// The host of the external video. 
		open var host: Storefront.MediaHost {
			return internalGetHost()
		}

		func internalGetHost(alias: String? = nil) -> Storefront.MediaHost {
			return field(field: "host", aliasSuffix: alias) as! Storefront.MediaHost
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The media content type. 
		open var mediaContentType: Storefront.MediaContentType {
			return internalGetMediaContentType()
		}

		func internalGetMediaContentType(alias: String? = nil) -> Storefront.MediaContentType {
			return field(field: "mediaContentType", aliasSuffix: alias) as! Storefront.MediaContentType
		}

		/// The origin URL of the video on the respective host. 
		open var originUrl: URL {
			return internalGetOriginUrl()
		}

		func internalGetOriginUrl(alias: String? = nil) -> URL {
			return field(field: "originUrl", aliasSuffix: alias) as! URL
		}

		/// The presentation for a media. 
		open var presentation: Storefront.MediaPresentation? {
			return internalGetPresentation()
		}

		func internalGetPresentation(alias: String? = nil) -> Storefront.MediaPresentation? {
			return field(field: "presentation", aliasSuffix: alias) as! Storefront.MediaPresentation?
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
					case "presentation":
					if let value = internalGetPresentation() {
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
