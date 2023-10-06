//
//  Shop.swift
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
	/// Shop represents a collection of the general settings and information about 
	/// the shop. 
	open class ShopQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Shop

		/// The shop's branding configuration. 
		@discardableResult
		open func brand(alias: String? = nil, _ subfields: (BrandQuery) -> Void) -> ShopQuery {
			let subquery = BrandQuery()
			subfields(subquery)

			addField(field: "brand", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A description of the shop. 
		@discardableResult
		open func description(alias: String? = nil) -> ShopQuery {
			addField(field: "description", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ShopQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// Returns a metafield found by namespace and key. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> ShopQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A string representing the way currency is formatted when the currency isn’t 
		/// specified. 
		@discardableResult
		open func moneyFormat(alias: String? = nil) -> ShopQuery {
			addField(field: "moneyFormat", aliasSuffix: alias)
			return self
		}

		/// The shop’s name. 
		@discardableResult
		open func name(alias: String? = nil) -> ShopQuery {
			addField(field: "name", aliasSuffix: alias)
			return self
		}

		/// Settings related to payments. 
		@discardableResult
		open func paymentSettings(alias: String? = nil, _ subfields: (PaymentSettingsQuery) -> Void) -> ShopQuery {
			let subquery = PaymentSettingsQuery()
			subfields(subquery)

			addField(field: "paymentSettings", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The primary domain of the shop’s Online Store. 
		@discardableResult
		open func primaryDomain(alias: String? = nil, _ subfields: (DomainQuery) -> Void) -> ShopQuery {
			let subquery = DomainQuery()
			subfields(subquery)

			addField(field: "primaryDomain", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s privacy policy. 
		@discardableResult
		open func privacyPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "privacyPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s refund policy. 
		@discardableResult
		open func refundPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "refundPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s shipping policy. 
		@discardableResult
		open func shippingPolicy(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "shippingPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// Countries that the shop ships to. 
		@discardableResult
		open func shipsToCountries(alias: String? = nil) -> ShopQuery {
			addField(field: "shipsToCountries", aliasSuffix: alias)
			return self
		}

		/// The shop’s subscription policy. 
		@discardableResult
		open func subscriptionPolicy(alias: String? = nil, _ subfields: (ShopPolicyWithDefaultQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyWithDefaultQuery()
			subfields(subquery)

			addField(field: "subscriptionPolicy", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The shop’s terms of service. 
		@discardableResult
		open func termsOfService(alias: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "termsOfService", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// Shop represents a collection of the general settings and information about 
	/// the shop. 
	open class Shop: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MetafieldParentResource, Node {
		public typealias Query = ShopQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "brand":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Brand(fields: value)

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "moneyFormat":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value

				case "paymentSettings":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try PaymentSettings(fields: value)

				case "primaryDomain":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try Domain(fields: value)

				case "privacyPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "refundPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "shippingPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "shipsToCountries":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return value.map { return CountryCode(rawValue: $0) ?? .unknownValue }

				case "subscriptionPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicyWithDefault(fields: value)

				case "termsOfService":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				default:
				throw SchemaViolationError(type: Shop.self, field: fieldName, value: fieldValue)
			}
		}

		/// The shop's branding configuration. 
		open var brand: Storefront.Brand? {
			return internalGetBrand()
		}

		func internalGetBrand(alias: String? = nil) -> Storefront.Brand? {
			return field(field: "brand", aliasSuffix: alias) as! Storefront.Brand?
		}

		/// A description of the shop. 
		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(alias: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: alias) as! String?
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// Returns a metafield found by namespace and key. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// The metafields associated with the resource matching the supplied list of 
		/// namespaces and keys. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		/// A string representing the way currency is formatted when the currency isn’t 
		/// specified. 
		open var moneyFormat: String {
			return internalGetMoneyFormat()
		}

		func internalGetMoneyFormat(alias: String? = nil) -> String {
			return field(field: "moneyFormat", aliasSuffix: alias) as! String
		}

		/// The shop’s name. 
		open var name: String {
			return internalGetName()
		}

		func internalGetName(alias: String? = nil) -> String {
			return field(field: "name", aliasSuffix: alias) as! String
		}

		/// Settings related to payments. 
		open var paymentSettings: Storefront.PaymentSettings {
			return internalGetPaymentSettings()
		}

		func internalGetPaymentSettings(alias: String? = nil) -> Storefront.PaymentSettings {
			return field(field: "paymentSettings", aliasSuffix: alias) as! Storefront.PaymentSettings
		}

		/// The primary domain of the shop’s Online Store. 
		open var primaryDomain: Storefront.Domain {
			return internalGetPrimaryDomain()
		}

		func internalGetPrimaryDomain(alias: String? = nil) -> Storefront.Domain {
			return field(field: "primaryDomain", aliasSuffix: alias) as! Storefront.Domain
		}

		/// The shop’s privacy policy. 
		open var privacyPolicy: Storefront.ShopPolicy? {
			return internalGetPrivacyPolicy()
		}

		func internalGetPrivacyPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "privacyPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// The shop’s refund policy. 
		open var refundPolicy: Storefront.ShopPolicy? {
			return internalGetRefundPolicy()
		}

		func internalGetRefundPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "refundPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// The shop’s shipping policy. 
		open var shippingPolicy: Storefront.ShopPolicy? {
			return internalGetShippingPolicy()
		}

		func internalGetShippingPolicy(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "shippingPolicy", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		/// Countries that the shop ships to. 
		open var shipsToCountries: [Storefront.CountryCode] {
			return internalGetShipsToCountries()
		}

		func internalGetShipsToCountries(alias: String? = nil) -> [Storefront.CountryCode] {
			return field(field: "shipsToCountries", aliasSuffix: alias) as! [Storefront.CountryCode]
		}

		/// The shop’s subscription policy. 
		open var subscriptionPolicy: Storefront.ShopPolicyWithDefault? {
			return internalGetSubscriptionPolicy()
		}

		func internalGetSubscriptionPolicy(alias: String? = nil) -> Storefront.ShopPolicyWithDefault? {
			return field(field: "subscriptionPolicy", aliasSuffix: alias) as! Storefront.ShopPolicyWithDefault?
		}

		/// The shop’s terms of service. 
		open var termsOfService: Storefront.ShopPolicy? {
			return internalGetTermsOfService()
		}

		func internalGetTermsOfService(alias: String? = nil) -> Storefront.ShopPolicy? {
			return field(field: "termsOfService", aliasSuffix: alias) as! Storefront.ShopPolicy?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch($0) {
					case "brand":
					if let value = internalGetBrand() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					case "paymentSettings":
					response.append(internalGetPaymentSettings())
					response.append(contentsOf: internalGetPaymentSettings().childResponseObjectMap())

					case "primaryDomain":
					response.append(internalGetPrimaryDomain())
					response.append(contentsOf: internalGetPrimaryDomain().childResponseObjectMap())

					case "privacyPolicy":
					if let value = internalGetPrivacyPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "refundPolicy":
					if let value = internalGetRefundPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingPolicy":
					if let value = internalGetShippingPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "subscriptionPolicy":
					if let value = internalGetSubscriptionPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "termsOfService":
					if let value = internalGetTermsOfService() {
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
