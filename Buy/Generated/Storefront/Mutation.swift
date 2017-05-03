// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class MutationQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Mutation

		open override var description: String {
			return "mutation" + super.description
		}

		@discardableResult
		open func checkoutAttributesUpdate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, input: CheckoutAttributesUpdateInput, _ subfields: (CheckoutAttributesUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutAttributesUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutAttributesUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCompleteFree(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, _ subfields: (CheckoutCompleteFreePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteFreePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteFree", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCompleteWithCreditCard(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, payment: CreditCardPaymentInput, _ subfields: (CheckoutCompleteWithCreditCardPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("payment:\(payment.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCompleteWithCreditCardPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCompleteWithCreditCard", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCompleteWithTokenizedPayment(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, payment: TokenizedPaymentInput, _ subfields: (CheckoutCompleteWithTokenizedPaymentPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("payment:\(payment.serialize())")

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
		open func checkoutCustomerAssociate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, customerAccessToken: String, _ subfields: (CheckoutCustomerAssociatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCustomerAssociatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCustomerAssociate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutCustomerDisassociate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, _ subfields: (CheckoutCustomerDisassociatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutCustomerDisassociatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutCustomerDisassociate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutEmailUpdate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, email: String, _ subfields: (CheckoutEmailUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("email:\(GraphQL.quoteString(input: email))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutEmailUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutEmailUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutGiftCardApply(aliasSuffix: String? = nil, giftCardCode: String, checkoutId: GraphQL.ID, _ subfields: (CheckoutGiftCardApplyPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("giftCardCode:\(GraphQL.quoteString(input: giftCardCode))")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutGiftCardApplyPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutGiftCardApply", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutGiftCardRemove(aliasSuffix: String? = nil, appliedGiftCardId: GraphQL.ID, checkoutId: GraphQL.ID, _ subfields: (CheckoutGiftCardRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("appliedGiftCardId:\(GraphQL.quoteString(input: "\(appliedGiftCardId.rawValue)"))")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutGiftCardRemovePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutGiftCardRemove", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutLineItemsAdd(aliasSuffix: String? = nil, lineItems: [CheckoutLineItemInput]? = nil, checkoutId: GraphQL.ID, _ subfields: (CheckoutLineItemsAddPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			if let lineItems = lineItems {
				args.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsAddPayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsAdd", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutLineItemsRemove(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, lineItemIds: [GraphQL.ID], _ subfields: (CheckoutLineItemsRemovePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("lineItemIds:[\(lineItemIds.map{ "\(GraphQL.quoteString(input: "\($0.rawValue)"))" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsRemovePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsRemove", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutLineItemsUpdate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, lineItems: [CheckoutLineItemUpdateInput], _ subfields: (CheckoutLineItemsUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutLineItemsUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutLineItemsUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutShippingAddressUpdate(aliasSuffix: String? = nil, shippingAddress: MailingAddressInput, checkoutId: GraphQL.ID, _ subfields: (CheckoutShippingAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("shippingAddress:\(shippingAddress.serialize())")

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CheckoutShippingAddressUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "checkoutShippingAddressUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkoutShippingLineUpdate(aliasSuffix: String? = nil, checkoutId: GraphQL.ID, shippingRateHandle: String, _ subfields: (CheckoutShippingLineUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			args.append("shippingRateHandle:\(GraphQL.quoteString(input: shippingRateHandle))")

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
		open func customerAccessTokenDelete(aliasSuffix: String? = nil, customerAccessToken: String, _ subfields: (CustomerAccessTokenDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAccessTokenRenew(aliasSuffix: String? = nil, customerAccessToken: String, _ subfields: (CustomerAccessTokenRenewPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAccessTokenRenewPayloadQuery()
			subfields(subquery)

			addField(field: "customerAccessTokenRenew", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerActivate(aliasSuffix: String? = nil, id: GraphQL.ID, input: CustomerActivateInput, _ subfields: (CustomerActivatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerActivatePayloadQuery()
			subfields(subquery)

			addField(field: "customerActivate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAddressCreate(aliasSuffix: String? = nil, customerAccessToken: String, address: MailingAddressInput, _ subfields: (CustomerAddressCreatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("address:\(address.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressCreatePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressCreate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAddressDelete(aliasSuffix: String? = nil, id: GraphQL.ID, customerAccessToken: String, _ subfields: (CustomerAddressDeletePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerAddressDeletePayloadQuery()
			subfields(subquery)

			addField(field: "customerAddressDelete", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerAddressUpdate(aliasSuffix: String? = nil, customerAccessToken: String, id: GraphQL.ID, address: MailingAddressInput, _ subfields: (CustomerAddressUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("address:\(address.serialize())")

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
		open func customerRecover(aliasSuffix: String? = nil, email: String, _ subfields: (CustomerRecoverPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("email:\(GraphQL.quoteString(input: email))")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerRecoverPayloadQuery()
			subfields(subquery)

			addField(field: "customerRecover", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerReset(aliasSuffix: String? = nil, id: GraphQL.ID, input: CustomerResetInput, _ subfields: (CustomerResetPayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			args.append("input:\(input.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerResetPayloadQuery()
			subfields(subquery)

			addField(field: "customerReset", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func customerUpdate(aliasSuffix: String? = nil, customerAccessToken: String, customer: CustomerUpdateInput, _ subfields: (CustomerUpdatePayloadQuery) -> Void) -> MutationQuery {
			var args: [String] = []

			args.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			args.append("customer:\(customer.serialize())")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = CustomerUpdatePayloadQuery()
			subfields(subquery)

			addField(field: "customerUpdate", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}
	}

	open class Mutation: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = MutationQuery

		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkoutAttributesUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutAttributesUpdatePayload(fields: value)

				case "checkoutCompleteFree":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCompleteFreePayload(fields: value)

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

				case "checkoutCustomerAssociate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCustomerAssociatePayload(fields: value)

				case "checkoutCustomerDisassociate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutCustomerDisassociatePayload(fields: value)

				case "checkoutEmailUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutEmailUpdatePayload(fields: value)

				case "checkoutGiftCardApply":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutGiftCardApplyPayload(fields: value)

				case "checkoutGiftCardRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutGiftCardRemovePayload(fields: value)

				case "checkoutLineItemsAdd":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsAddPayload(fields: value)

				case "checkoutLineItemsRemove":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsRemovePayload(fields: value)

				case "checkoutLineItemsUpdate":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CheckoutLineItemsUpdatePayload(fields: value)

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

		open var checkoutAttributesUpdate: Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate()
		}

		open func aliasedCheckoutAttributesUpdate(aliasSuffix: String) -> Storefront.CheckoutAttributesUpdatePayload? {
			return internalGetCheckoutAttributesUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutAttributesUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutAttributesUpdatePayload? {
			return field(field: "checkoutAttributesUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutAttributesUpdatePayload?
		}

		open var checkoutCompleteFree: Storefront.CheckoutCompleteFreePayload? {
			return internalGetCheckoutCompleteFree()
		}

		open func aliasedCheckoutCompleteFree(aliasSuffix: String) -> Storefront.CheckoutCompleteFreePayload? {
			return internalGetCheckoutCompleteFree(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCompleteFree(aliasSuffix: String? = nil) -> Storefront.CheckoutCompleteFreePayload? {
			return field(field: "checkoutCompleteFree", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCompleteFreePayload?
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

		open var checkoutCustomerAssociate: Storefront.CheckoutCustomerAssociatePayload? {
			return internalGetCheckoutCustomerAssociate()
		}

		open func aliasedCheckoutCustomerAssociate(aliasSuffix: String) -> Storefront.CheckoutCustomerAssociatePayload? {
			return internalGetCheckoutCustomerAssociate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCustomerAssociate(aliasSuffix: String? = nil) -> Storefront.CheckoutCustomerAssociatePayload? {
			return field(field: "checkoutCustomerAssociate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCustomerAssociatePayload?
		}

		open var checkoutCustomerDisassociate: Storefront.CheckoutCustomerDisassociatePayload? {
			return internalGetCheckoutCustomerDisassociate()
		}

		open func aliasedCheckoutCustomerDisassociate(aliasSuffix: String) -> Storefront.CheckoutCustomerDisassociatePayload? {
			return internalGetCheckoutCustomerDisassociate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutCustomerDisassociate(aliasSuffix: String? = nil) -> Storefront.CheckoutCustomerDisassociatePayload? {
			return field(field: "checkoutCustomerDisassociate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutCustomerDisassociatePayload?
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

		open var checkoutGiftCardApply: Storefront.CheckoutGiftCardApplyPayload? {
			return internalGetCheckoutGiftCardApply()
		}

		open func aliasedCheckoutGiftCardApply(aliasSuffix: String) -> Storefront.CheckoutGiftCardApplyPayload? {
			return internalGetCheckoutGiftCardApply(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutGiftCardApply(aliasSuffix: String? = nil) -> Storefront.CheckoutGiftCardApplyPayload? {
			return field(field: "checkoutGiftCardApply", aliasSuffix: aliasSuffix) as! Storefront.CheckoutGiftCardApplyPayload?
		}

		open var checkoutGiftCardRemove: Storefront.CheckoutGiftCardRemovePayload? {
			return internalGetCheckoutGiftCardRemove()
		}

		open func aliasedCheckoutGiftCardRemove(aliasSuffix: String) -> Storefront.CheckoutGiftCardRemovePayload? {
			return internalGetCheckoutGiftCardRemove(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutGiftCardRemove(aliasSuffix: String? = nil) -> Storefront.CheckoutGiftCardRemovePayload? {
			return field(field: "checkoutGiftCardRemove", aliasSuffix: aliasSuffix) as! Storefront.CheckoutGiftCardRemovePayload?
		}

		open var checkoutLineItemsAdd: Storefront.CheckoutLineItemsAddPayload? {
			return internalGetCheckoutLineItemsAdd()
		}

		open func aliasedCheckoutLineItemsAdd(aliasSuffix: String) -> Storefront.CheckoutLineItemsAddPayload? {
			return internalGetCheckoutLineItemsAdd(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutLineItemsAdd(aliasSuffix: String? = nil) -> Storefront.CheckoutLineItemsAddPayload? {
			return field(field: "checkoutLineItemsAdd", aliasSuffix: aliasSuffix) as! Storefront.CheckoutLineItemsAddPayload?
		}

		open var checkoutLineItemsRemove: Storefront.CheckoutLineItemsRemovePayload? {
			return internalGetCheckoutLineItemsRemove()
		}

		open func aliasedCheckoutLineItemsRemove(aliasSuffix: String) -> Storefront.CheckoutLineItemsRemovePayload? {
			return internalGetCheckoutLineItemsRemove(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutLineItemsRemove(aliasSuffix: String? = nil) -> Storefront.CheckoutLineItemsRemovePayload? {
			return field(field: "checkoutLineItemsRemove", aliasSuffix: aliasSuffix) as! Storefront.CheckoutLineItemsRemovePayload?
		}

		open var checkoutLineItemsUpdate: Storefront.CheckoutLineItemsUpdatePayload? {
			return internalGetCheckoutLineItemsUpdate()
		}

		open func aliasedCheckoutLineItemsUpdate(aliasSuffix: String) -> Storefront.CheckoutLineItemsUpdatePayload? {
			return internalGetCheckoutLineItemsUpdate(aliasSuffix: aliasSuffix)
		}

		func internalGetCheckoutLineItemsUpdate(aliasSuffix: String? = nil) -> Storefront.CheckoutLineItemsUpdatePayload? {
			return field(field: "checkoutLineItemsUpdate", aliasSuffix: aliasSuffix) as! Storefront.CheckoutLineItemsUpdatePayload?
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
				case "checkoutAttributesUpdate":

				return .Object

				case "checkoutCompleteFree":

				return .Object

				case "checkoutCompleteWithCreditCard":

				return .Object

				case "checkoutCompleteWithTokenizedPayment":

				return .Object

				case "checkoutCreate":

				return .Object

				case "checkoutCustomerAssociate":

				return .Object

				case "checkoutCustomerDisassociate":

				return .Object

				case "checkoutEmailUpdate":

				return .Object

				case "checkoutGiftCardApply":

				return .Object

				case "checkoutGiftCardRemove":

				return .Object

				case "checkoutLineItemsAdd":

				return .Object

				case "checkoutLineItemsRemove":

				return .Object

				case "checkoutLineItemsUpdate":

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
				case "checkoutAttributesUpdate":
				return internalGetCheckoutAttributesUpdate()

				case "checkoutCompleteFree":
				return internalGetCheckoutCompleteFree()

				case "checkoutCompleteWithCreditCard":
				return internalGetCheckoutCompleteWithCreditCard()

				case "checkoutCompleteWithTokenizedPayment":
				return internalGetCheckoutCompleteWithTokenizedPayment()

				case "checkoutCreate":
				return internalGetCheckoutCreate()

				case "checkoutCustomerAssociate":
				return internalGetCheckoutCustomerAssociate()

				case "checkoutCustomerDisassociate":
				return internalGetCheckoutCustomerDisassociate()

				case "checkoutEmailUpdate":
				return internalGetCheckoutEmailUpdate()

				case "checkoutGiftCardApply":
				return internalGetCheckoutGiftCardApply()

				case "checkoutGiftCardRemove":
				return internalGetCheckoutGiftCardRemove()

				case "checkoutLineItemsAdd":
				return internalGetCheckoutLineItemsAdd()

				case "checkoutLineItemsRemove":
				return internalGetCheckoutLineItemsRemove()

				case "checkoutLineItemsUpdate":
				return internalGetCheckoutLineItemsUpdate()

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
					case "checkoutAttributesUpdate":
					if let value = internalGetCheckoutAttributesUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCompleteFree":
					if let value = internalGetCheckoutCompleteFree() {
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

					case "checkoutCustomerAssociate":
					if let value = internalGetCheckoutCustomerAssociate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutCustomerDisassociate":
					if let value = internalGetCheckoutCustomerDisassociate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutEmailUpdate":
					if let value = internalGetCheckoutEmailUpdate() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutGiftCardApply":
					if let value = internalGetCheckoutGiftCardApply() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutGiftCardRemove":
					if let value = internalGetCheckoutGiftCardRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsAdd":
					if let value = internalGetCheckoutLineItemsAdd() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsRemove":
					if let value = internalGetCheckoutLineItemsRemove() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkoutLineItemsUpdate":
					if let value = internalGetCheckoutLineItemsUpdate() {
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
