//
//  Model3dSource.swift
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
	/// Represents a source for a Shopify hosted 3d model. 
	open class Model3dSourceQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Model3dSource

		/// The filesize of the 3d model. 
		@discardableResult
		open func filesize(alias: String? = nil) -> Model3dSourceQuery {
			addField(field: "filesize", aliasSuffix: alias)
			return self
		}

		/// The format of the 3d model. 
		@discardableResult
		open func format(alias: String? = nil) -> Model3dSourceQuery {
			addField(field: "format", aliasSuffix: alias)
			return self
		}

		/// The MIME type of the 3d model. 
		@discardableResult
		open func mimeType(alias: String? = nil) -> Model3dSourceQuery {
			addField(field: "mimeType", aliasSuffix: alias)
			return self
		}

		/// The URL of the 3d model. 
		@discardableResult
		open func url(alias: String? = nil) -> Model3dSourceQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a source for a Shopify hosted 3d model. 
	open class Model3dSource: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = Model3dSourceQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "filesize":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Model3dSource.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "format":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Model3dSource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "mimeType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Model3dSource.self, field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Model3dSource.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Model3dSource.self, field: fieldName, value: fieldValue)
			}
		}

		/// The filesize of the 3d model. 
		open var filesize: Int32 {
			return internalGetFilesize()
		}

		func internalGetFilesize(alias: String? = nil) -> Int32 {
			return field(field: "filesize", aliasSuffix: alias) as! Int32
		}

		/// The format of the 3d model. 
		open var format: String {
			return internalGetFormat()
		}

		func internalGetFormat(alias: String? = nil) -> String {
			return field(field: "format", aliasSuffix: alias) as! String
		}

		/// The MIME type of the 3d model. 
		open var mimeType: String {
			return internalGetMimeType()
		}

		func internalGetMimeType(alias: String? = nil) -> String {
			return field(field: "mimeType", aliasSuffix: alias) as! String
		}

		/// The URL of the 3d model. 
		open var url: String {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> String {
			return field(field: "url", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
