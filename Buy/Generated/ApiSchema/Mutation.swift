// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class MutationQuery: GraphQL.AbstractQuery {
		open override var description: String {
			return "mutation" + super.description
		}

		@discardableResult
		open func apiCustomerAccessTokenCreate(aliasSuffix: String? = nil, input: ApiCustomerAccessTokenCreateInput, _ subfields: (ApiCustomerAccessTokenCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ApiCustomerAccessTokenCreatePayloadQuery()
			subfields(subquery)

			addField(field: "apiCustomerAccessTokenCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func apiCustomerAccessTokenDelete(aliasSuffix: String? = nil, input: ApiCustomerAccessTokenDeleteInput, _ subfields: (ApiCustomerAccessTokenDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ApiCustomerAccessTokenDeletePayloadQuery()
			subfields(subquery)

			addField(field: "apiCustomerAccessTokenDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func apiCustomerAccessTokenRenew(aliasSuffix: String? = nil, input: ApiCustomerAccessTokenRenewInput, _ subfields: (ApiCustomerAccessTokenRenewPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ApiCustomerAccessTokenRenewPayloadQuery()
			subfields(subquery)

			addField(field: "apiCustomerAccessTokenRenew", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerActivate(aliasSuffix: String? = nil, input: CustomerActivateInput, _ subfields: (CustomerActivatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerActivatePayloadQuery()
			subfields(subquery)

			addField(field: "customerActivate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerCreate(aliasSuffix: String? = nil, input: CustomerInput, _ subfields: (CustomerCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerMailingAddressCreate(aliasSuffix: String? = nil, input: CustomerMailingAddressCreateInput, _ subfields: (CustomerMailingAddressCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerMailingAddressCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerMailingAddressCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerMailingAddressDelete(aliasSuffix: String? = nil, input: CustomerMailingAddressDeleteInput, _ subfields: (CustomerMailingAddressDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerMailingAddressDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerMailingAddressDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerMailingAddressUpdate(aliasSuffix: String? = nil, input: CustomerMailingAddressUpdateInput, _ subfields: (CustomerMailingAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerMailingAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerMailingAddressUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerRecover(aliasSuffix: String? = nil, input: CustomerRecoverInput, _ subfields: (CustomerRecoverPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerRecoverPayloadQuery()
			subfields(subquery)

			addField(field: "customerRecover", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerReset(aliasSuffix: String? = nil, input: CustomerResetInput, _ subfields: (CustomerResetPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerResetPayloadQuery()
			subfields(subquery)

			addField(field: "customerReset", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerUpdate(aliasSuffix: String? = nil, input: CustomerInput, _ subfields: (CustomerUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func purchaseSessionCreate(aliasSuffix: String? = nil, input: PurchaseSessionCreateInput, _ subfields: (PurchaseSessionCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = PurchaseSessionCreatePayloadQuery()
			subfields(subquery)

			addField(field: "purchaseSessionCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func purchaseSessionShippingRateUpdate(aliasSuffix: String? = nil, input: PurchaseSessionShippingRateUpdateInput, _ subfields: (PurchaseSessionShippingRateUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = PurchaseSessionShippingRateUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "purchaseSessionShippingRateUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func purchaseSessionUpdate(aliasSuffix: String? = nil, input: PurchaseSessionUpdateInput, _ subfields: (PurchaseSessionUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = PurchaseSessionUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "purchaseSessionUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func shippingRatesRequestCreate(aliasSuffix: String? = nil, input: ShippingRatesRequestCreateInput, _ subfields: (ShippingRatesRequestCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = ShippingRatesRequestCreatePayloadQuery()
			subfields(subquery)

			addField(field: "shippingRatesRequestCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}
	}

	open class Mutation: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "apiCustomerAccessTokenCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ApiCustomerAccessTokenCreatePayload(fields: value)

				case "apiCustomerAccessTokenDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ApiCustomerAccessTokenDeletePayload(fields: value)

				case "apiCustomerAccessTokenRenew":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ApiCustomerAccessTokenRenewPayload(fields: value)

				case "customerActivate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerActivatePayload(fields: value)

				case "customerCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerCreatePayload(fields: value)

				case "customerMailingAddressCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerMailingAddressCreatePayload(fields: value)

				case "customerMailingAddressDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerMailingAddressDeletePayload(fields: value)

				case "customerMailingAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerMailingAddressUpdatePayload(fields: value)

				case "customerRecover":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerRecoverPayload(fields: value)

				case "customerReset":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerResetPayload(fields: value)

				case "customerUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerUpdatePayload(fields: value)

				case "purchaseSessionCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try PurchaseSessionCreatePayload(fields: value)

				case "purchaseSessionShippingRateUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try PurchaseSessionShippingRateUpdatePayload(fields: value)

				case "purchaseSessionUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try PurchaseSessionUpdatePayload(fields: value)

				case "shippingRatesRequestCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try ShippingRatesRequestCreatePayload(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Mutation" }

		open var apiCustomerAccessTokenCreate: ApiSchema.ApiCustomerAccessTokenCreatePayload? {
			return internalGetApiCustomerAccessTokenCreate()
		}

		open func aliasedApiCustomerAccessTokenCreate(aliasSuffix: String) -> ApiSchema.ApiCustomerAccessTokenCreatePayload? {
			return internalGetApiCustomerAccessTokenCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetApiCustomerAccessTokenCreate(aliasSuffix: String? = nil) -> ApiSchema.ApiCustomerAccessTokenCreatePayload? {
			return field(field: "apiCustomerAccessTokenCreate", aliasSuffix: aliasSuffix) as! ApiSchema.ApiCustomerAccessTokenCreatePayload?
		}

		open var apiCustomerAccessTokenDelete: ApiSchema.ApiCustomerAccessTokenDeletePayload? {
			return internalGetApiCustomerAccessTokenDelete()
		}

		open func aliasedApiCustomerAccessTokenDelete(aliasSuffix: String) -> ApiSchema.ApiCustomerAccessTokenDeletePayload? {
			return internalGetApiCustomerAccessTokenDelete(aliasSuffix: aliasSuffix)
		}

		func internalGetApiCustomerAccessTokenDelete(aliasSuffix: String? = nil) -> ApiSchema.ApiCustomerAccessTokenDeletePayload? {
			return field(field: "apiCustomerAccessTokenDelete", aliasSuffix: aliasSuffix) as! ApiSchema.ApiCustomerAccessTokenDeletePayload?
		}

		open var apiCustomerAccessTokenRenew: ApiSchema.ApiCustomerAccessTokenRenewPayload? {
			return internalGetApiCustomerAccessTokenRenew()
		}

		open func aliasedApiCustomerAccessTokenRenew(aliasSuffix: String) -> ApiSchema.ApiCustomerAccessTokenRenewPayload? {
			return internalGetApiCustomerAccessTokenRenew(aliasSuffix: aliasSuffix)
		}

		func internalGetApiCustomerAccessTokenRenew(aliasSuffix: String? = nil) -> ApiSchema.ApiCustomerAccessTokenRenewPayload? {
			return field(field: "apiCustomerAccessTokenRenew", aliasSuffix: aliasSuffix) as! ApiSchema.ApiCustomerAccessTokenRenewPayload?
		}

		open var customerActivate: ApiSchema.CustomerActivatePayload? {
			return internalGetCustomerActivate()
		}

		open func aliasedCustomerActivate(aliasSuffix: String) -> ApiSchema.CustomerActivatePayload? {
			return internalGetCustomerActivate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerActivate(aliasSuffix: String? = nil) -> ApiSchema.CustomerActivatePayload? {
			return field(field: "customerActivate", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerActivatePayload?
		}

		open var customerCreate: ApiSchema.CustomerCreatePayload? {
			return internalGetCustomerCreate()
		}

		open func aliasedCustomerCreate(aliasSuffix: String) -> ApiSchema.CustomerCreatePayload? {
			return internalGetCustomerCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerCreate(aliasSuffix: String? = nil) -> ApiSchema.CustomerCreatePayload? {
			return field(field: "customerCreate", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerCreatePayload?
		}

		open var customerMailingAddressCreate: ApiSchema.CustomerMailingAddressCreatePayload? {
			return internalGetCustomerMailingAddressCreate()
		}

		open func aliasedCustomerMailingAddressCreate(aliasSuffix: String) -> ApiSchema.CustomerMailingAddressCreatePayload? {
			return internalGetCustomerMailingAddressCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerMailingAddressCreate(aliasSuffix: String? = nil) -> ApiSchema.CustomerMailingAddressCreatePayload? {
			return field(field: "customerMailingAddressCreate", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerMailingAddressCreatePayload?
		}

		open var customerMailingAddressDelete: ApiSchema.CustomerMailingAddressDeletePayload? {
			return internalGetCustomerMailingAddressDelete()
		}

		open func aliasedCustomerMailingAddressDelete(aliasSuffix: String) -> ApiSchema.CustomerMailingAddressDeletePayload? {
			return internalGetCustomerMailingAddressDelete(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerMailingAddressDelete(aliasSuffix: String? = nil) -> ApiSchema.CustomerMailingAddressDeletePayload? {
			return field(field: "customerMailingAddressDelete", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerMailingAddressDeletePayload?
		}

		open var customerMailingAddressUpdate: ApiSchema.CustomerMailingAddressUpdatePayload? {
			return internalGetCustomerMailingAddressUpdate()
		}

		open func aliasedCustomerMailingAddressUpdate(aliasSuffix: String) -> ApiSchema.CustomerMailingAddressUpdatePayload? {
			return internalGetCustomerMailingAddressUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerMailingAddressUpdate(aliasSuffix: String? = nil) -> ApiSchema.CustomerMailingAddressUpdatePayload? {
			return field(field: "customerMailingAddressUpdate", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerMailingAddressUpdatePayload?
		}

		open var customerRecover: ApiSchema.CustomerRecoverPayload? {
			return internalGetCustomerRecover()
		}

		open func aliasedCustomerRecover(aliasSuffix: String) -> ApiSchema.CustomerRecoverPayload? {
			return internalGetCustomerRecover(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerRecover(aliasSuffix: String? = nil) -> ApiSchema.CustomerRecoverPayload? {
			return field(field: "customerRecover", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerRecoverPayload?
		}

		open var customerReset: ApiSchema.CustomerResetPayload? {
			return internalGetCustomerReset()
		}

		open func aliasedCustomerReset(aliasSuffix: String) -> ApiSchema.CustomerResetPayload? {
			return internalGetCustomerReset(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerReset(aliasSuffix: String? = nil) -> ApiSchema.CustomerResetPayload? {
			return field(field: "customerReset", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerResetPayload?
		}

		open var customerUpdate: ApiSchema.CustomerUpdatePayload? {
			return internalGetCustomerUpdate()
		}

		open func aliasedCustomerUpdate(aliasSuffix: String) -> ApiSchema.CustomerUpdatePayload? {
			return internalGetCustomerUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerUpdate(aliasSuffix: String? = nil) -> ApiSchema.CustomerUpdatePayload? {
			return field(field: "customerUpdate", aliasSuffix: aliasSuffix) as! ApiSchema.CustomerUpdatePayload?
		}

		open var purchaseSessionCreate: ApiSchema.PurchaseSessionCreatePayload? {
			return internalGetPurchaseSessionCreate()
		}

		open func aliasedPurchaseSessionCreate(aliasSuffix: String) -> ApiSchema.PurchaseSessionCreatePayload? {
			return internalGetPurchaseSessionCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetPurchaseSessionCreate(aliasSuffix: String? = nil) -> ApiSchema.PurchaseSessionCreatePayload? {
			return field(field: "purchaseSessionCreate", aliasSuffix: aliasSuffix) as! ApiSchema.PurchaseSessionCreatePayload?
		}

		open var purchaseSessionShippingRateUpdate: ApiSchema.PurchaseSessionShippingRateUpdatePayload? {
			return internalGetPurchaseSessionShippingRateUpdate()
		}

		open func aliasedPurchaseSessionShippingRateUpdate(aliasSuffix: String) -> ApiSchema.PurchaseSessionShippingRateUpdatePayload? {
			return internalGetPurchaseSessionShippingRateUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetPurchaseSessionShippingRateUpdate(aliasSuffix: String? = nil) -> ApiSchema.PurchaseSessionShippingRateUpdatePayload? {
			return field(field: "purchaseSessionShippingRateUpdate", aliasSuffix: aliasSuffix) as! ApiSchema.PurchaseSessionShippingRateUpdatePayload?
		}

		open var purchaseSessionUpdate: ApiSchema.PurchaseSessionUpdatePayload? {
			return internalGetPurchaseSessionUpdate()
		}

		open func aliasedPurchaseSessionUpdate(aliasSuffix: String) -> ApiSchema.PurchaseSessionUpdatePayload? {
			return internalGetPurchaseSessionUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetPurchaseSessionUpdate(aliasSuffix: String? = nil) -> ApiSchema.PurchaseSessionUpdatePayload? {
			return field(field: "purchaseSessionUpdate", aliasSuffix: aliasSuffix) as! ApiSchema.PurchaseSessionUpdatePayload?
		}

		open var shippingRatesRequestCreate: ApiSchema.ShippingRatesRequestCreatePayload? {
			return internalGetShippingRatesRequestCreate()
		}

		open func aliasedShippingRatesRequestCreate(aliasSuffix: String) -> ApiSchema.ShippingRatesRequestCreatePayload? {
			return internalGetShippingRatesRequestCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetShippingRatesRequestCreate(aliasSuffix: String? = nil) -> ApiSchema.ShippingRatesRequestCreatePayload? {
			return field(field: "shippingRatesRequestCreate", aliasSuffix: aliasSuffix) as! ApiSchema.ShippingRatesRequestCreatePayload?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "apiCustomerAccessTokenCreate":

				return .Object

				case "apiCustomerAccessTokenDelete":

				return .Object

				case "apiCustomerAccessTokenRenew":

				return .Object

				case "customerActivate":

				return .Object

				case "customerCreate":

				return .Object

				case "customerMailingAddressCreate":

				return .Object

				case "customerMailingAddressDelete":

				return .Object

				case "customerMailingAddressUpdate":

				return .Object

				case "customerRecover":

				return .Object

				case "customerReset":

				return .Object

				case "customerUpdate":

				return .Object

				case "purchaseSessionCreate":

				return .Object

				case "purchaseSessionShippingRateUpdate":

				return .Object

				case "purchaseSessionUpdate":

				return .Object

				case "shippingRatesRequestCreate":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "apiCustomerAccessTokenCreate":
				return internalGetApiCustomerAccessTokenCreate()

				case "apiCustomerAccessTokenDelete":
				return internalGetApiCustomerAccessTokenDelete()

				case "apiCustomerAccessTokenRenew":
				return internalGetApiCustomerAccessTokenRenew()

				case "customerActivate":
				return internalGetCustomerActivate()

				case "customerCreate":
				return internalGetCustomerCreate()

				case "customerMailingAddressCreate":
				return internalGetCustomerMailingAddressCreate()

				case "customerMailingAddressDelete":
				return internalGetCustomerMailingAddressDelete()

				case "customerMailingAddressUpdate":
				return internalGetCustomerMailingAddressUpdate()

				case "customerRecover":
				return internalGetCustomerRecover()

				case "customerReset":
				return internalGetCustomerReset()

				case "customerUpdate":
				return internalGetCustomerUpdate()

				case "purchaseSessionCreate":
				return internalGetPurchaseSessionCreate()

				case "purchaseSessionShippingRateUpdate":
				return internalGetPurchaseSessionShippingRateUpdate()

				case "purchaseSessionUpdate":
				return internalGetPurchaseSessionUpdate()

				case "shippingRatesRequestCreate":
				return internalGetShippingRatesRequestCreate()

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
					case "apiCustomerAccessTokenCreate":
					if let value = internalGetApiCustomerAccessTokenCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "apiCustomerAccessTokenDelete":
					if let value = internalGetApiCustomerAccessTokenDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "apiCustomerAccessTokenRenew":
					if let value = internalGetApiCustomerAccessTokenRenew() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerActivate":
					if let value = internalGetCustomerActivate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerCreate":
					if let value = internalGetCustomerCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerMailingAddressCreate":
					if let value = internalGetCustomerMailingAddressCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerMailingAddressDelete":
					if let value = internalGetCustomerMailingAddressDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerMailingAddressUpdate":
					if let value = internalGetCustomerMailingAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerRecover":
					if let value = internalGetCustomerRecover() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerReset":
					if let value = internalGetCustomerReset() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerUpdate":
					if let value = internalGetCustomerUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "purchaseSessionCreate":
					if let value = internalGetPurchaseSessionCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "purchaseSessionShippingRateUpdate":
					if let value = internalGetPurchaseSessionShippingRateUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "purchaseSessionUpdate":
					if let value = internalGetPurchaseSessionUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "shippingRatesRequestCreate":
					if let value = internalGetShippingRatesRequestCreate() {
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
