//
//  ApiVersion.swift
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
	/// A version of the API. 
	open class ApiVersionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ApiVersion

		/// The human-readable name of the version. 
		@discardableResult
		open func displayName(alias: String? = nil) -> ApiVersionQuery {
			addField(field: "displayName", aliasSuffix: alias)
			return self
		}

		/// The unique identifier of an ApiVersion. All supported API versions have a 
		/// date-based (YYYY-MM) or `unstable` handle. 
		@discardableResult
		open func handle(alias: String? = nil) -> ApiVersionQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// Whether the version is actively supported by Shopify. Supported API 
		/// versions are guaranteed to be stable. Unsupported API versions include 
		/// unstable, release candidate, and end-of-life versions that are marked as 
		/// unsupported. For more information, refer to 
		/// [Versioning](https://shopify.dev/concepts/about-apis/versioning). 
		@discardableResult
		open func supported(alias: String? = nil) -> ApiVersionQuery {
			addField(field: "supported", aliasSuffix: alias)
			return self
		}
	}

	/// A version of the API. 
	open class ApiVersion: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ApiVersionQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "displayName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ApiVersion.self, field: fieldName, value: fieldValue)
				}
				return value

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ApiVersion.self, field: fieldName, value: fieldValue)
				}
				return value

				case "supported":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ApiVersion.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ApiVersion.self, field: fieldName, value: fieldValue)
			}
		}

		/// The human-readable name of the version. 
		open var displayName: String {
			return internalGetDisplayName()
		}

		func internalGetDisplayName(alias: String? = nil) -> String {
			return field(field: "displayName", aliasSuffix: alias) as! String
		}

		/// The unique identifier of an ApiVersion. All supported API versions have a 
		/// date-based (YYYY-MM) or `unstable` handle. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// Whether the version is actively supported by Shopify. Supported API 
		/// versions are guaranteed to be stable. Unsupported API versions include 
		/// unstable, release candidate, and end-of-life versions that are marked as 
		/// unsupported. For more information, refer to 
		/// [Versioning](https://shopify.dev/concepts/about-apis/versioning). 
		open var supported: Bool {
			return internalGetSupported()
		}

		func internalGetSupported(alias: String? = nil) -> Bool {
			return field(field: "supported", aliasSuffix: alias) as! Bool
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
