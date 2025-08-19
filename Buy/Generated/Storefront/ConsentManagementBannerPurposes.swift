//
//  ConsentManagementBannerPurposes.swift
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
	/// Descriptions associated with each purpose. 
	open class ConsentManagementBannerPurposesQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementBannerPurposes

		/// Long description for the essential purpose. 
		@discardableResult
		open func essentialDesc(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "essentialDesc", aliasSuffix: alias)
			return self
		}

		/// Short description for the essential purpose. 
		@discardableResult
		open func essentialName(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "essentialName", aliasSuffix: alias)
			return self
		}

		/// Long description for the marketing purpose. 
		@discardableResult
		open func marketingDesc(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "marketingDesc", aliasSuffix: alias)
			return self
		}

		/// Short description for the marketing purpose. 
		@discardableResult
		open func marketingName(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "marketingName", aliasSuffix: alias)
			return self
		}

		/// Long description for the performance purpose. 
		@discardableResult
		open func performanceDesc(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "performanceDesc", aliasSuffix: alias)
			return self
		}

		/// Short description for the performance purpose. 
		@discardableResult
		open func performanceName(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "performanceName", aliasSuffix: alias)
			return self
		}

		/// Long description for the preferences purpose. 
		@discardableResult
		open func preferencesDesc(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "preferencesDesc", aliasSuffix: alias)
			return self
		}

		/// Short description for the preferences purpose. 
		@discardableResult
		open func preferencesName(alias: String? = nil) -> ConsentManagementBannerPurposesQuery {
			addField(field: "preferencesName", aliasSuffix: alias)
			return self
		}
	}

	/// Descriptions associated with each purpose. 
	open class ConsentManagementBannerPurposes: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementBannerPurposesQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "essentialDesc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "essentialName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "marketingDesc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "marketingName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "performanceDesc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "performanceName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "preferencesDesc":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				case "preferencesName":
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ConsentManagementBannerPurposes.self, field: fieldName, value: fieldValue)
			}
		}

		/// Long description for the essential purpose. 
		open var essentialDesc: String {
			return internalGetEssentialDesc()
		}

		func internalGetEssentialDesc(alias: String? = nil) -> String {
			return field(field: "essentialDesc", aliasSuffix: alias) as! String
		}

		/// Short description for the essential purpose. 
		open var essentialName: String {
			return internalGetEssentialName()
		}

		func internalGetEssentialName(alias: String? = nil) -> String {
			return field(field: "essentialName", aliasSuffix: alias) as! String
		}

		/// Long description for the marketing purpose. 
		open var marketingDesc: String {
			return internalGetMarketingDesc()
		}

		func internalGetMarketingDesc(alias: String? = nil) -> String {
			return field(field: "marketingDesc", aliasSuffix: alias) as! String
		}

		/// Short description for the marketing purpose. 
		open var marketingName: String {
			return internalGetMarketingName()
		}

		func internalGetMarketingName(alias: String? = nil) -> String {
			return field(field: "marketingName", aliasSuffix: alias) as! String
		}

		/// Long description for the performance purpose. 
		open var performanceDesc: String {
			return internalGetPerformanceDesc()
		}

		func internalGetPerformanceDesc(alias: String? = nil) -> String {
			return field(field: "performanceDesc", aliasSuffix: alias) as! String
		}

		/// Short description for the performance purpose. 
		open var performanceName: String {
			return internalGetPerformanceName()
		}

		func internalGetPerformanceName(alias: String? = nil) -> String {
			return field(field: "performanceName", aliasSuffix: alias) as! String
		}

		/// Long description for the preferences purpose. 
		open var preferencesDesc: String {
			return internalGetPreferencesDesc()
		}

		func internalGetPreferencesDesc(alias: String? = nil) -> String {
			return field(field: "preferencesDesc", aliasSuffix: alias) as! String
		}

		/// Short description for the preferences purpose. 
		open var preferencesName: String {
			return internalGetPreferencesName()
		}

		func internalGetPreferencesName(alias: String? = nil) -> String {
			return field(field: "preferencesName", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
