//
//  Domain.swift
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
	/// Represents a web address. 
	open class DomainQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Domain

		/// The host name of the domain (eg: `example.com`). 
		@discardableResult
		open func host(alias: String? = nil) -> DomainQuery {
			addField(field: "host", aliasSuffix: alias)
			return self
		}

		/// Whether SSL is enabled or not. 
		@discardableResult
		open func sslEnabled(alias: String? = nil) -> DomainQuery {
			addField(field: "sslEnabled", aliasSuffix: alias)
			return self
		}

		/// The URL of the domain (eg: `https://example.com`). 
		@discardableResult
		open func url(alias: String? = nil) -> DomainQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// Represents a web address. 
	open class Domain: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = DomainQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "host":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "sslEnabled":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "url":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// The host name of the domain (eg: `example.com`). 
		open var host: String {
			return internalGetHost()
		}

		func internalGetHost(alias: String? = nil) -> String {
			return field(field: "host", aliasSuffix: alias) as! String
		}

		/// Whether SSL is enabled or not. 
		open var sslEnabled: Bool {
			return internalGetSslEnabled()
		}

		func internalGetSslEnabled(alias: String? = nil) -> Bool {
			return field(field: "sslEnabled", aliasSuffix: alias) as! Bool
		}

		/// The URL of the domain (eg: `https://example.com`). 
		open var url: URL {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL {
			return field(field: "url", aliasSuffix: alias) as! URL
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
