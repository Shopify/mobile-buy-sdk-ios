// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class PaymentQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func amount(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "amount", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func billingAddress(aliasSuffix: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> PaymentQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "billingAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func checkout(aliasSuffix: String? = nil, _ subfields: (CheckoutQuery) -> Void) -> PaymentQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)

			addField(field: "checkout", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func creditCard(aliasSuffix: String? = nil, _ subfields: (CreditCardQuery) -> Void) -> PaymentQuery {
			let subquery = CreditCardQuery()
			subfields(subquery)

			addField(field: "creditCard", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func errorMessage(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "errorMessage", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func idempotencyKey(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "idempotencyKey", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func ready(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "ready", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func test(aliasSuffix: String? = nil) -> PaymentQuery {
			addField(field: "test", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func transaction(aliasSuffix: String? = nil, _ subfields: (TransactionQuery) -> Void) -> PaymentQuery {
			let subquery = TransactionQuery()
			subfields(subquery)

			addField(field: "transaction", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class Payment: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "billingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "checkout":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Checkout(fields: value)

				case "creditCard":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CreditCard(fields: value)

				case "errorMessage":
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

				case "idempotencyKey":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "ready":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "test":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "transaction":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Transaction(fields: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Payment" }

		open var amount: Decimal {
			return internalGetAmount()
		}

		func internalGetAmount(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "amount", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var billingAddress: Storefront.MailingAddress? {
			return internalGetBillingAddress()
		}

		func internalGetBillingAddress(aliasSuffix: String? = nil) -> Storefront.MailingAddress? {
			return field(field: "billingAddress", aliasSuffix: aliasSuffix) as! Storefront.MailingAddress?
		}

		open var checkout: Storefront.Checkout {
			return internalGetCheckout()
		}

		func internalGetCheckout(aliasSuffix: String? = nil) -> Storefront.Checkout {
			return field(field: "checkout", aliasSuffix: aliasSuffix) as! Storefront.Checkout
		}

		open var creditCard: Storefront.CreditCard? {
			return internalGetCreditCard()
		}

		func internalGetCreditCard(aliasSuffix: String? = nil) -> Storefront.CreditCard? {
			return field(field: "creditCard", aliasSuffix: aliasSuffix) as! Storefront.CreditCard?
		}

		open var errorMessage: String? {
			return internalGetErrorMessage()
		}

		func internalGetErrorMessage(aliasSuffix: String? = nil) -> String? {
			return field(field: "errorMessage", aliasSuffix: aliasSuffix) as! String?
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var idempotencyKey: String? {
			return internalGetIdempotencyKey()
		}

		func internalGetIdempotencyKey(aliasSuffix: String? = nil) -> String? {
			return field(field: "idempotencyKey", aliasSuffix: aliasSuffix) as! String?
		}

		open var ready: Bool {
			return internalGetReady()
		}

		func internalGetReady(aliasSuffix: String? = nil) -> Bool {
			return field(field: "ready", aliasSuffix: aliasSuffix) as! Bool
		}

		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(aliasSuffix: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: aliasSuffix) as! Bool
		}

		open var transaction: Storefront.Transaction? {
			return internalGetTransaction()
		}

		func internalGetTransaction(aliasSuffix: String? = nil) -> Storefront.Transaction? {
			return field(field: "transaction", aliasSuffix: aliasSuffix) as! Storefront.Transaction?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "amount":

				return .Scalar

				case "billingAddress":

				return .Object

				case "checkout":

				return .Object

				case "creditCard":

				return .Object

				case "errorMessage":

				return .Scalar

				case "id":

				return .Scalar

				case "idempotencyKey":

				return .Scalar

				case "ready":

				return .Scalar

				case "test":

				return .Scalar

				case "transaction":

				return .Object

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "billingAddress":
				return internalGetBillingAddress()

				case "checkout":
				return internalGetCheckout()

				case "creditCard":
				return internalGetCreditCard()

				case "transaction":
				return internalGetTransaction()

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
					if let value = internalGetBillingAddress() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "checkout":
					response.append(internalGetCheckout())
					response.append(contentsOf: internalGetCheckout().childResponseObjectMap())

					case "creditCard":
					if let value = internalGetCreditCard() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "transaction":
					if let value = internalGetTransaction() {
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
