//
//  ConsentManagementBannerBulletPoints.swift
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
	/// Bullet points that provide clarity on the actions and consequences of 
	/// cookie acceptance. 
	open class ConsentManagementBannerBulletPointsQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = ConsentManagementBannerBulletPoints

		/// Whether bullet points are enabled. 
		@discardableResult
		open func enabled(alias: String? = nil) -> ConsentManagementBannerBulletPointsQuery {
			addField(field: "enabled", aliasSuffix: alias)
			return self
		}

		/// Text of the first bullet point. 
		@discardableResult
		open func firstText(alias: String? = nil) -> ConsentManagementBannerBulletPointsQuery {
			addField(field: "firstText", aliasSuffix: alias)
			return self
		}

		/// Text of the second bullet point. 
		@discardableResult
		open func secondText(alias: String? = nil) -> ConsentManagementBannerBulletPointsQuery {
			addField(field: "secondText", aliasSuffix: alias)
			return self
		}

		/// Text of the third bullet point. 
		@discardableResult
		open func thirdText(alias: String? = nil) -> ConsentManagementBannerBulletPointsQuery {
			addField(field: "thirdText", aliasSuffix: alias)
			return self
		}

		/// Title of the bullet points. 
		@discardableResult
		open func title(alias: String? = nil) -> ConsentManagementBannerBulletPointsQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}
	}

	/// Bullet points that provide clarity on the actions and consequences of 
	/// cookie acceptance. 
	open class ConsentManagementBannerBulletPoints: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = ConsentManagementBannerBulletPointsQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "enabled":
				if value is NSNull { return nil }
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
				}
				return value

				case "firstText":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
				}
				return value

				case "secondText":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
				}
				return value

				case "thirdText":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
				}
				return value

				case "title":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: ConsentManagementBannerBulletPoints.self, field: fieldName, value: fieldValue)
			}
		}

		/// Whether bullet points are enabled. 
		open var enabled: Bool? {
			return internalGetEnabled()
		}

		func internalGetEnabled(alias: String? = nil) -> Bool? {
			return field(field: "enabled", aliasSuffix: alias) as! Bool?
		}

		/// Text of the first bullet point. 
		open var firstText: String? {
			return internalGetFirstText()
		}

		func internalGetFirstText(alias: String? = nil) -> String? {
			return field(field: "firstText", aliasSuffix: alias) as! String?
		}

		/// Text of the second bullet point. 
		open var secondText: String? {
			return internalGetSecondText()
		}

		func internalGetSecondText(alias: String? = nil) -> String? {
			return field(field: "secondText", aliasSuffix: alias) as! String?
		}

		/// Text of the third bullet point. 
		open var thirdText: String? {
			return internalGetThirdText()
		}

		func internalGetThirdText(alias: String? = nil) -> String? {
			return field(field: "thirdText", aliasSuffix: alias) as! String?
		}

		/// Title of the bullet points. 
		open var title: String? {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String? {
			return field(field: "title", aliasSuffix: alias) as! String?
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			return []
		}
	}
}
