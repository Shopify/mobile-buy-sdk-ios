//
//  Customer.swift
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
	/// A customer represents a customer account with the shop. Customer accounts 
	/// store contact information for the customer, saving logged-in customers the 
	/// trouble of having to provide it at every checkout. 
	open class CustomerQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Customer

		/// Indicates whether the customer has consented to be sent marketing material 
		/// via email. 
		@discardableResult
		open func acceptsMarketing(alias: String? = nil) -> CustomerQuery {
			addField(field: "acceptsMarketing", aliasSuffix: alias)
			return self
		}

		/// A list of addresses for the customer. 
		///
		/// - parameters:
		///     - first: No description
		///     - after: No description
		///     - reverse: No description
		///
		@discardableResult
		open func addresses(alias: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (MailingAddressConnectionQuery) -> Void) -> CustomerQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MailingAddressConnectionQuery()
			subfields(subquery)

			addField(field: "addresses", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The date and time when the customer was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> CustomerQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// The customer’s default address. 
		@discardableResult
		open func defaultAddress(alias: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> CustomerQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "defaultAddress", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The customer’s name, email or phone number. 
		@discardableResult
		open func displayName(alias: String? = nil) -> CustomerQuery {
			addField(field: "displayName", aliasSuffix: alias)
			return self
		}

		/// The customer’s email address. 
		@discardableResult
		open func email(alias: String? = nil) -> CustomerQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The customer’s first name. 
		@discardableResult
		open func firstName(alias: String? = nil) -> CustomerQuery {
			addField(field: "firstName", aliasSuffix: alias)
			return self
		}

		/// A unique identifier for the customer. 
		@discardableResult
		open func id(alias: String? = nil) -> CustomerQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The customer’s last name. 
		@discardableResult
		open func lastName(alias: String? = nil) -> CustomerQuery {
			addField(field: "lastName", aliasSuffix: alias)
			return self
		}

		/// The orders associated with the customer. 
		///
		/// - parameters:
		///     - first: No description
		///     - after: No description
		///     - sortKey: No description
		///     - reverse: No description
		///     - query: Supported filter parameters:
		///         - `processed_at`
		///
		@discardableResult
		open func orders(alias: String? = nil, first: Int32, after: String? = nil, sortKey: OrderSortKeys? = nil, reverse: Bool? = nil, query: String? = nil, _ subfields: (OrderConnectionQuery) -> Void) -> CustomerQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let query = query {
				args.append("query:\(GraphQL.quoteString(input: query))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = OrderConnectionQuery()
			subfields(subquery)

			addField(field: "orders", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The customer’s phone number. 
		@discardableResult
		open func phone(alias: String? = nil) -> CustomerQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// The date and time when the customer information was updated. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> CustomerQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}
	}

	/// A customer represents a customer account with the shop. Customer accounts 
	/// store contact information for the customer, saving logged-in customers the 
	/// trouble of having to provide it at every checkout. 
	open class Customer: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CustomerQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "acceptsMarketing":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "addresses":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddressConnection(fields: value)

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "defaultAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "displayName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "firstName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastName":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "orders":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try OrderConnection(fields: value)

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		/// Indicates whether the customer has consented to be sent marketing material 
		/// via email. 
		open var acceptsMarketing: Bool {
			return internalGetAcceptsMarketing()
		}

		func internalGetAcceptsMarketing(alias: String? = nil) -> Bool {
			return field(field: "acceptsMarketing", aliasSuffix: alias) as! Bool
		}

		/// A list of addresses for the customer. 
		open var addresses: Storefront.MailingAddressConnection {
			return internalGetAddresses()
		}

		open func aliasedAddresses(alias: String) -> Storefront.MailingAddressConnection {
			return internalGetAddresses(alias: alias)
		}

		func internalGetAddresses(alias: String? = nil) -> Storefront.MailingAddressConnection {
			return field(field: "addresses", aliasSuffix: alias) as! Storefront.MailingAddressConnection
		}

		/// The date and time when the customer was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// The customer’s default address. 
		open var defaultAddress: Storefront.MailingAddress? {
			return internalGetDefaultAddress()
		}

		func internalGetDefaultAddress(alias: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "defaultAddress", aliasSuffix: alias) as! Storefront.MailingAddress?
		}

		/// The customer’s name, email or phone number. 
		open var displayName: String {
			return internalGetDisplayName()
		}

		func internalGetDisplayName(alias: String? = nil) -> String {
			return field(field: "displayName", aliasSuffix: alias) as! String
		}

		/// The customer’s email address. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// The customer’s first name. 
		open var firstName: String? {
			return internalGetFirstName()
		}

		func internalGetFirstName(alias: String? = nil) -> String? {
			return field(field: "firstName", aliasSuffix: alias) as! String?
		}

		/// A unique identifier for the customer. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The customer’s last name. 
		open var lastName: String? {
			return internalGetLastName()
		}

		func internalGetLastName(alias: String? = nil) -> String? {
			return field(field: "lastName", aliasSuffix: alias) as! String?
		}

		/// The orders associated with the customer. 
		open var orders: Storefront.OrderConnection {
			return internalGetOrders()
		}

		open func aliasedOrders(alias: String) -> Storefront.OrderConnection {
			return internalGetOrders(alias: alias)
		}

		func internalGetOrders(alias: String? = nil) -> Storefront.OrderConnection {
			return field(field: "orders", aliasSuffix: alias) as! Storefront.OrderConnection
		}

		/// The customer’s phone number. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// The date and time when the customer information was updated. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "addresses":
					response.append(internalGetAddresses())
					response.append(contentsOf: internalGetAddresses().childResponseObjectMap())

					case "defaultAddress":
					if let value = internalGetDefaultAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "orders":
					response.append(internalGetOrders())
					response.append(contentsOf: internalGetOrders().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
