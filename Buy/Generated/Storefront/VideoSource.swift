//
//  VideoSource.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// Represents a source for a Shopify hosted video. 
	open class VideoSourceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = VideoSource

		/// The format of the video source. 
		@discardableResult
		open func format(alias: String? = nil) -> VideoSourceQuery {
			addField(field: "format", aliasSuffix: alias)
			return self
		}

		/// The height of the video. 
		@discardableResult
		open func height(alias: String? = nil) -> VideoSourceQuery {
			addField(field: "height", aliasSuffix: alias)
			return self
		}

		/// The video MIME type. 
		@discardableResult
		open func mimeType(alias: String? = nil) -> VideoSourceQuery {
			addField(field: "mimeType", aliasSuffix: alias)
			return self
		}

		/// The URL of the video. 
		@discardableResult
		open func url(alias: String? = nil) -> VideoSourceQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}

		/// The width of the video. 
		@discardableResult
		open func width(alias: String? = nil) -> VideoSourceQuery {
			addField(field: "width", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a source for a Shopify hosted video. 
	open class VideoSource: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = VideoSourceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "format":
				guard let value = value as? String else {
					throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "height":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "mimeType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "width":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				default:
				throw SchemaViolationError(type: VideoSource.self, field: fieldName, value: fieldValue)
			}
		}

		/// The format of the video source. 
		open var format: String {
			return internalGetFormat()
		}

		func internalGetFormat(alias: String? = nil) -> String {
			return field(field: "format", aliasSuffix: alias) as! String
		}

		/// The height of the video. 
		open var height: Int32 {
			return internalGetHeight()
		}

		func internalGetHeight(alias: String? = nil) -> Int32 {
			return field(field: "height", aliasSuffix: alias) as! Int32
		}

		/// The video MIME type. 
		open var mimeType: String {
			return internalGetMimeType()
		}

		func internalGetMimeType(alias: String? = nil) -> String {
			return field(field: "mimeType", aliasSuffix: alias) as! String
		}

		/// The URL of the video. 
		open var url: String {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> String {
			return field(field: "url", aliasSuffix: alias) as! String
		}

		/// The width of the video. 
		open var width: Int32 {
			return internalGetWidth()
		}

		func internalGetWidth(alias: String? = nil) -> Int32 {
			return field(field: "width", aliasSuffix: alias) as! Int32
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
