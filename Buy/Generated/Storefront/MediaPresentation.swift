//
//  MediaPresentation.swift
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
	/// A media presentation. 
	open class MediaPresentationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MediaPresentation

		/// A JSON object representing a presentation view. 
		///
		/// - parameters:
		///     - format: The format to transform the settings.
		///
		@discardableResult
		open func asJson(alias: String? = nil, format: MediaPresentationFormat) -> MediaPresentationQuery {
			var args: [String] = []

			args.append("format:\(format.rawValue)")

			let argsString = "(\(args.joined(separator: ",")))"

			addField(field: "asJson", aliasSuffix: alias, args: argsString)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> MediaPresentationQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}
	}

	/// A media presentation. 
	open class MediaPresentation: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = MediaPresentationQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "asJson":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaPresentation.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MediaPresentation.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: MediaPresentation.self, field: fieldName, value: fieldValue)
			}
		}

		/// A JSON object representing a presentation view. 
		open var asJson: String? {
			return internalGetAsJson()
		}

		open func aliasedAsJson(alias: String) -> String? {
			return internalGetAsJson(alias: alias)
		}

		func internalGetAsJson(alias: String? = nil) -> String? {
			return field(field: "asJson", aliasSuffix: alias) as! String?
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
