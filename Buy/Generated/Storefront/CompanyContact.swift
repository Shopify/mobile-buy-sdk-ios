//
//  CompanyContact.swift
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
	/// A company's main point of contact. 
	open class CompanyContactQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CompanyContact

		/// The date and time ([ISO 8601 
		/// format](http://en.wikipedia.org/wiki/ISO_8601)) at which the company 
		/// contact was created in Shopify. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> CompanyContactQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> CompanyContactQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The company contact's locale (language). 
		@discardableResult
		open func locale(alias: String? = nil) -> CompanyContactQuery {
			addField(field: "locale", aliasSuffix: alias)
			return self
		}

		/// The company contact's job title. 
		@discardableResult
		open func title(alias: String? = nil) -> CompanyContactQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The date and time ([ISO 8601 
		/// format](http://en.wikipedia.org/wiki/ISO_8601)) at which the company 
		/// contact was last modified. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> CompanyContactQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// A company's main point of contact. 
	open class CompanyContact: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = CompanyContactQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "locale":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
				}
				return value

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: CompanyContact.self, field: fieldName, value: fieldValue)
			}
		}

		/// The date and time ([ISO 8601 
		/// format](http://en.wikipedia.org/wiki/ISO_8601)) at which the company 
		/// contact was created in Shopify. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The company contact's locale (language). 
		open var locale: String? {
			return internalGetLocale()
		}

		func internalGetLocale(alias: String? = nil) -> String? {
			return field(field: "locale", aliasSuffix: alias) as! String?
		}

		/// The company contact's job title. 
		open var title: String? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String? {
			return field(field: "title", aliasSuffix: alias) as! String?
		}

		/// The date and time ([ISO 8601 
		/// format](http://en.wikipedia.org/wiki/ISO_8601)) at which the company 
		/// contact was last modified. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
