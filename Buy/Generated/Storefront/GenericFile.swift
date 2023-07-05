//
//  GenericFile.swift
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
	/// The generic file resource lets you manage files in a merchant’s store. 
	/// Generic files include any file that doesn’t fit into a designated type such 
	/// as image or video. Example: PDF, JSON. 
	open class GenericFileQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = GenericFile

		/// A word or phrase to indicate the contents of a file. 
		@discardableResult
		open func alt(alias: String? = nil) -> GenericFileQuery {
			addField(field: "alt", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> GenericFileQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The MIME type of the file. 
		@discardableResult
		open func mimeType(alias: String? = nil) -> GenericFileQuery {
			addField(field: "mimeType", aliasSuffix: alias)
			return self
		}

		/// The size of the original file in bytes. 
		@discardableResult
		open func originalFileSize(alias: String? = nil) -> GenericFileQuery {
			addField(field: "originalFileSize", aliasSuffix: alias)
			return self
		}

		/// The preview image for the file. 
		@discardableResult
		open func previewImage(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> GenericFileQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "previewImage", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The URL of the file. 
		@discardableResult
		open func url(alias: String? = nil) -> GenericFileQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// The generic file resource lets you manage files in a merchant’s store. 
	/// Generic files include any file that doesn’t fit into a designated type such 
	/// as image or video. Example: PDF, JSON. 
	open class GenericFile: GraphQL.AbstractResponse, GraphQLObject, MetafieldReference, Node {
		public typealias Query = GenericFileQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "alt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "mimeType":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return value

				case "originalFileSize":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "previewImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "url":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: GenericFile.self, field: fieldName, value: fieldValue)
			}
		}

		/// A word or phrase to indicate the contents of a file. 
		open var alt: String? {
			return internalGetAlt()
		}

		func internalGetAlt(alias: String? = nil) -> String? {
			return field(field: "alt", aliasSuffix: alias) as! String?
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The MIME type of the file. 
		open var mimeType: String? {
			return internalGetMimeType()
		}

		func internalGetMimeType(alias: String? = nil) -> String? {
			return field(field: "mimeType", aliasSuffix: alias) as! String?
		}

		/// The size of the original file in bytes. 
		open var originalFileSize: Int32? {
			return internalGetOriginalFileSize()
		}

		func internalGetOriginalFileSize(alias: String? = nil) -> Int32? {
			return field(field: "originalFileSize", aliasSuffix: alias) as! Int32?
		}

		/// The preview image for the file. 
		open var previewImage: Storefront.Image? {
			return internalGetPreviewImage()
		}

		func internalGetPreviewImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "previewImage", aliasSuffix: alias) as! Storefront.Image?
		}

		/// The URL of the file. 
		open var url: URL? {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL? {
			return field(field: "url", aliasSuffix: alias) as! URL?
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
