//
//  Menu.swift
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
	/// A [navigation 
	/// menu](https://help.shopify.com/manual/online-store/menus-and-links) 
	/// representing a hierarchy of hyperlinks (items). 
	open class MenuQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Menu

		/// The menu's handle. 
		@discardableResult
		open func handle(alias: String? = nil) -> MenuQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> MenuQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The menu's child items. 
		@discardableResult
		open func items(alias: String? = nil, _ subfields: (MenuItemQuery) -> Void) -> MenuQuery {
			let subquery = MenuItemQuery()
			subfields(subquery)

			addField(field: "items", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The count of items on the menu. 
		@discardableResult
		open func itemsCount(alias: String? = nil) -> MenuQuery {
			addField(field: "itemsCount", aliasSuffix: alias)
			return self
		}

		/// The menu's title. 
		@discardableResult
		open func title(alias: String? = nil) -> MenuQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// A [navigation 
	/// menu](https://help.shopify.com/manual/online-store/menus-and-links) 
	/// representing a hierarchy of hyperlinks (items). 
	open class Menu: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = MenuQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "items":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try MenuItem(fields: $0) }

				case "itemsCount":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Menu.self, field: fieldName, value: fieldValue)
			}
		}

		/// The menu's handle. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The menu's child items. 
		open var items: [Storefront.MenuItem] {
			return internalGetItems()
		}

		func internalGetItems(alias: String? = nil) -> [Storefront.MenuItem] {
			return field(field: "items", aliasSuffix: alias) as! [Storefront.MenuItem]
		}

		/// The count of items on the menu. 
		open var itemsCount: Int32 {
			return internalGetItemsCount()
		}

		func internalGetItemsCount(alias: String? = nil) -> Int32 {
			return field(field: "itemsCount", aliasSuffix: alias) as! Int32
		}

		/// The menu's title. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
