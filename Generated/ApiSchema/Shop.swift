// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class ShopQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func billingAddress(aliasSuffix: String? = nil, _ subfields: (AddressQuery) -> Void) -> ShopQuery {
			let subquery = AddressQuery()
			subfields(subquery)

			addField(field: "billingAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func collections(aliasSuffix: String? = nil, first: Int32, after: String? = nil, sortKey: CollectionSortKeys? = nil, reverse: Bool? = nil, query: String? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> ShopQuery {
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

			let subquery = CollectionConnectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func currencyCode(aliasSuffix: String? = nil) -> ShopQuery {
			addField(field: "currencyCode", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func description(aliasSuffix: String? = nil) -> ShopQuery {
			addField(field: "description", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func moneyFormat(aliasSuffix: String? = nil) -> ShopQuery {
			addField(field: "moneyFormat", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func name(aliasSuffix: String? = nil) -> ShopQuery {
			addField(field: "name", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func primaryDomain(aliasSuffix: String? = nil, _ subfields: (DomainQuery) -> Void) -> ShopQuery {
			let subquery = DomainQuery()
			subfields(subquery)

			addField(field: "primaryDomain", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func privacyPolicy(aliasSuffix: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "privacyPolicy", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func products(aliasSuffix: String? = nil, first: Int32, after: String? = nil, sortKey: ProductSortKeys? = nil, reverse: Bool? = nil, query: String? = nil, _ subfields: (ProductConnectionQuery) -> Void) -> ShopQuery {
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

			let subquery = ProductConnectionQuery()
			subfields(subquery)

			addField(field: "products", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func refundPolicy(aliasSuffix: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "refundPolicy", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func termsOfService(aliasSuffix: String? = nil, _ subfields: (ShopPolicyQuery) -> Void) -> ShopQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)

			addField(field: "termsOfService", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class Shop: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "billingAddress":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Address(fields: value)

				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "description":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "moneyFormat":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "name":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "primaryDomain":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Domain(fields: value)

				case "privacyPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "products":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ProductConnection(fields: value)

				case "refundPolicy":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				case "termsOfService":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShopPolicy(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Shop" }

		open var billingAddress: ApiSchema.Address {
			return internalGetBillingAddress()
		}

		func internalGetBillingAddress(aliasSuffix: String? = nil) -> ApiSchema.Address {
			return field(field: "billingAddress", aliasSuffix: aliasSuffix) as! ApiSchema.Address
		}

		open var collections: ApiSchema.CollectionConnection {
			return internalGetCollections()
		}

		open func aliasedCollections(aliasSuffix: String) -> ApiSchema.CollectionConnection {
			return internalGetCollections(aliasSuffix: aliasSuffix)
		}

		func internalGetCollections(aliasSuffix: String? = nil) -> ApiSchema.CollectionConnection {
			return field(field: "collections", aliasSuffix: aliasSuffix) as! ApiSchema.CollectionConnection
		}

		open var currencyCode: ApiSchema.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(aliasSuffix: String? = nil) -> ApiSchema.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: aliasSuffix) as! ApiSchema.CurrencyCode
		}

		open var description: String? {
			return internalGetDescription()
		}

		func internalGetDescription(aliasSuffix: String? = nil) -> String? {
			return field(field: "description", aliasSuffix: aliasSuffix) as! String?
		}

		open var moneyFormat: String {
			return internalGetMoneyFormat()
		}

		func internalGetMoneyFormat(aliasSuffix: String? = nil) -> String {
			return field(field: "moneyFormat", aliasSuffix: aliasSuffix) as! String
		}

		open var name: String {
			return internalGetName()
		}

		func internalGetName(aliasSuffix: String? = nil) -> String {
			return field(field: "name", aliasSuffix: aliasSuffix) as! String
		}

		open var primaryDomain: ApiSchema.Domain {
			return internalGetPrimaryDomain()
		}

		func internalGetPrimaryDomain(aliasSuffix: String? = nil) -> ApiSchema.Domain {
			return field(field: "primaryDomain", aliasSuffix: aliasSuffix) as! ApiSchema.Domain
		}

		open var privacyPolicy: ApiSchema.ShopPolicy? {
			return internalGetPrivacyPolicy()
		}

		func internalGetPrivacyPolicy(aliasSuffix: String? = nil) -> ApiSchema.ShopPolicy? {
			return field(field: "privacyPolicy", aliasSuffix: aliasSuffix) as! ApiSchema.ShopPolicy?
		}

		open var products: ApiSchema.ProductConnection {
			return internalGetProducts()
		}

		open func aliasedProducts(aliasSuffix: String) -> ApiSchema.ProductConnection {
			return internalGetProducts(aliasSuffix: aliasSuffix)
		}

		func internalGetProducts(aliasSuffix: String? = nil) -> ApiSchema.ProductConnection {
			return field(field: "products", aliasSuffix: aliasSuffix) as! ApiSchema.ProductConnection
		}

		open var refundPolicy: ApiSchema.ShopPolicy? {
			return internalGetRefundPolicy()
		}

		func internalGetRefundPolicy(aliasSuffix: String? = nil) -> ApiSchema.ShopPolicy? {
			return field(field: "refundPolicy", aliasSuffix: aliasSuffix) as! ApiSchema.ShopPolicy?
		}

		open var termsOfService: ApiSchema.ShopPolicy? {
			return internalGetTermsOfService()
		}

		func internalGetTermsOfService(aliasSuffix: String? = nil) -> ApiSchema.ShopPolicy? {
			return field(field: "termsOfService", aliasSuffix: aliasSuffix) as! ApiSchema.ShopPolicy?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "billingAddress":

				return .Object

				case "collections":

				return .Object

				case "currencyCode":

				return .Scalar

				case "description":

				return .Scalar

				case "moneyFormat":

				return .Scalar

				case "name":

				return .Scalar

				case "primaryDomain":

				return .Object

				case "privacyPolicy":

				return .Object

				case "products":

				return .Object

				case "refundPolicy":

				return .Object

				case "termsOfService":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "billingAddress":
				return internalGetBillingAddress()

				case "collections":
				return internalGetCollections()

				case "primaryDomain":
				return internalGetPrimaryDomain()

				case "privacyPolicy":
				return internalGetPrivacyPolicy()

				case "products":
				return internalGetProducts()

				case "refundPolicy":
				return internalGetRefundPolicy()

				case "termsOfService":
				return internalGetTermsOfService()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "billingAddress":
					response.append(internalGetBillingAddress())
					response.append(contentsOf: internalGetBillingAddress().childResponseObjectMap())

					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "primaryDomain":
					response.append(internalGetPrimaryDomain())
					response.append(contentsOf: internalGetPrimaryDomain().childResponseObjectMap())

					case "privacyPolicy":
					if let value = internalGetPrivacyPolicy() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "products":
					response.append(internalGetProducts())
					response.append(contentsOf: internalGetProducts().childResponseObjectMap())

					case "refundPolicy":
					if let value = internalGetRefundPolicy() {
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
			})
			return response
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}
