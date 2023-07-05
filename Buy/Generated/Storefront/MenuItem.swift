//
//  MenuItem.swift
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
	/// A menu item within a parent menu. 
	open class MenuItemQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = MenuItem

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> MenuItemQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The menu item's child items. 
		@discardableResult
		open func items(alias: String? = nil, _ subfields: (MenuItemQuery) -> Void) -> MenuItemQuery {
			let subquery = MenuItemQuery()
			subfields(subquery)

			addField(field: "items", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The linked resource. 
		@discardableResult
		open func resource(alias: String? = nil, _ subfields: (MenuItemResourceQuery) -> Void) -> MenuItemQuery {
			let subquery = MenuItemResourceQuery()
			subfields(subquery)

			addField(field: "resource", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ID of the linked resource. 
		@discardableResult
		open func resourceId(alias: String? = nil) -> MenuItemQuery {
			addField(field: "resourceId", aliasSuffix: alias)
			return self
		}

		/// The menu item's tags to filter a collection. 
		@discardableResult
		open func tags(alias: String? = nil) -> MenuItemQuery {
			addField(field: "tags", aliasSuffix: alias)
			return self
		}

		/// The menu item's title. 
		@discardableResult
		open func title(alias: String? = nil) -> MenuItemQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The menu item's type. 
		@discardableResult
		open func type(alias: String? = nil) -> MenuItemQuery {
			addField(field: "type", aliasSuffix: alias)
			return self
		}

		/// The menu item's URL. 
		@discardableResult
		open func url(alias: String? = nil) -> MenuItemQuery {
			addField(field: "url", aliasSuffix: alias)
			return self
		}
	}

	/// A menu item within a parent menu. 
	open class MenuItem: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = MenuItemQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "items":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try MenuItem(fields: $0) }

				case "resource":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return try UnknownMenuItemResource.create(fields: value)

				case "resourceId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return value

				case "type":
				guard let value = value as? String else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return MenuItemType(rawValue: value) ?? .unknownValue

				case "url":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				default:
				throw SchemaViolationError(type: MenuItem.self, field: fieldName, value: fieldValue)
			}
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The menu item's child items. 
		open var items: [Storefront.MenuItem] {
			return internalGetItems()
		}

		func internalGetItems(alias: String? = nil) -> [Storefront.MenuItem] {
			return field(field: "items", aliasSuffix: alias) as! [Storefront.MenuItem]
		}

		/// The linked resource. 
		open var resource: MenuItemResource? {
			return internalGetResource()
		}

		func internalGetResource(alias: String? = nil) -> MenuItemResource? {
			return field(field: "resource", aliasSuffix: alias) as! MenuItemResource?
		}

		/// The ID of the linked resource. 
		open var resourceId: GraphQL.ID? {
			return internalGetResourceId()
		}

		func internalGetResourceId(alias: String? = nil) -> GraphQL.ID? {
			return field(field: "resourceId", aliasSuffix: alias) as! GraphQL.ID?
		}

		/// The menu item's tags to filter a collection. 
		open var tags: [String] {
			return internalGetTags()
		}

		func internalGetTags(alias: String? = nil) -> [String] {
			return field(field: "tags", aliasSuffix: alias) as! [String]
		}

		/// The menu item's title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The menu item's type. 
		open var type: Storefront.MenuItemType {
			return internalGetType()
		}

		func internalGetType(alias: String? = nil) -> Storefront.MenuItemType {
			return field(field: "type", aliasSuffix: alias) as! Storefront.MenuItemType
		}

		/// The menu item's URL. 
		open var url: URL? {
			return internalGetUrl()
		}

		func internalGetUrl(alias: String? = nil) -> URL? {
			return field(field: "url", aliasSuffix: alias) as! URL?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
