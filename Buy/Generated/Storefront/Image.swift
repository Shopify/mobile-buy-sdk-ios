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

		/// The location of the image as a URL. 
		@discardableResult
		open func src(alias: String? = nil) -> ImageQuery {
			addField(field: "src", aliasSuffix: alias)
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
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "src":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
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

		/// The location of the image as a URL. 
		open var src: URL {
			return internalGetSrc()
		}

		func internalGetSrc(alias: String? = nil) -> URL {
			return field(field: "src", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
