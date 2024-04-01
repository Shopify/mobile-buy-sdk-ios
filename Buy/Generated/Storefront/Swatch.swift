//
//  Swatch.swift
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
	/// Color and image for visual representation. 
	open class SwatchQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Swatch

		/// The swatch color. 
		@discardableResult
		open func color(alias: String? = nil) -> SwatchQuery {
			addField(field: "color", aliasSuffix: alias)
			return self
		}

		/// The swatch image. 
		@discardableResult
		open func image(alias: String? = nil, _ subfields: (MediaImageQuery) -> Void) -> SwatchQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)

			addField(field: "image", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Color and image for visual representation. 
	open class Swatch: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = SwatchQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "color":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Swatch.self, field: fieldName, value: fieldValue)
				}
				return value

				case "image":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Swatch.self, field: fieldName, value: fieldValue)
				}
				return try MediaImage(fields: value)

				default:
				throw SchemaViolationError(type: Swatch.self, field: fieldName, value: fieldValue)
			}
		}

		/// The swatch color. 
		open var color: String? {
			return internalGetColor()
		}

		func internalGetColor(alias: String? = nil) -> String? {
			return field(field: "color", aliasSuffix: alias) as! String?
		}

		/// The swatch image. 
		open var image: Storefront.MediaImage? {
			return internalGetImage()
		}

		func internalGetImage(alias: String? = nil) -> Storefront.MediaImage? {
			return field(field: "image", aliasSuffix: alias) as! Storefront.MediaImage?
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

					default:
					break
				}
			}
			return response
		}
	}
}
