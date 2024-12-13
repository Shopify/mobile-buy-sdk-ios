//
//  CartBuyerIdentity.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2024 Shopify Inc. All rights reserved.
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
	/// Represents information about the buyer that is interacting with the cart. 
	open class CartBuyerIdentityQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = CartBuyerIdentity

		/// The country where the buyer is located. 
		@discardableResult
		open func countryCode(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "countryCode", aliasSuffix: alias)
			return self
		}

		/// The customer account associated with the cart. 
		@discardableResult
		open func customer(alias: String? = nil, _ subfields: (CustomerQuery) -> Void) -> CartBuyerIdentityQuery {
			let subquery = CustomerQuery()
			subfields(subquery)

			addField(field: "customer", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// An ordered set of delivery addresses tied to the buyer that is interacting 
		/// with the cart. The rank of the preferences is determined by the order of 
		/// the addresses in the array. Preferences can be used to populate relevant 
		/// fields in the checkout flow. 
		@discardableResult
		open func deliveryAddressPreferences(alias: String? = nil, _ subfields: (DeliveryAddressQuery) -> Void) -> CartBuyerIdentityQuery {
			let subquery = DeliveryAddressQuery()
			subfields(subquery)

			addField(field: "deliveryAddressPreferences", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The email address of the buyer that's interacting with the cart. 
		@discardableResult
		open func email(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "email", aliasSuffix: alias)
			return self
		}

		/// The phone number of the buyer that's interacting with the cart. 
		@discardableResult
		open func phone(alias: String? = nil) -> CartBuyerIdentityQuery {
			addField(field: "phone", aliasSuffix: alias)
			return self
		}

		/// A set of preferences tied to the buyer interacting with the cart. 
		/// Preferences are used to prefill fields in at checkout to streamline 
		/// information collection. Preferences are not synced back to the cart if they 
		/// are overwritten. 
		@discardableResult
		open func preferences(alias: String? = nil, _ subfields: (CartPreferencesQuery) -> Void) -> CartBuyerIdentityQuery {
			let subquery = CartPreferencesQuery()
			subfields(subquery)

			addField(field: "preferences", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The purchasing company associated with the cart. 
		@discardableResult
		open func purchasingCompany(alias: String? = nil, _ subfields: (PurchasingCompanyQuery) -> Void) -> CartBuyerIdentityQuery {
			let subquery = PurchasingCompanyQuery()
			subfields(subquery)

			addField(field: "purchasingCompany", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Represents information about the buyer that is interacting with the cart. 
	open class CartBuyerIdentity: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = CartBuyerIdentityQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "countryCode":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return CountryCode(rawValue: value) ?? .unknownValue

				case "customer":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return try Customer(fields: value)

				case "deliveryAddressPreferences":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try UnknownDeliveryAddress.create(fields: $0) }

				case "email":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return value

				case "phone":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return value

				case "preferences":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return try CartPreferences(fields: value)

				case "purchasingCompany":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
				}
				return try PurchasingCompany(fields: value)

				default:
				throw SchemaViolationError(type: CartBuyerIdentity.self, field: fieldName, value: fieldValue)
			}
		}

		/// The country where the buyer is located. 
		open var countryCode: Storefront.CountryCode? {
			return internalGetCountryCode()
		}

		func internalGetCountryCode(alias: String? = nil) -> Storefront.CountryCode? {
			return field(field: "countryCode", aliasSuffix: alias) as! Storefront.CountryCode?
		}

		/// The customer account associated with the cart. 
		open var customer: Storefront.Customer? {
			return internalGetCustomer()
		}

		func internalGetCustomer(alias: String? = nil) -> Storefront.Customer? {
			return field(field: "customer", aliasSuffix: alias) as! Storefront.Customer?
		}

		/// An ordered set of delivery addresses tied to the buyer that is interacting 
		/// with the cart. The rank of the preferences is determined by the order of 
		/// the addresses in the array. Preferences can be used to populate relevant 
		/// fields in the checkout flow. 
		open var deliveryAddressPreferences: [DeliveryAddress] {
			return internalGetDeliveryAddressPreferences()
		}

		func internalGetDeliveryAddressPreferences(alias: String? = nil) -> [DeliveryAddress] {
			return field(field: "deliveryAddressPreferences", aliasSuffix: alias) as! [DeliveryAddress]
		}

		/// The email address of the buyer that's interacting with the cart. 
		open var email: String? {
			return internalGetEmail()
		}

		func internalGetEmail(alias: String? = nil) -> String? {
			return field(field: "email", aliasSuffix: alias) as! String?
		}

		/// The phone number of the buyer that's interacting with the cart. 
		open var phone: String? {
			return internalGetPhone()
		}

		func internalGetPhone(alias: String? = nil) -> String? {
			return field(field: "phone", aliasSuffix: alias) as! String?
		}

		/// A set of preferences tied to the buyer interacting with the cart. 
		/// Preferences are used to prefill fields in at checkout to streamline 
		/// information collection. Preferences are not synced back to the cart if they 
		/// are overwritten. 
		open var preferences: Storefront.CartPreferences? {
			return internalGetPreferences()
		}

		func internalGetPreferences(alias: String? = nil) -> Storefront.CartPreferences? {
			return field(field: "preferences", aliasSuffix: alias) as! Storefront.CartPreferences?
		}

		/// The purchasing company associated with the cart. 
		open var purchasingCompany: Storefront.PurchasingCompany? {
			return internalGetPurchasingCompany()
		}

		func internalGetPurchasingCompany(alias: String? = nil) -> Storefront.PurchasingCompany? {
			return field(field: "purchasingCompany", aliasSuffix: alias) as! Storefront.PurchasingCompany?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "customer":
					if let value = internalGetCustomer() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "deliveryAddressPreferences":
					internalGetDeliveryAddressPreferences().forEach {
						response.append(($0 as! GraphQL.AbstractResponse))
						response.append(contentsOf: ($0 as! GraphQL.AbstractResponse).childResponseObjectMap())
					}

					case "preferences":
					if let value = internalGetPreferences() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "purchasingCompany":
					if let value = internalGetPurchasingCompany() {
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
