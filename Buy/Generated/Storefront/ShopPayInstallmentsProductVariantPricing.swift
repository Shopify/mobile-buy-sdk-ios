//
//  ShopPayInstallmentsProductVariantPricing.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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
	/// The shop pay installments pricing information for a product variant. 
	open class ShopPayInstallmentsProductVariantPricingQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ShopPayInstallmentsProductVariantPricing

		/// Whether the product variant is available. 
		@discardableResult
		open func available(alias: String? = nil) -> ShopPayInstallmentsProductVariantPricingQuery {
			addField(field: "available", aliasSuffix: alias)
			return self
		}

		/// Whether the product variant is eligible for Shop Pay Installments. 
		@discardableResult
		open func eligible(alias: String? = nil) -> ShopPayInstallmentsProductVariantPricingQuery {
			addField(field: "eligible", aliasSuffix: alias)
			return self
		}

		/// The full price of the product variant. 
		@discardableResult
		open func fullPrice(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsProductVariantPricingQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "fullPrice", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The ID of the product variant. 
		@discardableResult
		open func id(alias: String? = nil) -> ShopPayInstallmentsProductVariantPricingQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// The number of payment terms available for the product variant. 
		@discardableResult
		open func installmentsCount(alias: String? = nil, _ subfields: (CountQuery) -> Void) -> ShopPayInstallmentsProductVariantPricingQuery {
			let subquery = CountQuery()
			subfields(subquery)

			addField(field: "installmentsCount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The price per term for the product variant. 
		@discardableResult
		open func pricePerTerm(alias: String? = nil, _ subfields: (MoneyV2Query) -> Void) -> ShopPayInstallmentsProductVariantPricingQuery {
			let subquery = MoneyV2Query()
			subfields(subquery)

			addField(field: "pricePerTerm", aliasSuffix: alias, subfields: subquery)
			return self
		}
	}

	/// The shop pay installments pricing information for a product variant. 
	open class ShopPayInstallmentsProductVariantPricing: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = ShopPayInstallmentsProductVariantPricingQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "available":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return value

				case "eligible":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return value

				case "fullPrice":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "installmentsCount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return try Count(fields: value)

				case "pricePerTerm":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
				}
				return try MoneyV2(fields: value)

				default:
				throw SchemaViolationError(type: ShopPayInstallmentsProductVariantPricing.self, field: fieldName, value: fieldValue)
			}
		}

		/// Whether the product variant is available. 
		open var available: Bool {
			return internalGetAvailable()
		}

		func internalGetAvailable(alias: String? = nil) -> Bool {
			return field(field: "available", aliasSuffix: alias) as! Bool
		}

		/// Whether the product variant is eligible for Shop Pay Installments. 
		open var eligible: Bool {
			return internalGetEligible()
		}

		func internalGetEligible(alias: String? = nil) -> Bool {
			return field(field: "eligible", aliasSuffix: alias) as! Bool
		}

		/// The full price of the product variant. 
		open var fullPrice: Storefront.MoneyV2 {
			return internalGetFullPrice()
		}

		func internalGetFullPrice(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "fullPrice", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		/// The ID of the product variant. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// The number of payment terms available for the product variant. 
		open var installmentsCount: Storefront.Count? {
			return internalGetInstallmentsCount()
		}

		func internalGetInstallmentsCount(alias: String? = nil) -> Storefront.Count? {
			return field(field: "installmentsCount", aliasSuffix: alias) as! Storefront.Count?
		}

		/// The price per term for the product variant. 
		open var pricePerTerm: Storefront.MoneyV2 {
			return internalGetPricePerTerm()
		}

		func internalGetPricePerTerm(alias: String? = nil) -> Storefront.MoneyV2 {
			return field(field: "pricePerTerm", aliasSuffix: alias) as! Storefront.MoneyV2
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "fullPrice":
					response.append(internalGetFullPrice())
					response.append(contentsOf: internalGetFullPrice().childResponseObjectMap())

					case "installmentsCount":
					if let value = internalGetInstallmentsCount() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "pricePerTerm":
					response.append(internalGetPricePerTerm())
					response.append(contentsOf: internalGetPricePerTerm().childResponseObjectMap())

					default:
					break
				}
			}
			return response
		}
	}
}
