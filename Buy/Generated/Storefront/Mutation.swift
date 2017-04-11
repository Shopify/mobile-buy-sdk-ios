// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class MutationQuery: GraphQL.AbstractQuery {
		open override var description: String {
			return "mutation" + super.description
		}

		@discardableResult
		open func checkoutAddLineItems(aliasSuffix: String? = nil, input: CheckoutAddLineItemsInput, _ subfields: (CheckoutAddLineItemsPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutAddLineItemsPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutAddLineItems", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutAttributesUpdate(aliasSuffix: String? = nil, input: CheckoutAttributesUpdateInput, _ subfields: (CheckoutAttributesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutAttributesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutAttributesUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCompleteWithCreditCard(aliasSuffix: String? = nil, input: CheckoutCompleteWithCreditCardInput, _ subfields: (CheckoutCompleteWithCreditCardPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteWithCreditCardPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteWithCreditCard", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCompleteWithTokenizedPayment(aliasSuffix: String? = nil, input: CheckoutCompleteWithTokenizedPaymentInput, _ subfields: (CheckoutCompleteWithTokenizedPaymentPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteWithTokenizedPaymentPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteWithTokenizedPayment", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCreate(aliasSuffix: String? = nil, input: CheckoutCreateInput, _ subfields: (CheckoutCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCreatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutEmailUpdate(aliasSuffix: String? = nil, input: CheckoutEmailUpdateInput, _ subfields: (CheckoutEmailUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutEmailUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutEmailUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutShippingAddressUpdate(aliasSuffix: String? = nil, input: CheckoutShippingAddressUpdateInput, _ subfields: (CheckoutShippingAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutShippingAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutShippingAddressUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutShippingLineUpdate(aliasSuffix: String? = nil, input: CheckoutShippingLineUpdateInput, _ subfields: (CheckoutShippingLineUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutShippingLineUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutShippingLineUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAccessTokenCreate(aliasSuffix: String? = nil, input: CustomerAccessTokenCreateInput, _ subfields: (CustomerAccessTokenCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAccessTokenDelete(aliasSuffix: String? = nil, input: CustomerAccessTokenDeleteInput, _ subfields: (CustomerAccessTokenDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAccessTokenRenew(aliasSuffix: String? = nil, input: CustomerAccessTokenRenewInput, _ subfields: (CustomerAccessTokenRenewPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenRenewPayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenRenew", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
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
		open func customerAddressCreate(aliasSuffix: String? = nil, input: CustomerAddressCreateInput, _ subfields: (CustomerAddressCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAddressDelete(aliasSuffix: String? = nil, input: CustomerAddressDeleteInput, _ subfields: (CustomerAddressDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAddressUpdate(aliasSuffix: String? = nil, input: CustomerAddressUpdateInput, _ subfields: (CustomerAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerCreate(aliasSuffix: String? = nil, input: CustomerCreateInput, _ subfields: (CustomerCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
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
		open func customerUpdate(aliasSuffix: String? = nil, input: CustomerUpdateInput, _ subfields: (CustomerUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}
	}

	open class Mutation: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutAddLineItems":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutAddLineItemsPayload(fields: value)

				case "checkoutAttributesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutAttributesUpdatePayload(fields: value)

				case "checkoutCompleteWithCreditCard":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteWithCreditCardPayload(fields: value)

				case "checkoutCompleteWithTokenizedPayment":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteWithTokenizedPaymentPayload(fields: value)

				case "checkoutCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCreatePayload(fields: value)

				case "checkoutEmailUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutEmailUpdatePayload(fields: value)

				case "checkoutShippingAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutShippingAddressUpdatePayload(fields: value)

				case "checkoutShippingLineUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutShippingLineUpdatePayload(fields: value)

				case "customerAccessTokenCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenCreatePayload(fields: value)

				case "customerAccessTokenDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenDeletePayload(fields: value)

				case "customerAccessTokenRenew":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAccessTokenRenewPayload(fields: value)

				case "customerActivate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerActivatePayload(fields: value)

				case "customerAddressCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressCreatePayload(fields: value)

				case "customerAddressDelete":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressDeletePayload(fields: value)

				case "customerAddressUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerAddressUpdatePayload(fields: value)

				case "customerCreate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CustomerCreatePayload(fields: value)

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

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Mutation" }

		open var checkoutAddLineItems: Storefront.CheckoutAddLineItemsPayload? {
			return internalGetCheckoutAddLineItems()
		}

		open func aliasedCheckoutAddLineItems(aliasSuffix: String) -> Storefront.CheckoutAddLineItemsPayload? {
			return internalGetCheckoutAddLineItems(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutAddLineItems(aliasSuffix: String? = nil) -> Storefront.CheckoutAddLineItemsPayload? {
			return field(field: "checkoutAddLineItems", aliasSuffix: aliasSuffix) as! Storefront.CheckoutAddLineItemsPayload?
		}

		open var checkoutAttributesUpdate: Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate()
		}

		open func aliasedCheckoutAttributesUpdate(aliasSuffix: String) -> Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutAttributesUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutAttributesUpdatePayload? {
			return field(field: "checkoutAttributesUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutAttributesUpdatePayload?
		}

		open var checkoutCompleteWithCreditCard: Storefront.CheckoutCompleteWithCreditCardPayload? {
			return internalGetCheckoutCompleteWithCreditCard()
		}

		open func aliasedCheckoutCompleteWithCreditCard(aliasSuffix: String) -> Storefront.CheckoutCompleteWithCreditCardPayload? {
			return internalGetCheckoutCompleteWithCreditCard(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCompleteWithCreditCard(aliasSuffix: String? = nil) -> Storefront.CheckoutCompleteWithCreditCardPayload? {
			return field(field: "checkoutCompleteWithCreditCard", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCompleteWithCreditCardPayload?
		}

		open var checkoutCompleteWithTokenizedPayment: Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return internalGetCheckoutCompleteWithTokenizedPayment()
		}

		open func aliasedCheckoutCompleteWithTokenizedPayment(aliasSuffix: String) -> Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return internalGetCheckoutCompleteWithTokenizedPayment(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCompleteWithTokenizedPayment(aliasSuffix: String? = nil) -> Storefront.CheckoutCompleteWithTokenizedPaymentPayload? {
			return field(field: "checkoutCompleteWithTokenizedPayment", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCompleteWithTokenizedPaymentPayload?
		}

		open var checkoutCreate: Storefront.CheckoutCreatePayload? {
			return internalGetCheckoutCreate()
		}

		open func aliasedCheckoutCreate(aliasSuffix: String) -> Storefront.CheckoutCreatePayload? {
			return internalGetCheckoutCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCreate(aliasSuffix: String? = nil) -> Storefront.CheckoutCreatePayload? {
			return field(field: "checkoutCreate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCreatePayload?
		}

		open var checkoutEmailUpdate: Storefront.CheckoutEmailUpdatePayload? {
			return internalGetCheckoutEmailUpdate()
		}

		open func aliasedCheckoutEmailUpdate(aliasSuffix: String) -> Storefront.CheckoutEmailUpdatePayload? {
			return internalGetCheckoutEmailUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutEmailUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutEmailUpdatePayload? {
			return field(field: "checkoutEmailUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutEmailUpdatePayload?
		}

		open var checkoutShippingAddressUpdate: Storefront.CheckoutShippingAddressUpdatePayload? {
			return internalGetCheckoutShippingAddressUpdate()
		}

		open func aliasedCheckoutShippingAddressUpdate(aliasSuffix: String) -> Storefront.CheckoutShippingAddressUpdatePayload? {
			return internalGetCheckoutShippingAddressUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutShippingAddressUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutShippingAddressUpdatePayload? {
			return field(field: "checkoutShippingAddressUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutShippingAddressUpdatePayload?
		}

		open var checkoutShippingLineUpdate: Storefront.CheckoutShippingLineUpdatePayload? {
			return internalGetCheckoutShippingLineUpdate()
		}

		open func aliasedCheckoutShippingLineUpdate(aliasSuffix: String) -> Storefront.CheckoutShippingLineUpdatePayload? {
			return internalGetCheckoutShippingLineUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutShippingLineUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutShippingLineUpdatePayload? {
			return field(field: "checkoutShippingLineUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutShippingLineUpdatePayload?
		}

		open var customerAccessTokenCreate: Storefront.CustomerAccessTokenCreatePayload? {
			return internalGetCustomerAccessTokenCreate()
		}

		open func aliasedCustomerAccessTokenCreate(aliasSuffix: String) -> Storefront.CustomerAccessTokenCreatePayload? {
			return internalGetCustomerAccessTokenCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAccessTokenCreate(aliasSuffix: String? = nil) -> Storefront.CustomerAccessTokenCreatePayload? {
			return field(field: "customerAccessTokenCreate", aliasSuffix: aliasSuffix) as! Storefront.CustomerAccessTokenCreatePayload?
		}

		open var customerAccessTokenDelete: Storefront.CustomerAccessTokenDeletePayload? {
			return internalGetCustomerAccessTokenDelete()
		}

		open func aliasedCustomerAccessTokenDelete(aliasSuffix: String) -> Storefront.CustomerAccessTokenDeletePayload? {
			return internalGetCustomerAccessTokenDelete(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAccessTokenDelete(aliasSuffix: String? = nil) -> Storefront.CustomerAccessTokenDeletePayload? {
			return field(field: "customerAccessTokenDelete", aliasSuffix: aliasSuffix) as! Storefront.CustomerAccessTokenDeletePayload?
		}

		open var customerAccessTokenRenew: Storefront.CustomerAccessTokenRenewPayload? {
			return internalGetCustomerAccessTokenRenew()
		}

		open func aliasedCustomerAccessTokenRenew(aliasSuffix: String) -> Storefront.CustomerAccessTokenRenewPayload? {
			return internalGetCustomerAccessTokenRenew(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAccessTokenRenew(aliasSuffix: String? = nil) -> Storefront.CustomerAccessTokenRenewPayload? {
			return field(field: "customerAccessTokenRenew", aliasSuffix: aliasSuffix) as! Storefront.CustomerAccessTokenRenewPayload?
		}

		open var customerActivate: Storefront.CustomerActivatePayload? {
			return internalGetCustomerActivate()
		}

		open func aliasedCustomerActivate(aliasSuffix: String) -> Storefront.CustomerActivatePayload? {
			return internalGetCustomerActivate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerActivate(aliasSuffix: String? = nil) -> Storefront.CustomerActivatePayload? {
			return field(field: "customerActivate", aliasSuffix: aliasSuffix) as! Storefront.CustomerActivatePayload?
		}

		open var customerAddressCreate: Storefront.CustomerAddressCreatePayload? {
			return internalGetCustomerAddressCreate()
		}

		open func aliasedCustomerAddressCreate(aliasSuffix: String) -> Storefront.CustomerAddressCreatePayload? {
			return internalGetCustomerAddressCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAddressCreate(aliasSuffix: String? = nil) -> Storefront.CustomerAddressCreatePayload? {
			return field(field: "customerAddressCreate", aliasSuffix: aliasSuffix) as! Storefront.CustomerAddressCreatePayload?
		}

		open var customerAddressDelete: Storefront.CustomerAddressDeletePayload? {
			return internalGetCustomerAddressDelete()
		}

		open func aliasedCustomerAddressDelete(aliasSuffix: String) -> Storefront.CustomerAddressDeletePayload? {
			return internalGetCustomerAddressDelete(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAddressDelete(aliasSuffix: String? = nil) -> Storefront.CustomerAddressDeletePayload? {
			return field(field: "customerAddressDelete", aliasSuffix: aliasSuffix) as! Storefront.CustomerAddressDeletePayload?
		}

		open var customerAddressUpdate: Storefront.CustomerAddressUpdatePayload? {
			return internalGetCustomerAddressUpdate()
		}

		open func aliasedCustomerAddressUpdate(aliasSuffix: String) -> Storefront.CustomerAddressUpdatePayload? {
			return internalGetCustomerAddressUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerAddressUpdate(aliasSuffix: String? = nil) -> Storefront.CustomerAddressUpdatePayload? {
			return field(field: "customerAddressUpdate", aliasSuffix: aliasSuffix) as! Storefront.CustomerAddressUpdatePayload?
		}

		open var customerCreate: Storefront.CustomerCreatePayload? {
			return internalGetCustomerCreate()
		}

		open func aliasedCustomerCreate(aliasSuffix: String) -> Storefront.CustomerCreatePayload? {
			return internalGetCustomerCreate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerCreate(aliasSuffix: String? = nil) -> Storefront.CustomerCreatePayload? {
			return field(field: "customerCreate", aliasSuffix: aliasSuffix) as! Storefront.CustomerCreatePayload?
		}

		open var customerRecover: Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover()
		}

		open func aliasedCustomerRecover(aliasSuffix: String) -> Storefront.CustomerRecoverPayload? {
			return internalGetCustomerRecover(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerRecover(aliasSuffix: String? = nil) -> Storefront.CustomerRecoverPayload? {
			return field(field: "customerRecover", aliasSuffix: aliasSuffix) as! Storefront.CustomerRecoverPayload?
		}

		open var customerReset: Storefront.CustomerResetPayload? {
			return internalGetCustomerReset()
		}

		open func aliasedCustomerReset(aliasSuffix: String) -> Storefront.CustomerResetPayload? {
			return internalGetCustomerReset(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerReset(aliasSuffix: String? = nil) -> Storefront.CustomerResetPayload? {
			return field(field: "customerReset", aliasSuffix: aliasSuffix) as! Storefront.CustomerResetPayload?
		}

		open var customerUpdate: Storefront.CustomerUpdatePayload? {
			return internalGetCustomerUpdate()
		}

		open func aliasedCustomerUpdate(aliasSuffix: String) -> Storefront.CustomerUpdatePayload? {
			return internalGetCustomerUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCustomerUpdate(aliasSuffix: String? = nil) -> Storefront.CustomerUpdatePayload? {
			return field(field: "customerUpdate", aliasSuffix: aliasSuffix) as! Storefront.CustomerUpdatePayload?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "checkoutAddLineItems":

				return .Object

				case "checkoutAttributesUpdate":

				return .Object

				case "checkoutCompleteWithCreditCard":

				return .Object

				case "checkoutCompleteWithTokenizedPayment":

				return .Object

				case "checkoutCreate":

				return .Object

				case "checkoutEmailUpdate":

				return .Object

				case "checkoutShippingAddressUpdate":

				return .Object

				case "checkoutShippingLineUpdate":

				return .Object

				case "customerAccessTokenCreate":

				return .Object

				case "customerAccessTokenDelete":

				return .Object

				case "customerAccessTokenRenew":

				return .Object

				case "customerActivate":

				return .Object

				case "customerAddressCreate":

				return .Object

				case "customerAddressDelete":

				return .Object

				case "customerAddressUpdate":

				return .Object

				case "customerCreate":

				return .Object

				case "customerRecover":

				return .Object

				case "customerReset":

				return .Object

				case "customerUpdate":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "checkoutAddLineItems":
				return internalGetCheckoutAddLineItems()

				case "checkoutAttributesUpdate":
				return internalGetCheckoutAttributesUpdate()

				case "checkoutCompleteWithCreditCard":
				return internalGetCheckoutCompleteWithCreditCard()

				case "checkoutCompleteWithTokenizedPayment":
				return internalGetCheckoutCompleteWithTokenizedPayment()

				case "checkoutCreate":
				return internalGetCheckoutCreate()

				case "checkoutEmailUpdate":
				return internalGetCheckoutEmailUpdate()

				case "checkoutShippingAddressUpdate":
				return internalGetCheckoutShippingAddressUpdate()

				case "checkoutShippingLineUpdate":
				return internalGetCheckoutShippingLineUpdate()

				case "customerAccessTokenCreate":
				return internalGetCustomerAccessTokenCreate()

				case "customerAccessTokenDelete":
				return internalGetCustomerAccessTokenDelete()

				case "customerAccessTokenRenew":
				return internalGetCustomerAccessTokenRenew()

				case "customerActivate":
				return internalGetCustomerActivate()

				case "customerAddressCreate":
				return internalGetCustomerAddressCreate()

				case "customerAddressDelete":
				return internalGetCustomerAddressDelete()

				case "customerAddressUpdate":
				return internalGetCustomerAddressUpdate()

				case "customerCreate":
				return internalGetCustomerCreate()

				case "customerRecover":
				return internalGetCustomerRecover()

				case "customerReset":
				return internalGetCustomerReset()

				case "customerUpdate":
				return internalGetCustomerUpdate()

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
					case "checkoutAddLineItems":
					if let value = internalGetCheckoutAddLineItems() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutAttributesUpdate":
					if let value = internalGetCheckoutAttributesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteWithCreditCard":
					if let value = internalGetCheckoutCompleteWithCreditCard() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteWithTokenizedPayment":
					if let value = internalGetCheckoutCompleteWithTokenizedPayment() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCreate":
					if let value = internalGetCheckoutCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutEmailUpdate":
					if let value = internalGetCheckoutEmailUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutShippingAddressUpdate":
					if let value = internalGetCheckoutShippingAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutShippingLineUpdate":
					if let value = internalGetCheckoutShippingLineUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenCreate":
					if let value = internalGetCustomerAccessTokenCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenDelete":
					if let value = internalGetCustomerAccessTokenDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAccessTokenRenew":
					if let value = internalGetCustomerAccessTokenRenew() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerActivate":
					if let value = internalGetCustomerActivate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressCreate":
					if let value = internalGetCustomerAddressCreate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressDelete":
					if let value = internalGetCustomerAddressDelete() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerAddressUpdate":
					if let value = internalGetCustomerAddressUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "customerCreate":
					if let value = internalGetCustomerCreate() {
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
